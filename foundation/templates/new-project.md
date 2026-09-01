---
id: FOUNDATION-NEW-PROJECT
title: New project starter template
type: template
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-004, ART-006]
tags: [project, template, handover]
---

# 新規プロジェクト雛形

```text
project/
├─ CLAUDE.md
├─ docs/
│  └─ HANDOVER.md
├─ src/
└─ output/              # 追跡する成果物だけを置く
```

開始時に `CLAUDE.md` へ目的、受け入れ条件、検証方法、変更禁止領域、参照設計書を記載します。`docs/HANDOVER.md` には、目的と境界、現在の状態、次の手順、決定、環境、検証、成果物を残します。

認証情報、生データ、ローカル実行結果は追跡しません。必要なら `.gitignore` に最初から追加します。
