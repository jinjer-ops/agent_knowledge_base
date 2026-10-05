---
id: KNOWLEDGE
title: Knowledge area entry point
type: overview
status: active
created_at: 2026-09-02
updated_at: 2026-09-02
owners: [knowledge-stewards]
tags: [knowledge, sources, reading-guide]
---

# Knowledge

この領域は二層です。読む相手によって入口が違います。

| 目的 | 入口 | 形式 |
| --- | --- | --- |
| 人が読んで理解する | [reading-guide.md](reading-guide.md) | source ID ごとの日本語カード |
| 機械・エージェントが参照する | [sources/articles.yml](sources/articles.yml) | 構造化した出典台帳 |
| 共有した URL と、そこから見つけた資料を追う | [discovery-trails.md](discovery-trails.md) | 台帳から生成する一覧 |

## 使い分け

- **[読書ガイド](reading-guide.md)**: URL ごとに「何が書かれているか」「得られる示唆」「現在の扱い」「採用・実験の裏付け」を並べています。関連文書の全一覧は載せません。どの記事を読むべきか、なぜ手元の方針がその形になっているかを追う場所です。
- **[出典台帳](sources/articles.yml)**: source ID、URL、公開日、topic、status、入口の種類（`intake`）、見つけたきっかけ（`found_via`）、`use_when`、関連文書（`derived`）を保持します。ID と URL の正本であり、記事の要約は置きません。

同じ内容を両方に書きません。台帳は事実とメタデータ、ガイドは説明と評価を担当します。

- **[共有と発見の一覧](discovery-trails.md)**: スマホから共有した URL（`intake: shared`）ごとに、それをきっかけに調べて実際に使った資料（`intake: found`）を並べます。台帳の `intake` と `found_via` から生成するので、手で編集しません。

## 現在の扱い（status）の意味

| status | 条件 |
| --- | --- |
| `adopted` | 採用・実験の裏付け（検証済みの decision / practice / guidance）が現存する。単なる引用、読書ガイド、contribution guide からのリンクは該当しない。記事の全主張を採用したという意味ではない |
| `experiment` | 現存する experiment charter（用途・入力・安全境界・検証方法・終了条件）があり、比較・検証の枠がいま読める |
| `reference` | 上のどちらでもない。読む価値のある出典として保持している。推奨でも導入済みでもない |

status は、その source を根拠にした local artifact がどの種類まで揃っているかで決まります。記事の質の評価ではなく、`derived` の件数でもありません。

`reference` は捨てる意味ではありません。範囲が違うことも、参照先の文書が無いことも、破棄の理由になりません。

台帳の `derived` は**関連文書**の一覧、すなわち**現存文書への完全な逆引き**です。ある文書が `source_ids` でその source を宣言していれば、その path は必ず `derived` に載ります（通常の文書は frontmatter、skill は `## Provenance` 節の1行で宣言します）。存在しない path は載せません。

`derived` は status の根拠ではありません。status を支えるのは「**採用・実験の裏付け**」、すなわち現存する decision / practice / guidance / experiment charter だけです。件数が多いことは `adopted` を意味せず、引用・読書ガイド・contribution guide からのリンクも status を動かしません。読書ガイドは全20 source を要約する関連文書なので、全 source の `derived` に含まれます。

## 追加するとき

1. [sources/articles.yml](sources/articles.yml) に source ID から派生先までを追加する。
2. [reading-guide.md](reading-guide.md) に、その ID のカードを1つ追加する。既にある ID を二重に扱わない。
3. URL の本文を確認できなかった場合は、title や `use_when` から内容を推測せず、カードに「本文未確認」と明記し、なぜ残すかだけを書く。
4. 記事本文・画像・長文引用は転載しない。要約は自分たちの記述にする。

詳細な規則は [../docs/contribution.md](../docs/contribution.md) にあります。
