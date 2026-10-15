---
id: README
title: Agent knowledge base
type: overview
status: accepted
created_at: 2026-09-01
updated_at: 2026-10-15
owners: [knowledge-stewards]
tags: [knowledge, agents, technology-radar, skills]
---

# Agent knowledge base

Claude Code・Codex・Antigravity などの AI エージェントに入れる環境と、その環境を作るに至った記事・判断・教訓を、一つの場所で育てるリポジトリです。誰でも読めます（2026-10-06 から非公開にしていたものを、2026-10-15 に公開に戻しました）。

リモート: <https://github.com/jinjer-ops/agent_knowledge_base>

## まず読む場所

- 環境をそのまま入れる: [environment/](environment/)
- 環境の作り方と考え方を読む: [foundation/](foundation/)
- 公開可能なjinjer向け補足: [organization/jinjer/](organization/jinjer/)
- 記事の内容と示唆を日本語で読む: [knowledge/reading-guide.md](knowledge/reading-guide.md)
- 記事・判断・運用の教訓から探す: [knowledge/](knowledge/)
- 実行ワークフロー: [skills/](skills/)
- 追加・公開のルール: [docs/contribution.md](docs/contribution.md) と [docs/public-boundary.md](docs/public-boundary.md)
- Knowledge Inbox（Android アプリと PC の実行管理アプリ）との確認事項: [docs/knowledge-inbox/](docs/knowledge-inbox/)

## 4つの領域

| 領域 | 役割 | 置くもの |
| --- | --- | --- |
| `environment/` と `skills/` | 端末にそのまま入れる環境 | 共通の作業合意（AGENTS.md）、skill、Claude Code の subagent、導入スクリプト |
| `foundation/` | 個人やチームが最初に導入する汎用設定 | Claude Codeの設定例、レビュー観点、雛形、資料作成方針 |
| `organization/jinjer/` | jinjerで使う公開可能な補足 | 組織向けオーバーレイの使い方と、公開範囲内の規約 |
| `knowledge/` | 判断の背景と将来の探索入口 | 人向けの[読書ガイド](knowledge/reading-guide.md)、機械向けの[出典台帳](knowledge/sources/articles.yml)、[判断の記録](knowledge/decisions/)、[運用で得た教訓](knowledge/practices/) |

`organization/jinjer/` はアクセス制御ではありません。このリポジトリの全ファイルはインターネット上で読めるため、社外秘の手順・URL・データ・認証情報は置きません。

## 知識の構成

外部記事・公式資料には、読む相手ごとに二つの入口があります。

```text
                    ┌─ 人が読む:   knowledge/reading-guide.md  （URLごとの日本語カード）
外部記事・公式資料 ─┤
                    └─ 機械が読む: knowledge/sources/articles.yml（出典台帳）

出典台帳の derived ──> それを根拠に使う現存文書（foundation / organization / skills / docs）
```

出典台帳が source ID と URL の正本です。`derived` は、その source を `source_ids` で宣言している現存文書への完全な逆引きで、関連文書を全て引くための索引です。読書ガイドは各 source の内容・示唆・現在の扱いを日本語で説明します。同じ内容を両方へ複写しません。

現在この repository が持つ知識は、出典台帳、読書ガイド、`foundation/` の設定指針、`organization/jinjer/` の補足、`skills/` のワークフロー、`knowledge/decisions/` の判断の記録、`knowledge/practices/` の運用で得た教訓です。教訓は外部の出典ではなく運用の記録から起こしたもので、組織に固有の事柄は除いています。追加する手順は [docs/contribution.md](docs/contribution.md) にあります。

## 運用ルール

- 記事本文は転載しない。URL、メタデータ、自分たちの判断、検証結果だけを保存する。
- `reference` は捨てる意味ではない。将来の比較対象として保持する。
- `experiment` を `adopted` に変えるには、用途・入力・検証結果・失効条件を記録する。
- skill にするのは、明確な起動条件と安全な完了条件を持つ反復ワークフローだけにする。
- 検索やRAGの対象にするのは、原則としてこのリポジトリの文書と利用許諾を確認した資料だけにする。

## 最小確認

```powershell
python scripts/validate_knowledge.py
git diff --check
cd tests; python -m unittest discover -s .
```

`validate_knowledge.py` は、出典台帳の source ID 数、`derived` の実在、`source_ids` と `derived` の双方向一致、読書ガイドが全 source をちょうど1カードずつ持つことを検査します。問題があれば該当 path を表示して終了コード1で終わります。`tests/` は skill の検査スクリプトと導入スクリプトの宣言を確かめます。どちらも pull request と main への push で CI が実行します。

## 公開と再利用

このリポジトリは公開しています。外部記事の権利は各出典に帰属します。`environment/` と `skills/` は MIT License です（各フォルダの `LICENSE`）。それ以外の文章と構成には、`LICENSE` を追加するまで再配布や利用の許諾を付与しません。改善提案は issue または pull request でお願いします。
