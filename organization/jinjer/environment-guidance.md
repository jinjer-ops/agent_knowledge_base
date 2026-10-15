---
id: ORGANIZATION-JINJER-ENVIRONMENT
title: jinjer environment guidance
type: organization-practice
status: active
created_at: 2026-09-01
updated_at: 2026-10-15
owners: [knowledge-stewards]
source_ids: [ART-003, ART-004, ART-006, ART-012, REF-005]
tags: [jinjer, environment, handover]
---

# jinjer environment guidance

## 適用順序

1. 端末には [environment/](../../environment/) の共通の環境を入れる。会社に固有の指示は、このリポジトリに置かず、手元のファイルを導入スクリプトの `-PrivateOverlay` で足す。
2. [foundation/](../../foundation/) の雛形から始め、対象リポジトリの目的・受け入れ条件・検証方法だけを正本の `AGENTS.md` に追加する。ツール固有の指示だけを各ツールの入口ファイルに置く。
3. 会社・プロジェクトに固有の判断は、そのリポジトリのアクセス制御された文書に置く。このpublicリポジトリへ複写しない。
4. 繰り返し使う公開可能な知見だけを、`knowledge/` または `skills/` へ昇格させる。
5. 誰かが引き継ぐ作業は、目的、境界、現在状態、次の手順、検証、ロールバックを残す。

## 公開可能な共通原則

- ルールの正本を一つにし、ツールごとに設定を複製しない。
- いつも読む設定は短くし、詳細な手順は必要なときだけ読み込むskillまたは文書へ分ける。
- データ変更・外部公開・権限変更は、操作分類、プレビュー、承認、証跡、ロールバックを先に決める。
- 記事は本文を保存せず、URLと評価を `knowledge/sources/` に残す。

この文書は社内システムや業務情報を説明する場所ではありません。具体的な社内手順を追加したくなった場合は、まず [public boundary](../../docs/public-boundary.md) を確認します。
