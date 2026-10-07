---
id: FOUNDATION
title: Reusable agent environment foundation
type: foundation
status: active
created_at: 2026-09-01
updated_at: 2026-10-07
owners: [knowledge-stewards]
source_ids: [ART-003, ART-006, ART-012, ART-013, ART-015, REF-001, REF-002, REF-049, REF-053]
tags: [claude-code, configuration, onboarding]
---

# Foundation

この領域は、特定の会社・案件・端末に依存しないAIエージェント環境の出発点です。指示ファイルの正本の置き方は [agents-md/](agents-md/)、Claude Code を使う場合は続けて [claude-code/](claude-code/) を読みます。手順をskillへ出すときは [skill-authoring/](skill-authoring/)、運用に入ってから指示が膨らんできたら [instruction-upkeep/](instruction-upkeep/)、エージェント自身が書いた記憶が古くなってきたら [memory-upkeep/](memory-upkeep/) を読みます。常時ではなく1回ごとの大きい読み取りが費用や文脈を押し上げていると感じたら [heavy-read-delegation/](heavy-read-delegation/) を読みます。作業量の感覚より早く枠が尽きるときは、どこに原因があるかを先に当てる [token-drain-review/](token-drain-review/) から始めます。作業を始める段階でどのモデルを選ぶかは [model-tier-selection/](model-tier-selection/)、削る変更を入れたあと、本当に効いたかを判定するときは [cost-change-evaluation/](cost-change-evaluation/) を読みます。探索の費用や答えの正確さに不満があって、索引・ナレッジグラフ・オントロジーを作ろうと考えたときは、作る前に [retrieval-structure-decision/](retrieval-structure-decision/) を読みます。作業を1つずつ指示するのをやめて、まとめて自律で回させたくなったときは [autonomous-loop-delegation/](autonomous-loop-delegation/) を読みます。変更の中身を1行ずつ人が読まない前提で確かめる側を組むときは [review-design/](review-design/) を読みます。人が受け取る境目を決めた後、その人が実際に誤りを捕まえられる形になっているかは [agent-report-handoff/](agent-report-handoff/) を読みます。書かせる量が増えて自分が中身を把握できなくなってきたときは [comprehension-debt/](comprehension-debt/) を読みます。書かせた文章が「AI っぽい」「読みにくい」と感じて直す仕組みを入れようとしたときは [generated-prose-style/](generated-prose-style/) を読みます。扱う資料を外へ出したくない（出せない）ので手元で動かす構成を考え始めたときは、組む前に [local-model-boundary/](local-model-boundary/) を読みます。すでに動いているパイプラインの分岐（振り分け・該当判定）を、文章を生成しない判断専用の仕組みへ置き換えようと考えたときは [typed-decision-gating/](typed-decision-gating/) を読みます。見た目のあるもの（画面・サイト・資料）を作らせていて、毎回「もっと見た目を良くして」と言葉で指示し直しているときは [design-asset-canon/](design-asset-canon/) を読み、資料の形式そのものを選ぶときは [presentations/](presentations/) を読みます。構成図や流れ図をエージェントに描かせようとしたとき、または図を文書に持つと決めたときは [diagram-as-text/](diagram-as-text/) を読みます。後から読む人（数か月後の自分、別のエージェント）が理由を知る必要のある判断をして、それをどこにどの形式で残すか決めるときは [decision-records/](decision-records/) を読みます。エージェントに書かせたものをコミット・公開する経路ができたとき、秘密がどの層で止まるか（止まらないか）を確かめるときは [secret-exposure-layers/](secret-exposure-layers/) を読みます。作った内製ツールを自分以外の人や CI にも使わせることにして、「社内の人だけ」をどう実現するか決めるときは [internal-service-access/](internal-service-access/) を読みます。

## 適用の原則

1. 既存の設定を上書きしない。雛形を読み、必要な部分だけをプロジェクトへ追加する。
2. 常時必要な事実はツール非依存の `AGENTS.md`、そのツールにしか意味のない指示は各ツールの入口ファイル、対象を絞るルールは条件付き読み込みの層、反復手順はskillに置く。
3. ツール固有の設定を無理に同期しない。共有できる事実は一つの正本へ寄せ、実行手順は各ツールに合わせる。
4. 外部公開やデータ変更は、明示的な承認と検証を必要とする。
5. 複数手順を自動化する場合は、完了を示す証拠、反復回数または時間の上限、安全な停止条件、人が引き取る判断点を先に定める。agentの完了報告だけで完了や承認と扱わない。証拠は、規則で判定できるもの（テスト、型、スキーマ）を最上位とし、画面の目視、別モデルによる判定の順に信頼度を下げて扱う（`REF-049`）。任せる長さは、求める成功率と一組で決める。許す失敗率を下げるほど、1回で任せられる作業は短くなる（`REF-053`）。詳しくは [autonomous-loop-delegation/](autonomous-loop-delegation/) を読む。

Claude Codeにおける設定の読み込み範囲とskillsの形式は、[参考資料台帳](../knowledge/sources/articles.yml) の `REF-001` と `REF-002` を確認します。
