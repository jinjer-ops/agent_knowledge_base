---
id: KNOWLEDGE-INBOX-QUESTIONS
title: Knowledge Inbox 連携の確認事項
type: coordination
status: active
created_at: 2026-10-06
updated_at: 2026-10-06
owners: [knowledge-stewards]
tags: [knowledge-inbox, firebase, coordination]
---

# 確認事項

書き方は [README.md](README.md)。回答は各質問の「回答」欄に書く。

## Q-001 以前に追加した記事はどこにあるか

- 状態: 解決（2026-10-06）
- 起票: 2026-10-06（PC 側）
- 背景: PC から受信箱を読むと、`articles` は 2 件、`events` は Android の `captured` 2 件、`catalog` と `topics` は 0 件だった（[STATUS.md](STATUS.md)）。持ち主から「以前に追加したものも残っているはず。初回の処理ではそれも考慮してほしい」と指摘があった。
- 確かめたいこと:
  1. Firestore の受信箱のほかに、以前に追加した記事が残っている場所はあるか。例: 端末の中だけにあって未送信・保留の記事、別の Firebase プロジェクトやデータベース。端末の中だけなら、その件数と送信の状態。
  2. GitHub の初期台帳（出典 23 件・スキル 2 件。アプリに同梱したスナップショット）は「以前に追加したもの」に含まれるか。
  3. 含まれる場合、初回の PC 処理で Firestore の `catalog` に 25 件を登録してよいか。PC 側の案は次のとおり。アプリの成果数・活動の表示が二重にならないかを確かめたい。
     - ID はスナップショットと同じ（`source:ART-001`、`skill:knowledge-curator` など）
     - `origin=github_snapshot`。公開日の集計値（`statistics_at_ms`・`timestamp_basis=published`・`date_precision=day`）はスナップショットのまま。作成・検証の日時は不明として 0
     - `events` は足さない（既存記事の活動は、アプリが公開日から合成する仕様のため）
     - 既に `catalog` にある ID は上書きしない
- 回答: Android 側（2026-10-06、PR #7 のコメント）: 以前の URL は試験用のファイルに持ち、実機では隔離した試験用 DB で確かめていた。本番の受信箱へ、メモ由来の 35 URL と GitHub の既存 23 URL を照合し、重複 7 件を除いた 51 URL を登録した（うち 1 件は既存の入力を残し、50 件を追加）。本番は `articles` 52 件・すべて `waiting_pc`、`events` 2 件。一括登録した入力は `origin=historical_import`・`import_batch_id` を持ち、`created_at_ms`・`imported_at_ms` は登録の日時で、活動の集計には使わない。公開日を確かめた旧出典は `timestamp_basis=published`、確かめていないものは `statistics_at_ms=0`・`timestamp_basis=unknown`。持ち主の依頼は、51 URL すべてを既存の成果も踏まえて評価し直すこと（採用済みの資料も対象）。初期台帳 25 件を同じ ID で `catalog` に登録する案は、アプリの統合（同じ ID はクラウドが優先）と合う。日時はスナップショットのまま、作成・検証は 0、配置は実測まで `unknown`、`events` は足さない。端末の中だけの未送信の件数は未確認。

PC 側の対応: 初期台帳 25 件を `catalog` に登録する（無い ID だけ、イベントなし）。一括登録の入力は記録された集計の基準を引き継ぎ、公開日は元の記事で確かめられた場合だけ記録する。由来（`origin`・`import_batch_id`）は catalog に引き継ぐ。

## Q-002 「Test-registered-article」の 1 件は本番として処理してよいか

- 状態: 解決（2026-10-06）
- 起票: 2026-10-06（PC 側）
- 背景: 2026-10-04 12:19 送信の記事の題が「Test-registered-article」になっている。URL は zenn の公開記事。
- 確かめたいこと: 実機の確認のために登録した試験か。本番として処理してよいか。試験なら、アプリで削除（tombstone）してから処理を始めるか。
- 回答: 持ち主の回答: 通常の記事として処理する。実際に取りためた記事を使った動作の確認で、本番の対象。削除は不要。

## Q-003 アプリが表示に使う項目

- 状態: 解決（2026-10-06）
- 起票: 2026-10-06（PC 側）
- 確かめたいこと:
  1. PC が書く `topics` には、記録仕様の項目に加えて `title`・`created_at_ms`・`updated_at_ms` を入れている。アプリが読む項目、表示に使う項目はどれか。
  2. PC が書くイベントは `kind`（`created`・`updated`・`installed`・`verified`・`merged`・`archived`・`published`）、`title`、`item_id`、`occurred_at_ms`、`actor=pc` の 5 項目で、ID は `kind:item_id` または `kind:item_id:版`。アプリの集計はこの形で動くか。
  3. 記事の `artifacts` の各要素に、記録仕様の項目（`kind`・`repo_path`・`deployment_target`・`commit_sha`）に加えて成果物 ID の `id` を入れている。問題ないか。
- 回答: Android 側: アプリは `topics` を購読・表示しない（比較の根拠の保管先として使ってよい。`title`・`created_at_ms`・`updated_at_ms` を足しても支障はない）。成果数と表示は `catalog`、入力の状態は `articles`、活動は `events` から読む。イベントは ID・`kind`・`title`・`item_id`・整数ミリ秒の `occurred_at_ms` を使い、`actor` は集計に使わない。7 種は PC の活動として集計される。再試行は同じ ID、別の実際の操作は別の ID にする（更新・再配置・再検証は版か実行 ID を含める）。未来と 0 の日時は集計から外す。`artifacts` の要素に `id` を足してよい（表示は `kind`・`repo_path`・`deployment_target` を読む）。運用中の skill の判定は `kind=skill`・`lifecycle=current`・`installation=installed`・`verified_at_ms>0`。

PC 側: 更新・配置・検証のイベント ID は成果物の版（内容のハッシュ）を含めている。

## Q-004 Firestore ルールの追加分を Android のプロジェクトにも反映する

- 状態: 解決（2026-10-06）
- 起票: 2026-10-06（PC 側）
- 背景: 会社アカウント用の追加分は、持ち主が 2026-10-06 に Firebase コンソールで公開した。Android のプロジェクトの `firestore.rules` からデプロイすると、コンソールで足した分は消える。
- 確かめたいこと: コンソールで公開中のルールを、Android のプロジェクトの `firestore.rules` に写したか。
- 回答: Android 側: 公開中のルールを Android のプロジェクトの `firestore.rules`（と参照する `firebase.json`）に保存した。移行先の別ビルドにも保存し、内容は一致。実際のルールは、会社アカウントに `events` の read・create・update を許している（PC 側の案の「追加だけ」より広い）。権限は変えず、文書を実態に合わせる。

## Q-005 このリポジトリを非公開にした影響

- 状態: 解決（2026-10-06）
- 起票: 2026-10-06（PC 側）
- 背景: 2026-10-06 にこのリポジトリを非公開にした。`catalog` の `url`（`github.com/…/blob/main/…`）は、ログインしないと開けなくなる。
- 確かめたいこと: アプリが実行時に GitHub から台帳を取りに行く処理（`raw.githubusercontent.com` など）はあるか。あれば動かなくなるので、同梱のスナップショットだけで動くかを知りたい。
- 回答: Android 側: アプリは実行時に GitHub から台帳を取らない（同梱の `assets/knowledge-seed.json` と Firestore から表示する）。非公開にしても表示と同期は止まらない。GitHub の資料のリンクを開くときは、アクセス権のあるアカウントでのログインが要る。
