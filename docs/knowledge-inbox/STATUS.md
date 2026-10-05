---
id: KNOWLEDGE-INBOX-PC-STATUS
title: Knowledge Inbox PC 側の状態
type: status
status: active
created_at: 2026-10-06
updated_at: 2026-10-06
owners: [knowledge-stewards]
tags: [knowledge-inbox, firebase, pc-worker]
---

# PC 側の状態（2026-10-06 時点）

## 接続

| 項目 | 状態 |
| --- | --- |
| PC の Firebase ログイン | 会社の Google アカウントで接続済み。スマホの個人アカウントとは別の Firebase ユーザーで、PC では個人アカウントにログインしない |
| 処理する受信箱 | スマホの個人アカウントの `users/{UID}/` の `articles`・`topics`・`catalog`・`events`。PC のアカウント側の受信箱は使わない |
| Firestore ルール | 会社アカウント用の追加分を持ち主が 2026-10-06 に公開。4 か所の読み取りが通ることを PC から確認した |
| Claude Code | 会社の Claude Code（claude.ai のログイン、Team）を非対話で起動する。API キーは使わない |
| 公開 | このリポジトリへの公開は止めてある。公開候補は PC 内のブランチに作り、持ち主の承認後に PR にする |

会社アカウントに許しているのは、受信箱の読み取り、記事の PC 側の結果の項目の更新、`topics`・`catalog` の作成と更新、`events` の追加だけ。記事の作成・削除、送信時の項目（URL・メモ・`owner_uid`・送信日時）の変更、削除済みの記事の更新、イベントの上書きはできない。

## 受信箱の中身（2026-10-06 に PC から読んだ件数）

| 場所 | 件数 | 内容 |
| --- | --- | --- |
| `articles` | 2 | どちらも `waiting_pc`。2026-10-04 12:19 送信の zenn の記事（題「Test-registered-article」）と、2026-10-05 01:36 送信の zenn の記事（日本語の文章を検査する Linter の紹介） |
| `events` | 2 | どちらも Android の `captured` |
| `catalog` | 0 | |
| `topics` | 0 | |

## 処理

- 未着手。2026-10-06 の 1 回目の「今すぐ処理」は、実行権の取得の段階で止まり、Firebase には何も書いていない。
  - 原因: 本番の Firestore は、利用者の ID トークンで `beginTransaction` を呼ぶと拒否する（エミュレーターでは通る）。
  - 対処: Web SDK と同じく、読んだときの更新時刻を条件にして書き込む形に変えた。途中で他から書き換えられたら書き込まない。
- [QUESTIONS.md](QUESTIONS.md) の Q-001 と Q-002 の回答を待つ間、PC 側は一時停止している。

## 処理の流れ（参考）

1. 受信箱から `waiting_pc` の記事を取り、`execution_id` と期限付きのリースを書いて実行権を取る。
2. Claude Code が、送信された URL をテーマの入口に、公式資料・関連記事・既存の台帳と比べ、台帳・読書ガイド・skill などの公開候補を作る。
3. PC 側が、結果を実際のファイル・台帳・公開してはいけない文字列・`scripts/validate_knowledge.py` で確かめる。
4. 公開候補をコミットし（公開は承認後）、skill は PC に配置してハッシュで確かめる。
5. `catalog`・`topics`・`events` を書き、記事を `done` にする。イベントの ID は内容から決まるので、再試行・再実行で増えない。
