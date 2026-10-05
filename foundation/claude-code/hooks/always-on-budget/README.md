---
id: FOUNDATION-HOOK-ALWAYS-ON-BUDGET
title: Always-on budget hook (draft)
type: hook-spec
status: draft
created_at: 2026-10-06
updated_at: 2026-10-06
owners: [knowledge-stewards]
source_ids: [ART-003, ART-015, REF-001, REF-002, REF-011, REF-017, REF-020]
tags: [hooks, context, maintenance, claude-code]
---

# 常時読み込みの合計を知らせる hook（設計・未検証）

**この設計は検証していません。** 下の参考実装はこの環境で一度も実行していません。実行ファイルとしては置いていないので、使うなら自分のところへ写し、「確かめる手順」を通してから設定に書きます。状態は `experiment` で、導入を勧めるものではありません。

## 何のためのものか

指示ファイルが膨らみ続ける原因は、判断の質ではなく**合計が見えないこと**です。追記はどれも単体では正しく、合計は意識して見に行かない限り目に入りません（`ART-015`）。見えるようにする役目を人の記憶ではなく仕組み側に置きます。

`ART-015` は同じ診断から、本体のバイト数が上限を超えたら移動を促す hook を作り、導入前の 7 日で +181.8%、導入後の 7 日で +1.2% という前後の値を報告しています。同じ対象を同じ単位で前と後に測った比較です。

この設計は、そこから**測る範囲を広げた**ものです。1 ファイルのバイト数では、常時載るものの一部しか見ていません。毎回載るのは入口ファイルだけでなく、条件を付けていないルール、使える skill の**名前と説明**、まとめて配布する仕組みの中身、自動の記憶の索引も含みます（`REF-017`、`REF-002`、`REF-011`）。しかも移動先を条件付き読み込みの層にしても `paths:` を付けなければ常時読み込みのままで、**バイトが別のファイルへ移るだけで合計は変わりません**（`ART-003`）。1 ファイルだけを見張ると、この移動を「改善」と読み違えます。

## 設計

| 決めたこと | 理由（`REF-020`） |
| --- | --- |
| イベントは session の開始時 | 常時読み込みはそこで発生する。測るのはその時点でよい |
| 止めない | このイベントにそもそも止める力は無い。ここで止めたいものでもない |
| 出力は**利用者への警告** | モデルの文脈へ足す項目もあるが、軽くするための点検が毎回 context を食っては本末転倒 |
| 上限以下のときは何も出さない | 黙っている時間が長いほど、出たときに意味がある |

**書き込みの時点で止めたい場合は、ツールの実行後に走るイベントではありません。** 実行後のイベントは止められず、終了コード 2 も内容をモデルに見せるだけです。実際に止めるなら実行前のイベントで拒否します（`REF-020`）。`ART-015` の hook は実行後のイベントなので、書き込みを防ぐのではなく、直後に気づかせて移動させる仕組みです。

## 入出力

- **入力**: 決まった形の JSON が標準入力に渡ります。ここで使うのは作業ディレクトリだけです。環境変数からも取れます。
- **出力**: 上限以下なら何も出さず終了コード 0。超えたときだけ、利用者への警告を含む JSON を 1 行出して終了コード 0。
- **設定**: 上限は文字数で、環境変数で変えられるようにします。

## 確かめる手順

1. **まず手で 1 回動かす。** hook に登録する前に、コマンドとして実行し、終了コード 0 で、上限を超えたときだけ 1 行の JSON が出ることを確認します。
2. 出た数字を、セッション内で出せる実際の context の内訳と比べます。**文字数はトークン数ではありません**（`REF-017`）。比率を見て上限を決め直します。
3. 内訳の 3 層が、自分の環境で実際に常時読み込まれている層と一致するか確認します。条件を絞ったルールと呼び出し式の skill は数えません。
4. そのうえで session 開始のイベントに登録し、1 回の session で 1 度だけ出ることを確認します。

hook は任意のコマンドを実行します。設定を書く前に中身を読み、どの設定ファイルに置くかを決めてください（`REF-020`）。

## 参考実装（未検証）

```python
#!/usr/bin/env python3
"""Report the always-on instruction surface at the start of a session.

Characters are a proxy, not tokens. Use the product's own context breakdown
for the authoritative figure. Standard library only.
Budget: set CLAUDE_ALWAYS_ON_BUDGET to a character count (default 20000).
"""

import json
import os
import sys
from pathlib import Path

DEFAULT_BUDGET = 20000
ENTRY_NAMES = ("CLAUDE.md", "AGENTS.md", ".claude/CLAUDE.md")
TRUTHY = {"true", "yes", "on", "1"}


def frontmatter(path):
    """Return the frontmatter lines of a markdown file, or [] if it has none."""
    try:
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    except OSError:
        return []
    if not lines or lines[0].strip() != "---":
        return []
    out = []
    for line in lines[1:]:
        if line.strip() == "---":
            return out
        out.append(line)
    return []


def field(lines, name):
    prefix = name + ":"
    for line in lines:
        if line.startswith(prefix):
            return line[len(prefix):].strip()
    return ""


def size_of(path):
    try:
        return len(path.read_text(encoding="utf-8", errors="replace"))
    except OSError:
        return 0


def entry_files(roots):
    for root in roots:
        for name in ENTRY_NAMES:
            if (root / name).is_file():
                yield root / name


def unscoped_rules(roots):
    """Rules without a `paths:` field load on every session."""
    for root in roots:
        for path in sorted(root.glob(".claude/rules/*.md")):
            if not field(frontmatter(path), "paths"):
                yield path


def skill_listings(roots):
    """Only name, description and when_to_use are preloaded, and only for
    skills the model is allowed to invoke."""
    for root in roots:
        for path in sorted(root.glob(".claude/skills/*/SKILL.md")):
            front = frontmatter(path)
            if field(front, "disable-model-invocation").strip("\"'").lower() in TRUTHY:
                continue
            listed = "".join(field(front, k) for k in ("name", "description", "when_to_use"))
            if listed:
                yield len(listed)


def main():
    payload = {}
    if not sys.stdin.isatty():
        try:
            payload = json.loads(sys.stdin.read() or "{}")
        except ValueError:
            payload = {}
    project = Path(os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or ".")
    roots = [Path.home() / ".claude", Path.home(), project]

    layers = [
        ("入口ファイル", sum(size_of(p) for p in entry_files(roots))),
        ("条件なしルール", sum(size_of(p) for p in unscoped_rules(roots))),
        ("skill の説明", sum(skill_listings(roots))),
    ]
    total = sum(size for _, size in layers)

    try:
        budget = int(os.environ.get("CLAUDE_ALWAYS_ON_BUDGET", DEFAULT_BUDGET))
    except ValueError:
        budget = DEFAULT_BUDGET
    if total <= budget:
        return 0

    breakdown = "、".join("%s %s" % (n, format(s, ",")) for n, s in layers if s)
    print(json.dumps({"systemMessage":
        "常時読み込みが %s 文字（目安 %s）。内訳: %s。"
        "正確なトークンの内訳はセッション内の context 表示で確認し、"
        "減らすなら対象を絞ったルール・呼び出し式の skill・参照文書へ移す。"
        % (format(total, ","), format(budget, ","), breakdown)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

## 限界

- 文字数は目安です。正確なトークンの内訳は製品側の表示が正本です（`REF-017`）。
- frontmatter は行頭の一致だけで読みます。入れ子や複数行の値は見ません。
- まとめて配布する仕組みの中身と自動の記憶の索引は数えていません。有効にしている場合、実際の合計はこれより大きくなります（`REF-011`、`REF-001`）。
- 数えるのは合計だけで、どれを削るべきかは判断しません。削る基準は [../../../instruction-upkeep/README.md](../../../instruction-upkeep/README.md) にあります。
