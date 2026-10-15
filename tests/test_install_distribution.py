# -*- coding: utf-8 -*-
"""導入スクリプトが配る skill と、runtime ごとの除外の宣言を検査する。

導入スクリプトは `skills/` の下で `SKILL.md` を持つフォルダを全部配る。skill を足したときに
配り忘れることは起きないが、名前と `SKILL.md` の `name` がずれた skill や、存在しない skill を
除外に書いた宣言は配布の誤りになる。**導入スクリプトを実行せずに、宣言とファイルだけを読む。**
実際にリンクが張られるかは環境に依存するため、ここでは扱わない。
"""
from __future__ import annotations

import re
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
INSTALLER = REPO_ROOT / "environment" / "install.ps1"
SHARED_RULES = REPO_ROOT / "environment" / "AGENTS.md"
SKILLS = REPO_ROOT / "skills"

EXCLUSION_BLOCK = re.compile(r"\$skillRuntimeExclusions = @\{(.*?)\n\}", re.S)
RUNTIME_BLOCK = re.compile(r"\$runtimes = \[ordered\]@\{(.*?)\n\}", re.S)
QUOTED = re.compile(r"'([^']+)'")
FRONTMATTER = re.compile(r"\A---\n(.*?)\n---\n", re.S)


def installer_text() -> str:
    return INSTALLER.read_bytes().decode("utf-8-sig").replace("\r\n", "\n")


def exclusions() -> dict[str, list[str]]:
    match = EXCLUSION_BLOCK.search(installer_text())
    assert match, "runtime ごとの除外の宣言が見つからない"
    found: dict[str, list[str]] = {}
    for line in match.group(1).splitlines():
        if "=" not in line:
            continue
        key, value = line.split("=", 1)
        names = QUOTED.findall(key)
        if names:
            found[names[0]] = QUOTED.findall(value)
    return found


def declared_runtimes() -> set[str]:
    text = installer_text()
    match = RUNTIME_BLOCK.search(text)
    assert match, "runtime の宣言が見つからない"
    names = set(re.findall(r"^    '([a-z]+)'\s*=", match.group(1), re.M))
    names |= set(re.findall(r"\$runtimes\['([a-z]+)'\]\s*=", text))
    return names


def skill_dirs() -> list[Path]:
    return sorted(p for p in SKILLS.iterdir() if p.is_dir() and (p / "SKILL.md").is_file())


class InstallerEncodingTest(unittest.TestCase):
    """`.ps1` は BOM が無いと、日本語環境の Windows PowerShell が別のコードページと誤認する。"""

    def test_the_installer_keeps_its_byte_order_mark(self):
        self.assertEqual(INSTALLER.read_bytes()[:3], b"\xef\xbb\xbf",
                         "BOM が落ちている。テキスト編集で失われやすい")

    def test_line_endings_are_consistent(self):
        """保存は LF、取り出しは `.gitattributes` で CRLF。どちらでもよいが、混ざってはいけない。"""
        raw = INSTALLER.read_bytes()
        crlf, lf = raw.count(b"\r\n"), raw.count(b"\n")
        self.assertTrue(crlf in (0, lf), "行末が混在している")


class DistributionDeclarationTest(unittest.TestCase):
    def test_the_shared_rules_exist(self):
        self.assertTrue(SHARED_RULES.is_file())

    def test_skills_are_discovered_not_listed(self):
        """一覧を書くと、足した skill を配り忘れる。フォルダから見つける形を保つ。"""
        self.assertIn("Get-ChildItem -LiteralPath $skillsRoot -Directory", installer_text())

    def test_every_runtime_has_an_exclusion_entry(self):
        """除外が無い runtime も空の一覧を書く。書き忘れと「除外なし」を区別する。"""
        self.assertEqual(set(exclusions()), declared_runtimes())

    def test_every_excluded_skill_exists(self):
        present = {p.name for p in skill_dirs()}
        for runtime, names in exclusions().items():
            for name in names:
                with self.subTest(runtime=runtime, name=name):
                    self.assertIn(name, present, "除外に書かれているが skill が無い")


class SkillFormatTest(unittest.TestCase):
    """配った先のエージェントは、フォルダ名ではなく `SKILL.md` の `name` と `description` で skill を選ぶ。"""

    def test_each_skill_declares_its_own_name_and_a_description(self):
        for skill in skill_dirs():
            with self.subTest(skill=skill.name):
                text = (skill / "SKILL.md").read_text(encoding="utf-8").replace("\r\n", "\n")
                match = FRONTMATTER.match(text)
                self.assertIsNotNone(match, "frontmatter が無い")
                fields = dict(
                    line.split(":", 1) for line in match.group(1).splitlines()
                    if ":" in line and not line.startswith(" ")
                )
                self.assertEqual(fields.get("name", "").strip(), skill.name)
                self.assertTrue(fields.get("description", "").strip(), "description が空")


if __name__ == "__main__":
    unittest.main()
