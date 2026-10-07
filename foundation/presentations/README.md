---
id: FOUNDATION-PRESENTATIONS
title: Presentation authoring and format selection
type: practice
status: active
created_at: 2026-09-01
updated_at: 2026-10-07
owners: [knowledge-stewards]
source_ids: [ART-002, ART-010, REF-127]
tags: [presentations, html, dom, assets]
---

# Presentation authoring

資料は、用途に応じて表現形式を選びます。

- ブランド済み資料の更新、共同編集、PowerPointでの受け渡しが必要な場合は、ネイティブなスライドのDOM・オブジェクトモデル・テーマを正本にする。
- 技術発表やブラウザで配布する資料は、HTML/CSSまたはReveal.jsを有力な選択肢にする。
- ドラフトの反復が主目的なら、HTML/CSSを先に編集・表示確認してから、必要な場合だけ最終形式へ変換する。

Markdownは構成案として使えますが、レイアウトの正本ではありません。変換先の形式で最終表示を確認し、テキスト溢れ、重なり、判読性、画像、フォント、編集可能性を確認します。

ただし、この確認はすべて目視です。**目視で気づきにくい側に、実際の欠落は寄っています。** 54 名のデザイナーが作った画面と AI に生成させた同等物を比べた査読済みの測定（`REF-127`）では、適合率が最も低かったのはコントラスト比と「色だけで情報を伝えていないか」という、いずれも規則で正確に判定できる項目でした。判読性を目で見るだけでは、ここは通ります。配色と図の色分けについては、機械で判定できる項目を目視とは別に確認します。

見た目の方向性を毎回言葉で指示し直している場合は、形式の選択ではなく正本の持ち方の問題です。[../design-asset-canon/](../design-asset-canon/) を読みます。
