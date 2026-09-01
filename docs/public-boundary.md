---
id: PUBLIC-BOUNDARY
title: Public repository boundary
type: policy
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [REF-003]
tags: [public, security, privacy]
---

# Public boundary

このリポジトリはpublicです。フォルダ名や「社内向け」という表記はアクセス制御になりません。

コミット前に、認証情報、秘密鍵、接続文字列、個人情報、顧客・業務データ、内部URL、個人の絶対パス、端末の設定・履歴・許可情報がないことを確認します。見つかった場合は公開せず、値のない雛形または一般化された説明へ置き換えます。

外部の記事・資料は、URLと短い評価だけを保存します。本文、画像、ダウンロードした資料、利用許諾が確認できないデータを保存しません。

GitHubのsecret scanningは補助であり、公開前の目視・機械検査を置き換えません。秘密を公開してしまった場合は、削除だけでなく失効・ローテーション・履歴対応が必要です。詳細は `REF-003` を参照します。
