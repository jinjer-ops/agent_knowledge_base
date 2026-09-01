---
id: FOUNDATION
title: Reusable agent environment foundation
type: foundation
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-003, ART-006, ART-012, ART-015, REF-001, REF-002]
tags: [claude-code, configuration, onboarding]
---

# Foundation

この領域は、特定の会社・案件・端末に依存しないAIエージェント環境の出発点です。初めてClaude Codeを使う場合は、[claude-code/](claude-code/) の順に読みます。

## 適用の原則

1. 既存の設定を上書きしない。雛形を読み、必要な部分だけをプロジェクトへ追加する。
2. 常時必要な事実は `CLAUDE.md`、対象を絞るルールは `.claude/rules/`、反復手順は `.claude/skills/` に置く。
3. ツール固有の設定を無理に同期しない。共有できる事実は一つの正本へ寄せ、実行手順は各ツールに合わせる。
4. 外部公開やデータ変更は、明示的な承認と検証を必要とする。

Claude Codeにおける設定の読み込み範囲とskillsの形式は、[参考資料台帳](../knowledge/sources/articles.yml) の `REF-001` と `REF-002` を確認します。
