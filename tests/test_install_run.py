# -*- coding: utf-8 -*-
"""導入スクリプトを一時フォルダのホームへ実際に走らせ、入った結果を確かめる。

PowerShell 7（pwsh）が無い環境では飛ばす。GitHub の Linux の実行環境には pwsh がある。
"""
from __future__ import annotations

import os
import shutil
import subprocess
import unittest
from pathlib import Path

from fixture_root import make_unique_directory, remove_tree, session_dir

REPO_ROOT = Path(__file__).resolve().parents[1]
INSTALLER = REPO_ROOT / "environment" / "install.ps1"
PWSH = shutil.which("pwsh")
SKILL_DIRS = (".claude/skills", ".agents/skills")


def shared_skills() -> list[str]:
    return sorted(p.name for p in (REPO_ROOT / "skills").iterdir() if (p / "SKILL.md").is_file())


def unlink_links(home: Path) -> None:
    """片付けの前にリンクだけを外す。リンクを辿ってリポジトリの skill を消さないため。"""
    for rel in SKILL_DIRS:
        root = home / rel
        if not root.is_dir():
            continue
        for entry in root.iterdir():
            if entry.is_symlink():
                entry.unlink()
            elif getattr(os.path, "isjunction", lambda _p: False)(entry):
                os.rmdir(entry)  # ジャンクションだけを外す。リンク先は消えない


@unittest.skipUnless(PWSH, "pwsh が無い")
class InstallerRunTest(unittest.TestCase):
    def setUp(self):
        self.home = Path(make_unique_directory(session_dir(), "install-"))
        self.addCleanup(remove_tree, self.home)
        self.addCleanup(unlink_links, self.home)

    def run_installer(self, *args: str) -> subprocess.CompletedProcess:
        return subprocess.run(
            [PWSH, "-NoProfile", "-File", str(INSTALLER), "-HomeRoot", str(self.home), *args],
            # 日本語の Windows では、警告がコンソールの文字コード（CP932）で出る。読めない字は置き換える。
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, encoding="utf-8", errors="replace",
        )

    def test_install_links_every_skill_and_then_checks_clean(self):
        overlay = self.home / "private" / "AGENTS.md"
        overlay.parent.mkdir()
        overlay.write_text("# Private overlay\nlocal note\n", encoding="utf-8")

        done = self.run_installer("-PrivateOverlay", str(overlay))
        self.assertEqual(done.returncode, 0, done.stdout + done.stderr)

        imports = [line for line in (self.home / ".claude" / "CLAUDE.md").read_text(encoding="utf-8").splitlines()
                   if line.startswith("@")]
        self.assertEqual(len(imports), 2)
        for line in imports:
            self.assertNotIn("\\", line, "Claude Code は「\\」区切りのパスの読み込みを解決しない")
        self.assertIn("local note", (self.home / ".codex" / "AGENTS.md").read_text(encoding="utf-8"))

        for name in shared_skills():
            with self.subTest(skill=name):
                self.assertTrue((self.home / ".claude" / "skills" / name / "SKILL.md").is_file())
        self.assertFalse((self.home / ".agents" / "skills" / "codex-implement").exists(),
                         "codex-implement は Codex に入れない")

        check = self.run_installer("-PrivateOverlay", str(overlay), "-Check")
        self.assertEqual(check.returncode, 0, check.stdout + check.stderr)

    def test_own_instruction_file_is_left_alone(self):
        own = self.home / ".claude" / "CLAUDE.md"
        own.parent.mkdir(parents=True)
        own.write_text("my own notes\n", encoding="utf-8")

        done = self.run_installer()
        self.assertEqual(done.returncode, 2, done.stdout + done.stderr)
        self.assertEqual(own.read_text(encoding="utf-8"), "my own notes\n")


if __name__ == "__main__":
    unittest.main()
