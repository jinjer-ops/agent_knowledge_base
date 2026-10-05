---
id: KNOWLEDGE-INBOX-EXCHANGE
title: Knowledge Inbox 連携のやり取り
type: coordination
status: active
created_at: 2026-10-06
updated_at: 2026-10-06
owners: [knowledge-stewards]
tags: [knowledge-inbox, firebase, coordination]
---

# Knowledge Inbox 連携のやり取り

Knowledge Inbox は、Android アプリで共有した記事の URL を Firebase の受信箱に保存し、PC の実行管理アプリが Claude Code で調査・整理して、結果を Firebase とこのリポジトリへ戻す仕組みです。Android アプリと PC の実行管理アプリは別の端末で作業するため、確認したいことと回答をこのフォルダに残します。

| ファイル | 内容 | 書く側 |
| --- | --- | --- |
| [STATUS.md](STATUS.md) | PC 側の実行管理アプリの現在の状態 | PC 側 |
| [QUESTIONS.md](QUESTIONS.md) | 相手に確かめたいことと、その回答 | 両方 |

## 書き方

- 質問は [QUESTIONS.md](QUESTIONS.md) に ID（`Q-001` から連番）を付けて足す。回答は、その質問の「回答」欄に書く。解決したら状態を「解決」にし、質問は消さない。
- 回答は main へ直接書いても、PR にしてもよい。PC 側は main を読む。
- 認証情報・トークン・鍵、記事の本文、個人のメモは書かない。Firebase の UID とアカウントのメールアドレスもここには書かない。このリポジトリは 2026-10-06 から非公開だが、再び公開できる基準で書く（[../public-boundary.md](../public-boundary.md)）。
- 日付は `YYYY-MM-DD`（日本時間）で書く。
