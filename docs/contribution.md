---
id: CONTRIBUTION
title: Adding knowledge and environment guidance
type: contribution-guide
status: active
created_at: 2026-09-01
updated_at: 2026-10-06
owners: [knowledge-stewards]
source_ids: [ART-001, ART-003, ART-012, REF-001, REF-002, REF-005]
tags: [contribution, knowledge, skills]
---

# Contribution guide

## knowledgeの二層

`knowledge/` は入口が二つあります。追加するときは両方を更新します。

| 目的 | 正本 |
| --- | --- |
| 人が日本語で読む | [../knowledge/reading-guide.md](../knowledge/reading-guide.md) |
| 機械・エージェントが参照する | [../knowledge/sources/articles.yml](../knowledge/sources/articles.yml) |

同じ内容を両方へ書きません。台帳はIDとメタデータ、読書ガイドは説明と評価を担当します。領域の案内は [../knowledge/README.md](../knowledge/README.md) にあります。

## 記事・入力を追加する

1. `knowledge/sources/articles.yml` にID、URL、公開日、topic、status、`use_when`、派生先を追加する。
2. `knowledge/reading-guide.md` に、そのIDのカードを1つ追加する。1つのIDを二重に扱わない。カードには URL、記事種別、現在の扱い、何が書かれているか、得られる示唆、採用・実験の裏付けを書く。関連文書の全一覧はカードに複写せず、台帳の `derived` を見る。
3. 要約は自分たちの評価だけにし、本文を転載しない。
4. URLの本文を確認できなかった場合は、titleや `use_when` から内容を推測しない。カードに「本文未確認」と明記し、なぜ残すかだけを書く。
5. status は、採用・実験の裏付けがどの種類まで揃っているかで決める。`derived` の件数では決めない。`adopted` は検証済みの decision / practice / guidance が現存すること、`experiment` は現存する charter（用途・入力・安全境界・検証方法・終了条件）があることを意味する。単なる引用、読書ガイド、この contribution guide からのリンクはどちらの根拠にもならない。どちらも無い場合は `reference` にする。`adopted` は記事の全主張を採用したという意味ではない。`experiment` と `reference` のカードには、推奨や導入済みと読める書き方をしない。
6. `derived` は**関連文書**の一覧、すなわち現存文書への完全な逆引きにする。`source_ids` にその source を書いたら、その source の `derived` にもその path を必ず加える（正方向と逆方向を一致させる）。宣言の場所は、通常の文書は frontmatter、skill は `## Provenance` 節の `source_ids: [...]` の1行とする。存在しない path は書かない。文書を削除したら、その path を全ての `derived` から外す。
7. `derived`（関連文書）と採用・実験の裏付けは別概念である。`derived` は status の根拠ではなく、件数の多さは `adopted` を意味しない。引用・読書ガイド・この contribution guide からのリンクも status を動かさない。status は上の項目5の基準だけで決める。
8. 入口の種類を分ける。持ち主が共有した URL は `intake: shared`、それをきっかけに調べて実際に読み、判断や成果に使った資料は `intake: found` とし、`found_via: [共有した URL の ID]` で結び付ける。読んだが使わなかった資料は登録しない。Knowledge Inbox の PC 処理ではこの 2 行を処理系が書き、[../knowledge/discovery-trails.md](../knowledge/discovery-trails.md) を台帳から作り直す。区別を付ける前に登録した出典は `intake` を持たない。
9. 新しい判断は `knowledge/decisions/`、比較は `knowledge/experiments/`、検証済み手順は `knowledge/practices/` に置く。
10. 派生ファイルに `source_ids` を記載する。これはテーマを追えるようにするための参照であり、厳密な発祥の証明ではない。

## 設定・skillを追加する

- 常時必要な短い事実は `foundation/` の雛形、または対象プロジェクトの正本 `AGENTS.md` に置く。特定のエージェントにしか意味のない指示だけを、そのツールの入口ファイルに置く。
- 反復可能で、起動条件・入力・検証・終了条件が明確な作業だけを `skills/` に追加する。書き方と確認の手順は [../foundation/skill-authoring/README.md](../foundation/skill-authoring/README.md) に従う。必ず実行させたい処理は skill ではなく hook にする。
- 特定の会社・案件だけに関係する内容は、公開可能な原則まで抽象化できる場合だけ `organization/jinjer/` に置く。
- 不明な内容や未検証の仮説は、断定せず `knowledge/experiments/` または `reference` として保持する。

公開変更の前には [public-boundary.md](public-boundary.md) の確認を行います。
