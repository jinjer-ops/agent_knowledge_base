---
id: FOUNDATION-CLAUDE-CODE
title: Claude Code starter
type: setup-guide
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-003, ART-006, ART-012, ART-015, REF-001, REF-002]
tags: [claude-code, setup, skills]
---

# Claude Code starter

## 最小構成

プロジェクトのルートに `CLAUDE.md` を追加し、必要な場合だけ `.claude/rules/` と `.claude/skills/` を追加します。

```text
project/
├─ CLAUDE.md
└─ .claude/
   ├─ rules/
   │  └─ review.md
   └─ skills/
      └─ <skill-name>/SKILL.md
```

雛形は [CLAUDE.md.template](CLAUDE.md.template)、レビュー時の補助観点は [rules/review.md](rules/review.md) を使います。

## 置き場所の判断

| 内容 | 置き場所 | 例 |
| --- | --- | --- |
| ほぼ全作業で必要な短い事実 | `CLAUDE.md` | 目的、技術スタック、検証コマンド |
| 対象ファイルや用途が限定された方針 | `.claude/rules/` | レビュー、資料作成、データ変更 |
| 起動条件・入力・検証・停止条件がある反復作業 | `.claude/skills/` | 公開前確認、文書取り込み |
| 長い背景・設計理由・記事 | リポジトリの文書 | ADR、実験記録、参考資料 |

`CLAUDE.md` は短く保ち、手順を丸ごと貼り付けません。詳細が必要な作業はskillまたは参照文書へ移します。

## 導入後の確認

1. 新しいセッションで、プロジェクトの目的と検証方法をClaudeに要約させる。
2. `.claude/rules/` を追加した場合は、対象の作業でだけ参照されることを確認する。
3. skillを追加した場合は、`SKILL.md` の説明だけで起動条件が判別できることを確認する。

Claude Codeの現在のファイル配置・読み込み仕様は `REF-001` と `REF-002` を正本とします。

## 共有skillの導入

このリポジトリの [skills/](../../skills/) から必要なskillディレクトリだけを、プロジェクトの `.claude/skills/` または利用するエージェントのskillディレクトリへコピーします。ローカル設定、認証情報、履歴、許可情報はコピーしません。
