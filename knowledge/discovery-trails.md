---
id: KNOWLEDGE-DISCOVERY-TRAILS
title: Shared URLs and the sources found from them
type: index
status: active
generated_from: knowledge/sources/articles.yml
owners: [knowledge-stewards]
tags: [knowledge, sources, discovery]
---

# 共有した URL と、そこから見つけて使った資料

この文書は [出典台帳](sources/articles.yml) の `intake` と `found_via` から生成する。手で編集しない。

- `intake: shared`: スマホから共有した URL（調査の入口）。
- `intake: found`: 入口をきっかけに調べ、実際に読んで判断や成果に使った資料。`found_via` が入口の ID。

## 入口ごとの資料

### ART-001 Google、AIを使って非構造化テキストから構造化データを抽出するオープンソースPythonライブラリ「LangExtract」をリリース

- 共有した URL: <https://gihyo.jp/article/2025/08/langextract>
- 見つけて使った資料:
  - REF-046 LangExtract (google/langextract) <https://github.com/google/langextract>（`reference`）
  - REF-047 ExtractBench: A Benchmark and Evaluation Methodology for Complex Structured Extraction <https://arxiv.org/abs/2602.12247>（`reference`）
  - REF-048 From Unstructured Recall to Schema-Grounded Memory: Reliable AI Memory via Iterative, Schema-Aware Extraction <https://arxiv.org/abs/2604.27906>（`reference`）

### ART-003 CLAUDE.md の肥大化を 3 層構造で 83% 軽くした — 実測と試行錯誤の記録

- 共有した URL: <https://zenn.dev/pepabo/articles/claude-code-rules-skills-split>
- 見つけて使った資料:
  - REF-012 The new rules of context engineering for Claude 5 generation models <https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models>（`reference`）
  - REF-017 Explore the context window (Claude Code) <https://code.claude.com/docs/en/context-window>（`reference`）
  - REF-018 Effective context engineering for AI agents <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>（`reference`）

### ART-004 Claude Fable 5 が使えるうちに Agent SOP を導入して整備させる

- 共有した URL: <https://zenn.dev/ryu1maniwa25/articles/fable5-agent-sop-setup>
- 見つけて使った資料:
  - REF-012 The new rules of context engineering for Claude 5 generation models <https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models>（`reference`）
  - REF-014 Skill authoring best practices <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>（`reference`）
  - REF-016 SkillsBench: Benchmarking How Well Agent Skills Work Across Diverse Tasks <https://arxiv.org/abs/2602.12670>（`reference`）
  - REF-021 Agent SOP (strands-agents/agent-sop) <https://github.com/strands-agents/agent-sop>（`reference`）
  - REF-022 RFC 2119: Key words for use in RFCs to Indicate Requirement Levels <https://www.rfc-editor.org/rfc/rfc2119>（`reference`）

### ART-006 【決着】Claude CodeとCodexの設定ファイルを同期させる (みんな仲良く)

- 共有した URL: <https://zenn.dev/explaza/articles/20f7f41cff8428>
- 見つけて使った資料:
  - REF-005 AGENTS.md（コーディングエージェント向け指示ファイルの共通形式） <https://agents.md/>（`reference`）
  - REF-010 Build skills (Codex) <https://learn.chatgpt.com/docs/build-skills>（`reference`）
  - REF-011 Plugins overview (Claude Code) <https://code.claude.com/docs/en/plugins/overview>（`reference`）

### ART-007 コードベースのナレッジ化なら、LLM Wikiで十分かもしれない

- 共有した URL: <https://qiita.com/Syoitu/items/ff38655fed51a2920910>
- 見つけて使った資料:
  - REF-041 Evaluating Repository-level Software Documentation via Question Answering and Feature-Driven Development <https://arxiv.org/abs/2604.06793>（`reference`）
  - REF-042 OpenWiki (langchain-ai/openwiki) <https://github.com/langchain-ai/openwiki>（`reference`）
  - REF-043 Identifying Inaccurate Descriptions in LLM-generated Code Comments via Test Execution <https://arxiv.org/abs/2406.14836>（`reference`）

### ART-008 ナレッジグラフを活用してClaude Codeのトークンを10分の1にする

- 共有した URL: <https://zenn.dev/nocodesolutions/articles/19f0d415af42be>
- 見つけて使った資料:
  - REF-018 Effective context engineering for AI agents <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>（`reference`）
  - REF-036 RAG vs. GraphRAG: A Systematic Evaluation and Key Insights <https://arxiv.org/abs/2502.11371>（`reference`）
  - REF-039 CodexGraph: Bridging Large Language Models and Code Repositories via Code Graph Databases <https://arxiv.org/abs/2408.03910>（`reference`）
  - REF-040 Codebase-Memory: Tree-Sitter-Based Knowledge Graphs for LLM Code Exploration via MCP <https://arxiv.org/abs/2603.27277>（`reference`）

### ART-012 claude のメモリを棚卸しする

- 共有した URL: <https://zenn.dev/cureapp/articles/c1e963064d05fd>
- 見つけて使った資料:
  - REF-012 The new rules of context engineering for Claude 5 generation models <https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models>（`reference`）
  - REF-019 STALE: Can LLM Agents Know When Their Memories Are No Longer Valid? <https://arxiv.org/abs/2605.06527>（`reference`）

### ART-013 「Claude Code×GPT」自律ループが凄すぎ、仕事が“3つ”に減る5ステップ

- 共有した URL: <https://www.sbbit.jp/article/cont1/186558>
- 見つけて使った資料:
  - REF-049 Building agents with the Claude Agent SDK <https://claude.com/blog/building-agents-with-the-claude-agent-sdk>（`reference`）
  - REF-050 Effective harnesses for long-running agents <https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents>（`reference`）
  - REF-051 Building effective agents <https://www.anthropic.com/engineering/building-effective-agents>（`reference`）
  - REF-052 Scaling managed agents <https://www.anthropic.com/engineering/managed-agents>（`reference`）
  - REF-053 Measuring AI Ability to Complete Long Software Tasks <https://arxiv.org/abs/2503.14499>（`reference`）
  - REF-054 When Agents Do Not Stop: Uncovering Infinite Agentic Loops in LLM Agents <https://arxiv.org/abs/2607.01641>（`reference`）
  - REF-055 Best practices for Claude Code <https://code.claude.com/docs/en/best-practices>（`reference`）
  - REF-056 LLMs Get Lost In Multi-Turn Conversation <https://arxiv.org/abs/2505.06120>（`reference`）
  - REF-057 Intent Mismatch Causes LLMs to Get Lost in Multi-Turn Conversation <https://arxiv.org/abs/2602.07338>（`reference`）

### ART-015 肥大化し続けるCLAUDE.md

- 共有した URL: <https://zenn.dev/tokium_dev/articles/claude-md-keeps-growing>
- 見つけて使った資料:
  - REF-011 Plugins overview (Claude Code) <https://code.claude.com/docs/en/plugins/overview>（`reference`）
  - REF-017 Explore the context window (Claude Code) <https://code.claude.com/docs/en/context-window>（`reference`）
  - REF-020 Hooks reference (Claude Code) <https://code.claude.com/docs/en/hooks>（`reference`）

### ART-016 オントロジー × グラフ × LLM の実装と評価（基礎編）

- 共有した URL: <https://qiita.com/haystacker/items/853234c38ae36adbca1f>
- 見つけて使った資料:
  - REF-008 Set up Claude Code in a monorepo or large codebase <https://code.claude.com/docs/en/large-codebases>（`reference`）
  - REF-018 Effective context engineering for AI agents <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>（`reference`）
  - REF-036 RAG vs. GraphRAG: A Systematic Evaluation and Key Insights <https://arxiv.org/abs/2502.11371>（`reference`）
  - REF-037 From Local to Global: A Graph RAG Approach to Query-Focused Summarization <https://arxiv.org/abs/2404.16130>（`reference`）

### ART-019 トークン2000分の1——オントロジー×ナレッジグラフでClaude Codeの推測を消す

- 共有した URL: <https://zenn.dev/helloworld/articles/bcaea69f58eae5>
- 見つけて使った資料:
  - REF-008 Set up Claude Code in a monorepo or large codebase <https://code.claude.com/docs/en/large-codebases>（`reference`）
  - REF-018 Effective context engineering for AI agents <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>（`reference`）
  - REF-036 RAG vs. GraphRAG: A Systematic Evaluation and Key Insights <https://arxiv.org/abs/2502.11371>（`reference`）
  - REF-038 Code intelligence plugins (Claude Code) <https://code.claude.com/docs/en/plugins/code-intelligence>（`reference`）

### ART-020 ようやく CLAUDE.md が不要になった

- 共有した URL: <https://zenn.dev/tenkei/articles/bad7b682aed22c>
- 見つけて使った資料:
  - REF-005 AGENTS.md（コーディングエージェント向け指示ファイルの共通形式） <https://agents.md/>（`reference`）
  - REF-006 Custom instructions with AGENTS.md (Codex) <https://learn.chatgpt.com/docs/agent-configuration/agents-md>（`reference`）
  - REF-008 Set up Claude Code in a monorepo or large codebase <https://code.claude.com/docs/en/large-codebases>（`reference`）
  - REF-009 Nested AGENTS.md not loaded when a file in its directory is @-mentioned (nested CLAUDE.md is) <https://github.com/anthropics/claude-code/issues/98796>（`reference`）

### ART-021 CLAUDE.mdをそろそろ見直す時期かも ── Claude 5世代向けの最適化手順・スキル・プロジェクト種類別の例

- 共有した URL: <https://qiita.com/nogataka/items/d6a54f3694726b9141f3>
- 見つけて使った資料:
  - REF-011 Plugins overview (Claude Code) <https://code.claude.com/docs/en/plugins/overview>（`reference`）
  - REF-012 The new rules of context engineering for Claude 5 generation models <https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models>（`reference`）

### ART-022 /claude-api prompt-audit で棚卸ししたら、モデルの版上げで外れた設定がぞろぞろ出てきた

- 共有した URL: <https://zenn.dev/nanora/articles/20260925-claude-prompt-audit-opus55>
- 見つけて使った資料:
  - REF-012 The new rules of context engineering for Claude 5 generation models <https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models>（`reference`）
  - REF-013 Configure models (Claude Code) <https://code.claude.com/docs/en/model-config>（`reference`）

### ART-023 Spotifyのエンジニアが Claude Code のトークン消費を約90%削減した方法とは?

- 共有した URL: <https://article.auone.jp/090465f4-bbd4-4e07-8236-ac82cebd9552>
- 見つけて使った資料:
  - ART-024 Spotify Cut Claude Code Tokens by 90%. We Measured the Same Pattern Ourselves and Got a Different Number <https://thakicloud.com/tech-blog/en/tutorials/spotify-shunt-token-routing/>（`reference`）
  - REF-017 Explore the context window (Claude Code) <https://code.claude.com/docs/en/context-window>（`reference`）
  - REF-020 Hooks reference (Claude Code) <https://code.claude.com/docs/en/hooks>（`reference`）
  - REF-023 Portal by Spotify cut my Claude Code token usage by 90% <https://engineering.atspotify.com/2026/9/portal-by-spotify-cut-my-claude-code-token-usage-by-90>（`reference`）
  - REF-024 shunt plugin (spotify/portal-ai-plugins) <https://github.com/spotify/portal-ai-plugins/blob/main/plugins/shunt/README.md>（`reference`）
  - REF-025 shunt: PreToolUse hooks emit the legacy decision field, rejected by current Claude Code <https://github.com/spotify/portal-ai-plugins/issues/19>（`reference`）
  - REF-026 Subagents (Claude Code) <https://code.claude.com/docs/en/sub-agents>（`reference`）

### ART-025 Claude Codeでトークンを消費する4つの設定と対処法

- 共有した URL: <https://news.yahoo.co.jp/articles/0abb4856706e3274dd5d1c6394ca819a96c28712?page=1>
- 見つけて使った資料:
  - ART-026 I checked my Claude Code usage and found four hidden token drains I never knew about <https://www.makeuseof.com/checked-claude-code-usage-found-four-hidden-token-drains-never-knew-about/>（`reference`）
  - REF-017 Explore the context window (Claude Code) <https://code.claude.com/docs/en/context-window>（`reference`）
  - REF-027 Manage costs effectively (Claude Code) <https://code.claude.com/docs/en/costs>（`reference`）
  - REF-028 Connect to tools with MCP (Claude Code) <https://code.claude.com/docs/en/mcp>（`reference`）
  - REF-029 Commands (Claude Code) <https://code.claude.com/docs/en/commands>（`reference`）

### ART-027 「トークンを削ったのにコストが増えた」 GitHubが明かすAIコーディング“効率化の落とし穴”

- 共有した URL: <https://atmarkit.itmedia.co.jp/ait/spv/2609/17/news023.html>
- 見つけて使った資料:
  - ART-024 Spotify Cut Claude Code Tokens by 90%. We Measured the Same Pattern Ourselves and Got a Different Number <https://thakicloud.com/tech-blog/en/tutorials/spotify-shunt-token-routing/>（`reference`）
  - REF-027 Manage costs effectively (Claude Code) <https://code.claude.com/docs/en/costs>（`reference`）
  - REF-030 How we make AI coding more cost efficient without sacrificing task quality <https://github.blog/ai-and-ml/github-copilot/how-we-make-ai-coding-more-cost-efficient-without-sacrificing-task-quality/>（`reference`）
  - REF-031 How we're making GitHub Copilot smarter with fewer tools <https://github.blog/ai-and-ml/github-copilot/how-were-making-github-copilot-smarter-with-fewer-tools/>（`reference`）

### ART-028 GitHub Copilot のモデル選び 2026/09 版

- 共有した URL: <https://qiita.com/aktsmm/items/bccfc0e945545fe17e58>
- 見つけて使った資料:
  - REF-013 Configure models (Claude Code) <https://code.claude.com/docs/en/model-config>（`reference`）
  - REF-026 Subagents (Claude Code) <https://code.claude.com/docs/en/sub-agents>（`reference`）
  - REF-027 Manage costs effectively (Claude Code) <https://code.claude.com/docs/en/costs>（`reference`）
  - REF-032 Models overview (Claude) <https://platform.claude.com/docs/en/about-claude/models/overview>（`reference`）
  - REF-033 Copilot requests (GitHub Docs) <https://docs.github.com/en/copilot/concepts/billing/copilot-requests>（`reference`）

### ART-029 上位モデルと安いモデルを組み合わせるハーネス「Fusion」が登場

- 共有した URL: <https://gigazine.net/news/20260914-cognition-fusion/>
- 見つけて使った資料:
  - REF-026 Subagents (Claude Code) <https://code.claude.com/docs/en/sub-agents>（`reference`）
  - REF-030 How we make AI coding more cost efficient without sacrificing task quality <https://github.blog/ai-and-ml/github-copilot/how-we-make-ai-coding-more-cost-efficient-without-sacrificing-task-quality/>（`reference`）
  - REF-034 Fusion (Cognition) <https://cognition.com/blog/local-fusion>（`reference`）
  - REF-035 Coding Agent Index v1.5 Methodology (Artificial Analysis) <https://artificialanalysis.ai/methodology/coding-agents-benchmarking>（`reference`）

### ART-030 LLMにWikiを書かせて半年、一番役に立った画面はLLMの文章を使っていなかった

- 共有した URL: <https://zenn.dev/rescuenow/articles/5aa26aebd7ae78>
- 見つけて使った資料:
  - REF-044 From Single to Multi: How LLMs Hallucinate in Multi-Document Summarization <https://aclanthology.org/2025.findings-naacl.293/>（`reference`）
  - REF-045 When Summaries Distort Decisions: Information Fidelity in LLM-Compressed Financial Analysis <https://arxiv.org/abs/2606.29251>（`reference`）

### ART-031 ループエンジニアリング（ralph loop）で業務システムのUIを一新してみた

- 共有した URL: <https://zenn.dev/sompojapan_dx/articles/846c6038fee45d>
- 見つけて使った資料:
  - REF-017 Explore the context window (Claude Code) <https://code.claude.com/docs/en/context-window>（`reference`）
  - REF-050 Effective harnesses for long-running agents <https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents>（`reference`）
  - REF-058 Ralph Wiggum as a "software engineer" <https://ghuntley.com/ralph/>（`reference`）

### ART-032 HTMLを社内共有するサービスを、コードを読まずに作る - 1人で25万行を回す自動運用の記録

- 共有した URL: <https://zenn.dev/coji/articles/solo-software-factory-without-reading-code>
- 見つけて使った資料:
  - REF-059 Maintainer development workflow (artifactshare) <https://github.com/artifactshare/artifactshare/blob/d50596d7d61ec4d54056f413a8e161af04618b3c/docs/development-workflow.md>（`reference`）
  - REF-060 Refute-or-Promote: An Adversarial Stage-Gated Multi-Agent Review Methodology for High-Precision LLM-Assisted Defect Discovery <https://arxiv.org/abs/2604.19049>（`reference`）
  - REF-061 SWR-Bench: Assessing LLM Performance in Real-World Code Review Comment Generation <https://arxiv.org/abs/2509.01494>（`reference`）
  - REF-062 AI-to-AI Code Reviews of GitHub Pull Requests <https://arxiv.org/abs/2608.21311>（`reference`）

### ART-033 AI エージェントを組織構造に乗せる – PLAY が AWS DevOps Agent で築いた全社共通のインシデント対応基盤

- 共有した URL: <https://aws.amazon.com/jp/blogs/news/play-devops-agent-case-study/>
- 見つけて使った資料:
  - REF-049 Building agents with the Claude Agent SDK <https://claude.com/blog/building-agents-with-the-claude-agent-sdk>（`reference`）
  - REF-055 Best practices for Claude Code <https://code.claude.com/docs/en/best-practices>（`reference`）
  - REF-063 Agent instructions (AWS DevOps Agent) <https://docs.aws.amazon.com/devopsagent/latest/userguide/about-aws-devops-agent-agent-instructions.html>（`reference`）
  - REF-064 DevOps Agent Skills (AWS DevOps Agent) <https://docs.aws.amazon.com/devopsagent/latest/userguide/about-aws-devops-agent-devops-agent-skills.html>（`reference`）
  - REF-065 Wired for Overconfidence: A Mechanistic Perspective on Inflated Verbalized Confidence in LLMs <https://arxiv.org/abs/2604.01457>（`reference`）
  - REF-066 Exploring automation bias in human-AI collaboration: a review and implications for explainable AI <https://doi.org/10.1007/s00146-025-02422-7>（`reference`）

### ART-034 月30万円かかるAIは「学習しない社員」だった――LayerXが回し始めた仕事の“自己改善ループ”

- 共有した URL: <https://www.itmedia.co.jp/business/spv/2609/25/news019_2.html>
- 見つけて使った資料:
  - REF-067 Agentic Context Engineering: Evolving Contexts for Self-Improving Language Models <https://arxiv.org/abs/2510.04618>（`reference`）
  - REF-068 Useful Memories Become Faulty When Continuously Updated by LLMs <https://arxiv.org/abs/2605.12978>（`reference`）
  - REF-069 MemDelta: Controlled Baselines and Hidden Confounds in Agent Memory Evaluation <https://arxiv.org/abs/2606.29914>（`reference`）

### REF-001 How Claude remembers your project

- 共有した URL: <https://code.claude.com/docs/en/memory>
- 見つけて使った資料:
  - REF-005 AGENTS.md（コーディングエージェント向け指示ファイルの共通形式） <https://agents.md/>（`reference`）
  - REF-006 Custom instructions with AGENTS.md (Codex) <https://learn.chatgpt.com/docs/agent-configuration/agents-md>（`reference`）
  - REF-007 Provide Context with GEMINI.md Files (Gemini CLI) <https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/gemini-md.md>（`reference`）

### REF-002 Extend Claude with skills

- 共有した URL: <https://code.claude.com/docs/en/skills>
- 見つけて使った資料:
  - REF-014 Skill authoring best practices <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>（`reference`）
  - REF-015 Agent Skills Specification <https://agentskills.io/specification>（`reference`）
  - REF-016 SkillsBench: Benchmarking How Well Agent Skills Work Across Diverse Tasks <https://arxiv.org/abs/2602.12670>（`reference`）

## 入口の記録が無い出典

共有と調査の区別を付ける前に登録した出典。共有 URL として処理されると上へ移る。

- ART-002 PowerPoint との戦いはやめよう — Markdown と Reveal.js でスライド作成 <https://zenn.dev/daming_cafe/articles/reveal-markdown-slides>（`reference`）
- ART-005 Mac mini（M4 Pro / 48GB）で「完全ローカル」のLLM + RAG環境を構築してみた <https://qiita.com/y-okayama-tb/items/0127a7c5203f44507474>（`reference`）
- ART-009 Ollama環境構築 # 自分用メモ <https://zenn.dev/jun1013/articles/17e88035111d7c>（`reference`）
- ART-010 自分のHTML資産を増やすと、AIで見た目の良いサイトを作りやすくなる <https://qiita.com/uni928/items/b4a874f0bbf91d378097>（`adopted`）
- ART-011 Pythonライクな新言語「Mojo」がオープンソースで公開、コンパイラやツールチェーンなど。Windows版の開発も表明 <https://www.publickey1.jp/blog/26/pythonmojowindows.html>（`reference`）
- ART-014 リポジトリにロジックは書くな！ <https://zenn.dev/more_tech_blog/articles/76af481ab3816d>（`reference`）
- ART-017 AIコードレビューを4層に分ける。River ReviewのJudgment Placement設計 <https://zenn.dev/minewo/articles/river-review-judgment-placement>（`adopted`）
- ART-018 社内限定サービスの認証を Google Workspace でサクッと作る <https://zenn.dev/dress_code/articles/6134e6bd5e46c6>（`reference`）
- REF-003 Secret scanning <https://docs.github.com/en/code-security/concepts/secret-security/secret-scanning>（`reference`）
- REF-004 Markdown Architectural Decision Records <https://adr.github.io/madr/>（`reference`）
