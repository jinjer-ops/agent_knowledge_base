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

AIエージェント、知識検索、資料作成、ML基盤に関する外部記事と、検証した実践知を分けて管理する public repository です。

## まず読む場所

- 受け取った全記事: [sources/articles.yml](sources/articles.yml)
- 問いから探す: [topics/](topics/)
- 採用済みの判断: [decisions/](decisions/)
- 未確定の比較・検証: [experiments/](experiments/)
- 再現済みの手順: [practices/](practices/)
- 実行ワークフロー: [skills/](skills/)

## 知識の層

```text
外部記事・公式資料 (sources)  --不変の出典台帳-->
判断・トピック地図 (decisions / topics)  --検証-->
実験・実践手順 (experiments / practices)  --反復利用-->
skills
```

同じ内容を複数の層に複写しません。派生物は必ず `source_ids` で出典台帳を参照します。

## 運用ルール

- 記事本文は転載しない。URL、メタデータ、自分たちの判断、検証結果だけを保存する。
- `reference` は捨てる意味ではない。将来の比較対象として保持する。
- `experiment` を `adopted` に変えるには、用途・入力・検証結果・失効条件を記録する。
- skill にするのは、明確な起動条件と安全な完了条件を持つ反復ワークフローだけにする。
- 検索やRAGの対象にするのは、原則としてこのリポジトリの文書と利用許諾を確認した資料だけにする。

## 最小確認

```powershell
rg -n "^  id:|^  status:|source_ids" sources topics decisions experiments practices skills
git diff --check
```

## 公開と再利用

このリポジトリは閲覧用に公開しています。外部記事の権利は各出典に帰属します。`LICENSE` を追加するまで、このリポジトリ固有の文章・skill・構成について再配布や利用の許諾は付与しません。改善提案は issue または pull request でお願いします。
