---
id: FOUNDATION-NEW-PROJECT
title: New project starter template
type: template
status: active
created_at: 2026-09-01
updated_at: 2026-10-06
owners: [knowledge-stewards]
source_ids: [ART-004, ART-006, REF-005]
tags: [project, template, handover]
---

# 新規プロジェクト雛形

```text
project/
├─ AGENTS.md            # 指示の正本。リポジトリ直下に置く
├─ docs/
│  └─ HANDOVER.md
├─ src/
└─ output/              # 追跡する成果物だけを置く
```

開始時に `AGENTS.md` へ目的、受け入れ条件、検証方法、変更禁止領域、参照設計書を記載します。特定のエージェントにしか意味のない指示が出てきたら、そのツールの入口ファイルを足して正本を取り込みます（[../agents-md/README.md](../agents-md/README.md)）。`docs/HANDOVER.md` には、目的と境界、現在の状態、次の手順、決定、環境、検証、成果物を残します。

認証情報、生データ、ローカル実行結果は追跡しません。必要なら `.gitignore` に最初から追加します。
