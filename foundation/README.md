---
id: FOUNDATION
title: Reusable agent environment foundation
type: foundation
status: active
created_at: 2026-09-01
updated_at: 2026-10-06
owners: [knowledge-stewards]
source_ids: [ART-003, ART-006, ART-012, ART-013, ART-015, REF-001, REF-002]
tags: [claude-code, configuration, onboarding]
---

# Foundation

この領域は、特定の会社・案件・端末に依存しないAIエージェント環境の出発点です。指示ファイルの正本の置き方は [agents-md/](agents-md/)、Claude Code を使う場合は続けて [claude-code/](claude-code/) を読みます。手順をskillへ出すときは [skill-authoring/](skill-authoring/)、運用に入ってから指示が膨らんできたら [instruction-upkeep/](instruction-upkeep/)、エージェント自身が書いた記憶が古くなってきたら [memory-upkeep/](memory-upkeep/) を読みます。常時ではなく1回ごとの大きい読み取りが費用や文脈を押し上げていると感じたら [heavy-read-delegation/](heavy-read-delegation/) を読みます。作業量の感覚より早く枠が尽きるときは、どこに原因があるかを先に当てる [token-drain-review/](token-drain-review/) から始めます。作業を始める段階でどのモデルを選ぶかは [model-tier-selection/](model-tier-selection/)、削る変更を入れたあと、本当に効いたかを判定するときは [cost-change-evaluation/](cost-change-evaluation/) を読みます。探索の費用や答えの正確さに不満があって、索引・ナレッジグラフ・オントロジーを作ろうと考えたときは、作る前に [retrieval-structure-decision/](retrieval-structure-decision/) を読みます。

## 適用の原則

1. 既存の設定を上書きしない。雛形を読み、必要な部分だけをプロジェクトへ追加する。
2. 常時必要な事実はツール非依存の `AGENTS.md`、そのツールにしか意味のない指示は各ツールの入口ファイル、対象を絞るルールは条件付き読み込みの層、反復手順はskillに置く。
3. ツール固有の設定を無理に同期しない。共有できる事実は一つの正本へ寄せ、実行手順は各ツールに合わせる。
4. 外部公開やデータ変更は、明示的な承認と検証を必要とする。
5. 複数手順を自動化する場合は、完了を示す証拠、反復回数または時間の上限、安全な停止条件、人が引き取る判断点を先に定める。agentの完了報告だけで完了や承認と扱わない。

Claude Codeにおける設定の読み込み範囲とskillsの形式は、[参考資料台帳](../knowledge/sources/articles.yml) の `REF-001` と `REF-002` を確認します。
