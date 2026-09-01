---
id: CONTRIBUTION
title: Adding knowledge and environment guidance
type: contribution-guide
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-001, ART-003, ART-012, REF-001, REF-002]
tags: [contribution, knowledge, skills]
---

# Contribution guide

## 記事・入力を追加する

1. `knowledge/sources/articles.yml` にID、URL、公開日、topic、status、`use_when`、派生先を追加する。
2. 要約は自分たちの評価だけにし、本文を転載しない。
3. 新しい判断は `knowledge/decisions/`、比較は `knowledge/experiments/`、検証済み手順は `knowledge/practices/` に置く。
4. 派生ファイルに `source_ids` を記載する。これはテーマを追えるようにするための参照であり、厳密な発祥の証明ではない。

## 設定・skillを追加する

- 常時必要な短い事実は `foundation/` の雛形または対象プロジェクトの `CLAUDE.md` に置く。
- 反復可能で、起動条件・入力・検証・終了条件が明確な作業だけを `skills/` に追加する。
- 特定の会社・案件だけに関係する内容は、公開可能な原則まで抽象化できる場合だけ `organization/jinjer/` に置く。
- 不明な内容や未検証の仮説は、断定せず `knowledge/experiments/` または `reference` として保持する。

公開変更の前には [public-boundary.md](public-boundary.md) の確認を行います。
