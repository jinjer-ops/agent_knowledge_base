# Skills

起動条件・入力・確かめ方・止まる条件がはっきりした、繰り返しの作業です。エージェントは各フォルダの `SKILL.md` にある `name` と `description` で選びます。まとめて入れるときは [../environment/README.md](../environment/README.md) の導入スクリプトを使います。1 本だけ使うなら、そのフォルダごとコピーします（設定・履歴・許可・認証情報はコピーしない）。

| skill | 使う場面 |
| --- | --- |
| [agent-config-inventory](agent-config-inventory/SKILL.md) | 指示・skill・hook のうち実際に効いているものを数え、「止める」などの主張と照らす |
| [audit](audit/SKILL.md) | 本番に効く変更・権限・取り返しのつかない操作・引き継ぎの前に、証拠で反証しながら監査する |
| [codex-claude-handoff](codex-claude-handoff/SKILL.md) | 設計側（Codex）が、実装側（Claude Code）へ渡すブリーフを作り、戻りを確かめる |
| [codex-implement](codex-implement/SKILL.md) | 設計側のブリーフを唯一の仕様として実装し、判断が要る点で止まる |
| [git-publish](git-publish/SKILL.md) | commit・push・PR・公開の前に、書き方を直し、秘密・個人情報・実在パスを機械検査する |
| [knowledge-curator](knowledge-curator/SKILL.md) | 記事やメモを、出典を残したまま知識として整理する |
| [model-routing](model-routing/SKILL.md) | 区切れて確かめられる小さな作業を、安いモデルに任せる |
| [product-experience-review](product-experience-review/SKILL.md) | 利用者が読む生成物・画面の文言が、製品として出せる水準かを立場ごとに読む |
| [project-handover](project-handover/SKILL.md) | セッションや人をまたぐ作業の引き継ぎ書を作る・直す・確かめる |
| [repository-publish](repository-publish/SKILL.md) | 共有する前の短い確認。秘密の検出の限界と、漏れたら失効が先であることを出典付きで書く |
| [review-harshly](review-harshly/SKILL.md) | 作者の意図を知らない第三者として、厳しくレビューする（見落としの点検表付き） |
| [strategic-delivery](strategic-delivery/SKILL.md) | 調べ物・自動化・複数段の作業の前に、事業上の成功の条件を決めて疑う |
| [tabular-read](tabular-read/SKILL.md) | 表・シート・テーブルを全部読まずに、形を見てから要る列だけ取る |

`git-publish` と `repository-publish` は役目が重なっています。手順と機械検査が要るときは `git-publish` を使います。

このフォルダの skill は MIT License です（[LICENSE](LICENSE)）。
