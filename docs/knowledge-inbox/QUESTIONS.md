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

- 状態: 回答待ち（Android 側へ）
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
- 回答:

## Q-002 「Test-registered-article」の 1 件は本番として処理してよいか

- 状態: 回答待ち（持ち主へ）
- 起票: 2026-10-06（PC 側）
- 背景: 2026-10-04 12:19 送信の記事の題が「Test-registered-article」になっている。URL は zenn の公開記事。
- 確かめたいこと: 実機の確認のために登録した試験か。本番として処理してよいか。試験なら、アプリで削除（tombstone）してから処理を始めるか。
- 回答:

## Q-003 アプリが表示に使う項目

- 状態: 回答待ち（Android 側へ）
- 起票: 2026-10-06（PC 側）
- 確かめたいこと:
  1. PC が書く `topics` には、記録仕様の項目に加えて `title`・`created_at_ms`・`updated_at_ms` を入れている。アプリが読む項目、表示に使う項目はどれか。
  2. PC が書くイベントは `kind`（`created`・`updated`・`installed`・`verified`・`merged`・`archived`・`published`）、`title`、`item_id`、`occurred_at_ms`、`actor=pc` の 5 項目で、ID は `kind:item_id` または `kind:item_id:版`。アプリの集計はこの形で動くか。
  3. 記事の `artifacts` の各要素に、記録仕様の項目（`kind`・`repo_path`・`deployment_target`・`commit_sha`）に加えて成果物 ID の `id` を入れている。問題ないか。
- 回答:

## Q-004 Firestore ルールの追加分を Android のプロジェクトにも反映する

- 状態: 回答待ち（Android 側へ）
- 起票: 2026-10-06（PC 側）
- 背景: 会社アカウント用の追加分は、持ち主が 2026-10-06 に Firebase コンソールで公開した。Android のプロジェクトの `firestore.rules` からデプロイすると、コンソールで足した分は消える。
- 確かめたいこと: コンソールで公開中のルールを、Android のプロジェクトの `firestore.rules` に写したか。
- 回答:

## Q-005 このリポジトリを非公開にした影響

- 状態: 回答待ち（Android 側へ）
- 起票: 2026-10-06（PC 側）
- 背景: 2026-10-06 にこのリポジトリを非公開にした。`catalog` の `url`（`github.com/…/blob/main/…`）は、ログインしないと開けなくなる。
- 確かめたいこと: アプリが実行時に GitHub から台帳を取りに行く処理（`raw.githubusercontent.com` など）はあるか。あれば動かなくなるので、同梱のスナップショットだけで動くかを知りたい。
- 回答:
