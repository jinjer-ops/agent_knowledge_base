---
id: FOUNDATION-CLAUDE-CODE
title: Claude Code starter
type: setup-guide
status: active
created_at: 2026-09-01
updated_at: 2026-10-06
owners: [knowledge-stewards]
source_ids: [ART-003, ART-006, ART-012, ART-015, REF-001, REF-002, REF-008]
tags: [claude-code, setup, skills]
---

# Claude Code starter

## 最小構成

指示の正本はツール非依存の `AGENTS.md` に置きます（[../agents-md/README.md](../agents-md/README.md)）。Claude Code 側には、固有の内容がある場合だけ `CLAUDE.md` を置き、必要な場合だけ `.claude/rules/` と `.claude/skills/` を追加します。

```text
project/
├─ AGENTS.md            # 正本。全エージェント共通の作業合意
├─ CLAUDE.md            # 任意。Claude Code 固有の指示だけ
└─ .claude/
   ├─ rules/
   │  └─ review.md
   └─ skills/
      └─ <skill-name>/SKILL.md
```

雛形は [../agents-md/AGENTS.md.template](../agents-md/AGENTS.md.template) と [CLAUDE.md.template](CLAUDE.md.template)、レビュー時の補助観点は [rules/review.md](rules/review.md) を使います。

## 置き場所の判断

| 内容 | 置き場所 | 例 |
| --- | --- | --- |
| ほぼ全作業で必要な短い事実 | `AGENTS.md` | 目的、技術スタック、検証コマンド |
| Claude Code にしか意味のない指示 | `CLAUDE.md` | plan モードの使い分け、固有機能の扱い |
| 対象ファイルや用途が限定された方針 | `.claude/rules/` | レビュー、資料作成、データ変更 |
| 起動条件・入力・検証・停止条件がある反復作業 | `.claude/skills/` | 公開前確認、文書取り込み |
| 長い背景・設計理由・記事 | リポジトリの文書 | ADR、実験記録、参考資料 |

常時読み込まれる層は短く保ち、手順を丸ごと貼り付けません。詳細が必要な作業はskillまたは参照文書へ移します。ファイルを分けるだけでは起動時の消費は減らず、呼び出し式の層へ移したときに減ります。

## AGENTS.md との関係

Claude Code は、作業ディレクトリとその上位に `CLAUDE.md` / `.claude/CLAUDE.md` / `CLAUDE.local.md` が無いときに `AGENTS.md` を直接読みます。判定に数えるのはプロジェクト側のこれらだけで、ユーザー個人の `~/.claude/CLAUDE.md`、組織の管理ポリシー、`.claude/rules/` は数に入らず並んで読み込まれます。

両方を読ませる設定はユーザー設定・管理設定だけで有効で、プロジェクト設定からは指定できません。リポジトリ側から確実に効かせたい場合は、`CLAUDE.md` の先頭で `AGENTS.md` を取り込みます。Windows を含むチームでは symlink ではなく取り込みを使います。条件と制約は [../agents-md/README.md](../agents-md/README.md) にまとめてあります。

## 大きなリポジトリ

階層が深い、または package が多いリポジトリでは、根に 1 枚だけ置く構成が「全部入りで重い」か「汎用的すぎて役に立たない」のどちらかに寄ります。根に全体の規約、各領域にその領域の規約、という二層に分け、関わらない領域の指示を除外する設定と、対象を絞るルールを併用します。どこで起動するかで読み込まれる範囲が変わる点が起点になります。設定と判断の詳細は `REF-008`、正本を `AGENTS.md` にする場合の追加の注意は [../agents-md/README.md](../agents-md/README.md) にあります。

## 導入後の確認

1. 新しいセッションで、プロジェクトの目的と検証方法をClaudeに要約させる。
2. どの指示ファイルが実際に読み込まれたかをセッション内で確認する。読み込みの形跡を確認するまで適用済みと扱わない。
3. `.claude/rules/` を追加した場合は、対象の作業でだけ参照されることを確認する。
4. skillを追加した場合は、`SKILL.md` の説明だけで起動条件が判別できることを確認する。

Claude Codeの現在のファイル配置・読み込み仕様は `REF-001` と `REF-002` を正本とします。版によって `AGENTS.md` の扱いが変わるため、導入時に読み直します。

## 共有skillの導入

このリポジトリの [skills/](../../skills/) から必要なskillディレクトリだけを、プロジェクトの `.claude/skills/` または利用するエージェントのskillディレクトリへコピーします。ローカル設定、認証情報、履歴、許可情報はコピーしません。
