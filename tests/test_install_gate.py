# -*- coding: utf-8 -*-
"""導入スクリプトの「門の版の固定」（-GateManifest・-Update・-Check）を、手元に作った送り元で確かめる。

送り元は一時フォルダの中に作る 2 つのリポジトリ（設定のリポジトリと道具のリポジトリ）。ネットワークは使わない。
PowerShell 7（pwsh）が無い環境では飛ばす。
"""
from __future__ import annotations

import json
import os
import shutil
import subprocess
import unittest
from pathlib import Path

from fixture_root import make_unique_directory, remove_tree, session_dir
from test_install_run import INSTALLER, PWSH, unlink_links

GIT_ENV = {
    **os.environ,
    "GIT_AUTHOR_NAME": "fixture", "GIT_AUTHOR_EMAIL": "synthetic.fixture@example.com",
    "GIT_COMMITTER_NAME": "fixture", "GIT_COMMITTER_EMAIL": "synthetic.fixture@example.com",
}


def git(repo: Path, *args: str) -> str:
    p = subprocess.run(["git", "-C", str(repo), *args], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                       text=True, encoding="utf-8", errors="replace", env=GIT_ENV)
    assert p.returncode == 0, p.stderr
    return p.stdout.strip()


def write(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8", newline="\n")


@unittest.skipUnless(PWSH, "pwsh が無い")
class GatePinningTest(unittest.TestCase):
    def setUp(self):
        self.base = Path(make_unique_directory(session_dir(), "gate-"))
        self.addCleanup(remove_tree, self.base)
        self.home = self.base / "home"
        self.home.mkdir()
        self.addCleanup(unlink_links, self.home)

        self.tool_origin = self.base / "tool-origin"
        self.tool_origin.mkdir()
        git(self.tool_origin, "init", "-q", "-b", "main")
        write(self.tool_origin / "environment" / "AGENTS.md", "# Shared rules\n")
        write(self.tool_origin / "skills" / "demo" / "SKILL.md", "---\nname: demo\ndescription: v1\n---\n")
        self.first = self.commit(self.tool_origin, "tool v1")

        self.policy_origin = self.base / "policy-origin"
        self.policy_origin.mkdir()
        git(self.policy_origin, "init", "-q", "-b", "main")
        write(self.policy_origin / "config" / "git-publish-policy.json", "{}\n")
        self.pin(self.first)

        self.manifest = self.base / "gate.json"
        self.manifest.write_text(json.dumps({
            "pinned_root": str(self.home / "pinned"),
            "policy_repository": {"name": "policy", "url": str(self.policy_origin), "branch": "main",
                                  "pins_file": "config/gate-pins.json"},
            "tool_repository": {"name": "tool", "url": str(self.tool_origin), "pin_key": "tool"},
            "environment": {"GATE_TEST_POLICY": "{policy}/config/git-publish-policy.json"},
        }), encoding="utf-8")
        self.pinned_tool = self.home / "pinned" / "tool"

    def commit(self, repo: Path, message: str) -> str:
        git(repo, "add", "-A")
        git(repo, "commit", "-q", "-m", message)
        return git(repo, "rev-parse", "HEAD")

    def pin(self, sha: str) -> str:
        write(self.policy_origin / "config" / "gate-pins.json", json.dumps({"tool": {"sha": sha}}) + "\n")
        return self.commit(self.policy_origin, "pin " + sha[:12])

    def run_installer(self, *args: str) -> subprocess.CompletedProcess:
        return subprocess.run(
            [PWSH, "-NoProfile", "-File", str(INSTALLER), "-HomeRoot", str(self.home),
             "-GateManifest", str(self.manifest), "-EnvironmentTarget", "None", *args],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, encoding="utf-8", errors="replace",
        )

    def install(self) -> None:
        done = self.run_installer()
        self.assertEqual(done.returncode, 0, done.stdout + done.stderr)

    def test_skills_come_from_the_pinned_copy_not_the_working_clone(self):
        self.install()
        self.assertEqual(git(self.pinned_tool, "rev-parse", "HEAD"), self.first)
        link = self.home / ".claude" / "skills" / "demo"
        self.assertEqual(os.path.normcase(os.path.realpath(link)),
                         os.path.normcase(os.path.realpath(self.pinned_tool / "skills" / "demo")))
        imports = [line[1:] for line in (self.home / ".claude" / "CLAUDE.md").read_text(encoding="utf-8").splitlines()
                   if line.startswith("@")]
        self.assertTrue(any(os.path.samefile(p, self.pinned_tool / "environment" / "AGENTS.md") for p in imports),
                        imports)

        check = self.run_installer("-Check")
        self.assertEqual(check.returncode, 0, check.stdout + check.stderr)

    def test_check_reports_a_stale_copy_and_update_moves_to_the_new_pin(self):
        self.install()
        write(self.tool_origin / "skills" / "demo" / "SKILL.md", "---\nname: demo\ndescription: v2\n---\n")
        second = self.commit(self.tool_origin, "tool v2")
        self.pin(second)

        stale = self.run_installer("-Check")
        self.assertEqual(stale.returncode, 1, stale.stdout + stale.stderr)
        self.assertIn("origin/main", stale.stdout + stale.stderr)

        updated = self.run_installer("-Update")
        self.assertEqual(updated.returncode, 0, updated.stdout + updated.stderr)
        self.assertEqual(git(self.pinned_tool, "rev-parse", "HEAD"), second)
        self.assertIn("v2", (self.home / ".claude" / "skills" / "demo" / "SKILL.md").read_text(encoding="utf-8"))

        check = self.run_installer("-Check")
        self.assertEqual(check.returncode, 0, check.stdout + check.stderr)

    def test_local_changes_in_the_pinned_copy_are_reported_and_kept(self):
        self.install()
        edited = self.pinned_tool / "skills" / "demo" / "SKILL.md"
        edited.write_text("edited by hand\n", encoding="utf-8")

        check = self.run_installer("-Check")
        self.assertEqual(check.returncode, 1, check.stdout + check.stderr)
        self.assertIn("local changes", check.stdout + check.stderr)

        refused = self.run_installer("-Update")
        self.assertEqual(refused.returncode, 2, refused.stdout + refused.stderr)
        self.assertEqual(edited.read_text(encoding="utf-8"), "edited by hand\n")

    def test_working_clone_branch_does_not_change_the_pinned_copy(self):
        self.install()
        git(self.tool_origin, "checkout", "-q", "-b", "someone-elses-work")
        write(self.tool_origin / "skills" / "demo" / "SKILL.md", "---\nname: demo\ndescription: wip\n---\n")
        self.commit(self.tool_origin, "work in progress")

        check = self.run_installer("-Check")
        self.assertEqual(check.returncode, 0, check.stdout + check.stderr)
        self.assertIn("v1", (self.home / ".claude" / "skills" / "demo" / "SKILL.md").read_text(encoding="utf-8"))


if __name__ == "__main__":
    unittest.main()
