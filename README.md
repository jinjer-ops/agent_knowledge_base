---
id: README
title: Agent knowledge base
type: overview
status: accepted
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
tags: [knowledge, agents, technology-radar, skills]
---

# Agent knowledge base

Claude Code をはじめとするAIエージェントの導入設定、公開可能な組織向けオーバーレイ、記事・実験・判断を、一つの場所で育てる public repository です。

公開先: <https://github.com/jinjer-ops/agent_knowledge_base>

## まず読む場所

- 初めて導入する: [foundation/](foundation/)
- 公開可能なjinjer向け補足: [organization/jinjer/](organization/jinjer/)
- 記事・判断・実験から探す: [knowledge/](knowledge/)
- 実行ワークフロー: [skills/](skills/)
- 追加・公開のルール: [docs/contribution.md](docs/contribution.md) と [docs/public-boundary.md](docs/public-boundary.md)

## 3つの領域

| 領域 | 役割 | 置くもの |
| --- | --- | --- |
| `foundation/` | 個人やチームが最初に導入する汎用設定 | Claude Codeの設定例、レビュー観点、雛形、資料作成方針 |
| `organization/jinjer/` | jinjerで使う公開可能な補足 | 組織向けオーバーレイの使い方と、公開範囲内の規約 |
| `knowledge/` | 判断の背景と将来の探索入口 | 元記事URL、トピック、ADR、実験、再現済みの実践 |

`organization/jinjer/` はアクセス制御ではありません。このリポジトリの全ファイルはインターネット上で読めるため、社外秘の手順・URL・データ・認証情報は置きません。

## 知識の層

```text
外部記事・公式資料 (knowledge/sources)  --不変の出典台帳-->
判断・トピック地図 (knowledge/decisions / knowledge/topics)  --検証-->
実験・実践手順 (knowledge/experiments / knowledge/practices)  --反復利用-->
skills
```

同じ内容を複数の層に複写しません。派生物は必ず `source_ids` で出典台帳を参照します。出典は「このテーマを後から追う入口」であり、各設定の厳密な起源を主張するものではありません。

## 運用ルール

- 記事本文は転載しない。URL、メタデータ、自分たちの判断、検証結果だけを保存する。
- `reference` は捨てる意味ではない。将来の比較対象として保持する。
- `experiment` を `adopted` に変えるには、用途・入力・検証結果・失効条件を記録する。
- skill にするのは、明確な起動条件と安全な完了条件を持つ反復ワークフローだけにする。
- 検索やRAGの対象にするのは、原則としてこのリポジトリの文書と利用許諾を確認した資料だけにする。

## 最小確認

```powershell
rg -n "^  id:|^  status:|source_ids" foundation organization knowledge skills
git diff --check
```

## 公開と再利用

このリポジトリは閲覧用に公開しています。外部記事の権利は各出典に帰属します。`LICENSE` を追加するまで、このリポジトリ固有の文章・skill・構成について再配布や利用の許諾は付与しません。改善提案は issue または pull request でお願いします。
