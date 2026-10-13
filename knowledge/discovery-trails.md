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

### ART-002 PowerPoint との戦いはやめよう — Markdown と Reveal.js でスライド作成

- 共有した URL: <https://zenn.dev/daming_cafe/articles/reveal-markdown-slides>
- 見つけて使った資料:
  - REF-129 pptx skill (Anthropic Agent Skills) <https://github.com/anthropics/skills/blob/main/skills/pptx/SKILL.md>（`reference`）
  - REF-130 Marp CLI - PowerPoint (PPTX) conversion <https://github.com/marp-team/marp-cli>（`reference`）
  - REF-131 PDF export (reveal.js) <https://revealjs.com/pdf-export/>（`reference`）
  - REF-132 Revealjs presentations (Quarto) <https://quarto.org/docs/presentations/revealjs/>（`reference`）

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

### ART-005 Mac mini（M4 Pro / 48GB）で「完全ローカル」のLLM + RAG環境を構築してみた

- 共有した URL: <https://qiita.com/y-okayama-tb/items/0127a7c5203f44507474>
- 見つけて使った資料:
  - REF-083 FAQ (Ollama) <https://docs.ollama.com/faq>（`reference`）
  - REF-084 Chat history and embedding truncation happens silently with no user-visible indication (ollama/ollama) <https://github.com/ollama/ollama/issues/14259>（`reference`）
  - REF-099 Data usage (Claude Code) <https://code.claude.com/docs/en/data-usage>（`reference`）
  - REF-100 A Systematic Evaluation of On-Device LLMs: Quantization, Performance, and Resources <https://arxiv.org/abs/2505.15030>（`reference`）
  - REF-101 The Power of Noise: Redefining Retrieval for RAG Systems <https://arxiv.org/abs/2401.14887>（`reference`）
  - REF-102 The Powerless Noise: How Experimental Settings Shape the Reported Power of Noise <https://arxiv.org/abs/2607.03615>（`reference`）
  - REF-103 JMTEB (sbintuitions/JMTEB) <https://github.com/sbintuitions/JMTEB>（`reference`）

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

### ART-009 Ollama環境構築 # 自分用メモ

- 共有した URL: <https://zenn.dev/jun1013/articles/17e88035111d7c>
- 見つけて使った資料:
  - REF-083 FAQ (Ollama) <https://docs.ollama.com/faq>（`reference`）
  - REF-084 Chat history and embedding truncation happens silently with no user-visible indication (ollama/ollama) <https://github.com/ollama/ollama/issues/14259>（`reference`）
  - REF-104 Silent Brothers: Ollama Hosts Form Anonymous AI Network Beyond Platform Guardrails <https://www.sentinelone.com/labs/silent-brothers-ollama-hosts-form-anonymous-ai-network-beyond-platform-guardrails/>（`reference`）
  - REF-105 12,000 Ollama Instances Exposed: When 'Local-First' Meets the Real World <https://blog.leakix.net/2026/02/ollama-exposed/>（`reference`）
  - REF-106 Ollama contains a heap out-of-bounds read vulnerability in the GGUF model loader (CVE-2026-7482) <https://github.com/advisories/GHSA-x8qc-fggm-mpqg>（`reference`）
  - REF-107 Lost in the Middle: How Language Models Use Long Contexts <https://arxiv.org/abs/2307.03172>（`reference`）

### ART-010 自分のHTML資産を増やすと、AIで見た目の良いサイトを作りやすくなる

- 共有した URL: <https://qiita.com/uni928/items/b4a874f0bbf91d378097>
- 見つけて使った資料:
  - REF-124 Figma2Code: Automating Multimodal Design to Code in the Wild <https://arxiv.org/abs/2604.13648>（`reference`）
  - REF-125 Claude Code and Figma - Set up the MCP server <https://help.figma.com/hc/en-us/articles/39888612464151-Claude-Code-and-Figma-Set-up-the-MCP-server>（`reference`）
  - REF-126 Registry (shadcn/ui) <https://ui.shadcn.com/docs/registry>（`reference`）
  - REF-127 Generated Inaccessible: Measuring WCAG Violations in AI UI Design Tools <https://dl.acm.org/doi/10.1145/3800424.3800430>（`reference`）
  - REF-128 Design Tokens Format Module (W3C Design Tokens Community Group, draft) <https://www.designtokens.org/tr/drafts/format/>（`reference`）

### ART-011 Pythonライクな新言語「Mojo」がオープンソースで公開、コンパイラやツールチェーンなど。Windows版の開発も表明

- 共有した URL: <https://www.publickey1.jp/blog/26/pythonmojowindows.html>
- 見つけて使った資料:
  - REF-180 ModCon 2026: Open source, open cloud, open silicon <https://www.modular.com/blog/modcon-announcements>（`reference`）
  - REF-181 Modular 26.5: Mojo 1.0 is here! <https://www.modular.com/blog/modular-26-5-mojo-1-0-is-here>（`reference`）
  - REF-182 We Have a Package for You! A Comprehensive Analysis of Package Hallucinations by Code Generating LLMs <https://www.usenix.org/publications/loginonline/we-have-package-you-comprehensive-analysis-package-hallucinations-code>（`reference`）
  - REF-183 The Range Shrinks, the Threat Remains: Re-evaluating LLM Package Hallucinations on the 2026 Frontier-Model Cohort <https://arxiv.org/abs/2605.17062>（`reference`）
  - REF-184 GitChameleon 2.0: Evaluating AI Code Generation Against Python Library Version Incompatibilities <https://arxiv.org/abs/2507.12367>（`reference`）
  - REF-185 Type-Constrained Code Generation with Language Models <https://arxiv.org/abs/2504.09246>（`reference`）
  - REF-186 Knowledge Transfer from High-Resource to Low-Resource Programming Languages for Code LLMs <https://arxiv.org/abs/2308.09895>（`reference`）

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

### ART-014 リポジトリにロジックは書くな！

- 共有した URL: <https://zenn.dev/more_tech_blog/articles/76af481ab3816d>
- 見つけて使った資料:
  - REF-187 Repository (Patterns of Enterprise Application Architecture catalog) <https://martinfowler.com/eaaCatalog/repository.html>（`reference`）
  - REF-188 Anemic Domain Model <https://martinfowler.com/bliki/AnemicDomainModel.html>（`reference`）
  - REF-189 dependency-cruiser: rules reference <https://github.com/sverweij/dependency-cruiser/blob/main/doc/rules-reference.md>（`reference`）
  - REF-190 An Empirical Evaluation of Large Language Models Applying Software Architectural Patterns <https://doi.org/10.3390/ai7060195>（`reference`）
  - REF-191 Quantitative Analysis of Technical Debt and Pattern Violation in Large Language Model Architectures <https://arxiv.org/abs/2512.04273>（`reference`）

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

### ART-017 AIコードレビューを4層に分ける。River ReviewのJudgment Placement設計

- 共有した URL: <https://zenn.dev/minewo/articles/river-review-judgment-placement>
- 見つけて使った資料:
  - REF-073 Judgment Placement (River Review documentation) <https://river-review.the3396.com/explanation/judgment-placement/>（`reference`）
  - REF-074 river-review (s977043/river-review) <https://github.com/s977043/river-review>（`reference`）
  - REF-075 Software Engineering at Google, Chapter 20: Static Analysis <https://abseil.io/resources/swe-book/html/ch20.html>（`reference`）
  - REF-076 claude-code-security-review (anthropics/claude-code-security-review) <https://github.com/anthropics/claude-code-security-review>（`reference`）
  - REF-077 Comment and Control: GitHub AI Agents as Credential Exfiltrators <https://labs.cloudsecurityalliance.org/research/csa-research-note-comment-control-github-prompt-injection-20/>（`reference`）
  - REF-078 Keeping your GitHub Actions and workflows secure Part 1: Preventing pwn requests <https://securitylab.github.com/resources/github-actions-preventing-pwn-requests/>（`reference`）

### ART-018 社内限定サービスの認証を Google Workspace でサクッと作る

- 共有した URL: <https://zenn.dev/dress_code/articles/6134e6bd5e46c6>
- 見つけて使った資料:
  - REF-149 OpenID Connect (Google Identity) <https://developers.google.com/identity/openid-connect/openid-connect>（`reference`）
  - REF-150 Securing your app with signed headers (Identity-Aware Proxy) <https://docs.cloud.google.com/iap/docs/signed-headers-howto>（`reference`）
  - REF-151 Millions of Accounts Vulnerable due to Google's OAuth Flaw <https://trufflesecurity.com/blog/millions-at-risk-due-to-google-s-oauth-flaw>（`reference`）
  - REF-152 DeleFriend: a design flaw in Domain-Wide Delegation <https://www.hunters.security/en/blog/delefriend-a-newly-discovered-design-flaw-in-domain-wide-delegation-could-leave-google-workspace-vulnerable-for-takeover>（`reference`）
  - REF-153 Best practices for managing service account keys (Google Cloud) <https://docs.cloud.google.com/iam/docs/best-practices-for-managing-service-account-keys>（`reference`）

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

### ART-035 AIに丸投げしないで理解するためのAI開発手法（2026年8月現在）

- 共有した URL: <https://zenn.dev/avaintelligence/articles/dont-outsource-understanding-to-ai>
- 見つけて使った資料:
  - REF-017 Explore the context window (Claude Code) <https://code.claude.com/docs/en/context-window>（`reference`）
  - REF-066 Exploring automation bias in human-AI collaboration: a review and implications for explainable AI <https://doi.org/10.1007/s00146-025-02422-7>（`reference`）
  - REF-070 How AI assistance impacts the formation of coding skills <https://www.anthropic.com/research/AI-assistance-coding-skills>（`reference`）
  - REF-071 (Im)Paired Programming: Coding Agents Improve Productivity but Harm Understanding <https://arxiv.org/abs/2607.26375>（`reference`）
  - REF-072 Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity <https://arxiv.org/abs/2507.09089>（`reference`）

### ART-036 shadcn/lint で AI エージェントにデザインシステムのルールを守らせる

- 共有した URL: <https://zenn.dev/my_vision/articles/c602a080fc4a91>
- 見つけて使った資料:
  - REF-079 @shadcn/lint (shadcn-ui/lint) <https://github.com/shadcn-ui/lint>（`reference`）
  - REF-080 Evals (shadcn-ui/lint) <https://github.com/shadcn-ui/lint/blob/main/docs/evals.md>（`reference`）
  - REF-081 Is Self-Repair a Silver Bullet for Code Generation? <https://arxiv.org/abs/2306.09896>（`reference`）
  - REF-082 Natural emergent misalignment from reward hacking <https://www.anthropic.com/research/emergent-misalignment-reward-hacking>（`reference`）

### ART-037 トークンをケチってレビューをローカルLLMにやらせた話

- 共有した URL: <https://zenn.dev/k_motoki/articles/11de0ba46dd1ee>
- 見つけて使った資料:
  - REF-083 FAQ (Ollama) <https://docs.ollama.com/faq>（`reference`）
  - REF-084 Chat history and embedding truncation happens silently with no user-visible indication (ollama/ollama) <https://github.com/ollama/ollama/issues/14259>（`reference`）
  - REF-085 Let Me Speak Freely? A Study on the Impact of Format Restrictions on Performance of Large Language Models <https://aclanthology.org/2024.emnlp-industry.91/>（`reference`）
  - REF-086 OpenCodeReview: Determinism over Non-Determinism for Cost-Effective Agent-Based Code Review <https://arxiv.org/abs/2608.09290>（`reference`）

### ART-038 日本語の「AI 臭さ」をチェックする Rust 製 Linter「noslop」を作った

- 共有した URL: <https://zenn.dev/owayo/articles/e081901888ae82>
- 見つけて使った資料:
  - REF-020 Hooks reference (Claude Code) <https://code.claude.com/docs/en/hooks>（`reference`）
  - REF-075 Software Engineering at Google, Chapter 20: Static Analysis <https://abseil.io/resources/swe-book/html/ch20.html>（`reference`）
  - REF-087 noslop (owayo/noslop) <https://github.com/owayo/noslop>（`reference`）
  - REF-088 Delving into LLM-assisted writing in biomedical publications through excess vocabulary <https://arxiv.org/abs/2406.07016>（`reference`）
  - REF-089 The Shrinking Landscape of Linguistic Diversity in the Age of Large Language Models <https://arxiv.org/abs/2502.11266>（`reference`）
  - REF-090 GPT detectors are biased against non-native English writers <https://arxiv.org/abs/2304.02819>（`reference`）
  - REF-091 textlint-rule-preset-ja-technical-writing (textlint-ja) <https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing>（`reference`）

### ART-039 【最新v1.0.8公開】AI-Slopな日本語を構造レベルで読みやすくするSkill「yomiyasu」を作りました

- 共有した URL: <https://zenn.dev/algoartis/articles/0b1c731881b25c>
- 見つけて使った資料:
  - REF-081 Is Self-Repair a Silver Bullet for Code Generation? <https://arxiv.org/abs/2306.09896>（`reference`）
  - REF-087 noslop (owayo/noslop) <https://github.com/owayo/noslop>（`reference`）
  - REF-089 The Shrinking Landscape of Linguistic Diversity in the Age of Large Language Models <https://arxiv.org/abs/2502.11266>（`reference`）
  - REF-092 yomiyasu (nanaism/yomiyasu) <https://github.com/nanaism/yomiyasu>（`reference`）
  - REF-093 Evaluating Factuality in Text Simplification <https://aclanthology.org/2022.acl-long.506/>（`reference`）
  - REF-094 LLM Evaluators Recognize and Favor Their Own Generations <https://proceedings.neurips.cc/paper_files/paper/2024/file/7f1f0218e45f5414c79c0679633e47bc-Paper-Conference.pdf>（`reference`）
  - REF-095 ISO plain language standard (Plain Language Association International) <https://plainlanguage.com/what-is-plain-language/iso-plain-language-standard/>（`reference`）

### ART-040 新しい日本語推敲スキル「yomiyasu」がバズっていたので、Claudeで日本語推敲スキル3つを比べてみた

- 共有した URL: <https://qiita.com/inoyu-qiita/items/0ffe6e74ecaf3aaa8b14>
- 見つけて使った資料:
  - REF-087 noslop (owayo/noslop) <https://github.com/owayo/noslop>（`reference`）
  - REF-092 yomiyasu (nanaism/yomiyasu) <https://github.com/nanaism/yomiyasu>（`reference`）
  - REF-093 Evaluating Factuality in Text Simplification <https://aclanthology.org/2022.acl-long.506/>（`reference`）
  - REF-096 Dancing Between Success and Failure: Edit-level Simplification Evaluation using SALSA <https://arxiv.org/abs/2305.14458>（`reference`）
  - REF-097 Adding Error Bars to Evals: A Statistical Approach to Language Model Evaluations <https://arxiv.org/abs/2411.00640>（`reference`）
  - REF-098 natural-japanese (coji/natural-japanese) <https://github.com/coji/natural-japanese>（`reference`）

### ART-041 Jev の使いどころと、同じ形のオープン実装まとめ

- 共有した URL: <https://zenn.dev/karaage0703/articles/jev-use-cases-open-implementations>
- 見つけて使った資料:
  - REF-065 Wired for Overconfidence: A Mechanistic Perspective on Inflated Verbalized Confidence in LLMs <https://arxiv.org/abs/2604.01457>（`reference`）
  - REF-085 Let Me Speak Freely? A Study on the Impact of Format Restrictions on Performance of Large Language Models <https://aclanthology.org/2024.emnlp-industry.91/>（`reference`）
  - REF-108 Confidence (TypeSafe AI docs) <https://docs.typesafe.ai/confidence>（`reference`）
  - REF-109 Jev 1.13 jaggedness (TypeSafe AI docs) <https://docs.typesafe.ai/model-jaggedness/jev-1.13>（`reference`）
  - REF-110 Evaluating Decision Models for Text Annotation in Computational Social Science <https://arxiv.org/abs/2609.24574>（`reference`）
  - REF-111 Jevはどれだけ優秀なif文か？軽量モデルを分類器用途で比較してみた <https://journal.supa.ai/jev-classifier-benchmark/>（`reference`）
  - REF-112 I tried replacing model routing with TypeSafe (Jev) to see how much faster and cheaper it would get <https://dev.classmethod.jp/en/articles/jev-for-llm-model-routing/>（`reference`）

### ART-042 Jev と Cosmos DB で、ベクトル検索の結果を観点別に絞る PoC

- 共有した URL: <https://zenn.dev/nomhiro/articles/jev-cosmosdb-rag-filter-poc>
- 見つけて使った資料:
  - REF-101 The Power of Noise: Redefining Retrieval for RAG Systems <https://arxiv.org/abs/2401.14887>（`reference`）
  - REF-102 The Powerless Noise: How Experimental Settings Shape the Reported Power of Noise <https://arxiv.org/abs/2607.03615>（`reference`）
  - REF-103 JMTEB (sbintuitions/JMTEB) <https://github.com/sbintuitions/JMTEB>（`reference`）
  - REF-108 Confidence (TypeSafe AI docs) <https://docs.typesafe.ai/confidence>（`reference`）
  - REF-113 Corrective Retrieval Augmented Generation <https://arxiv.org/abs/2401.15884>（`reference`）
  - REF-114 Integrated vector store (Azure Cosmos DB for NoSQL) <https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/vector-search>（`reference`）
  - REF-115 ARAGOG: Advanced RAG Output Grading <https://arxiv.org/abs/2404.01037>（`reference`）
  - REF-116 Per-Query Gating of LLM Rerankers for Multi-Hop Retrieval <https://arxiv.org/abs/2609.22880>（`reference`）

### ART-043 Cloudflare 上で Jev を使い、ごく低い費用でページ内検索を作る

- 共有した URL: <https://zenn.dev/mazrean/articles/bd9b563ace18db>
- 見つけて使った資料:
  - REF-108 Confidence (TypeSafe AI docs) <https://docs.typesafe.ai/confidence>（`reference`）
  - REF-111 Jevはどれだけ優秀なif文か？軽量モデルを分類器用途で比較してみた <https://journal.supa.ai/jev-classifier-benchmark/>（`reference`）
  - REF-115 ARAGOG: Advanced RAG Output Grading <https://arxiv.org/abs/2404.01037>（`reference`）
  - REF-117 BEIR: A Heterogenous Benchmark for Zero-shot Evaluation of Information Retrieval Models <https://arxiv.org/abs/2104.08663>（`reference`）
  - REF-118 bge-reranker-base (Cloudflare Workers AI) <https://developers.cloudflare.com/workers-ai/models/bge-reranker-base/>（`reference`）
  - REF-119 M3-Embedding: Multi-Linguality, Multi-Functionality, Multi-Granularity Text Embeddings Through Self-Knowledge Distillation <https://arxiv.org/abs/2402.03216>（`reference`）

### ART-044 完全版 Claude Mods 入門 | Claude Code を自由にカスタマイズする

- 共有した URL: <https://zenn.dev/nogu66/articles/claude-mods-complete-guide>
- 見つけて使った資料:
  - REF-120 Mods overview (Claude Code) <https://code.claude.com/docs/en/plugins/mods/overview>（`reference`）
  - REF-121 React to events with a mod (Claude Code) <https://code.claude.com/docs/en/plugins/mods/events>（`reference`）
  - REF-122 Manage mods for your organization (Claude Code) <https://code.claude.com/docs/en/plugins/mods/admin>（`reference`）
  - REF-123 Mods reference (Claude Code) <https://code.claude.com/docs/en/plugins/mods/reference>（`reference`）

### ART-045 アーキテクチャ図を念頭に置いて設計された斬新な自動レイアウトアルゴリズム「TALA」がオープンソース化

- 共有した URL: <https://gigazine.net/news/20260909-tala-is-open-source/>
- 見つけて使った資料:
  - REF-133 TALA is open source (D2) <https://d2lang.com/blog/tala-is-open-source/>（`reference`）
  - REF-134 Layouts (D2) <https://d2lang.com/tour/layouts/>（`reference`）
  - REF-135 Creating diagrams (GitHub Docs) <https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams>（`reference`）
  - REF-136 DiagramEval: Evaluating LLM-Generated Diagrams via Graphs <https://arxiv.org/abs/2510.25761>（`reference`）
  - REF-137 MermaidSeqBench: An Evaluation Benchmark for NL-to-Mermaid Sequence Diagram Generation <https://arxiv.org/abs/2511.14967>（`reference`）

### ART-046 Windows + AIコーディングエージェントで踏んだ罠をまとめた

- 共有した URL: <https://zenn.dev/mukuil_blog/articles/9a048ea2e8dec4>
- 見つけて使った資料:
  - REF-154 about_Character_Encoding (PowerShell 5.1) <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_character_encoding?view=powershell-5.1>（`reference`）
  - REF-155 Use UTF-8 code pages in Windows apps <https://learn.microsoft.com/en-us/windows/apps/design/globalizing/use-utf8-code-page>（`reference`）
  - REF-156 Configuring Git to handle line endings <https://docs.github.com/en/get-started/git-basics/configuring-git-to-handle-line-endings>（`reference`）
  - REF-157 Set Files On-Demand states in Windows <https://learn.microsoft.com/en-us/onedrive/files-on-demand-windows>（`reference`）
  - REF-158 Edit tool silently destroys some files in OneDrive-synced folders via non-deterministic delete-then-rename race (Windows) <https://github.com/anthropics/claude-code/issues/65229>（`reference`）
  - REF-159 Cowork silently corrupts files in OneDrive folders with Files-On-Demand <https://github.com/anthropics/claude-code/issues/62140>（`reference`）
  - REF-160 Explore agent triggers unscoped file access, causing OneDrive to download cloud-only files <https://github.com/anthropics/claude-code/issues/35513>（`reference`）
  - REF-161 Claude Code advanced setup <https://code.claude.com/docs/en/setup>（`reference`）

### ART-047 Claudeは計画、Antigravityは実行。AIを2つ使い分けたら開発が回りはじめた

- 共有した URL: <https://www.lifehacker.jp/article/2609-antigravity-writes-better-code-than-claude-still-use-claude-first/>
- 見つけて使った資料:
  - REF-162 Rules — Antigravity docs <https://antigravity.google/docs/rules/>（`reference`）
  - REF-163 Artifacts — Antigravity docs <https://antigravity.google/docs/artifacts>（`reference`）
  - REF-164 Choose a permission mode <https://code.claude.com/docs/en/permission-modes>（`reference`）
  - REF-165 From Plan to Action: How Well Do Agents Follow the Plan? <https://arxiv.org/abs/2604.12147>（`reference`）
  - REF-166 Context Rot: How Increasing Input Tokens Impacts LLM Performance <https://www.trychroma.com/research/context-rot>（`reference`）
  - REF-167 Diagnosing and Mitigating Context Rot in Long-horizon Search <https://arxiv.org/abs/2606.29718>（`reference`）

### ART-048 Opus 5.5にプロンプトを渡したら、解説アニメーション動画ができた

- 共有した URL: <https://zenn.dev/acntechjp/articles/178e40be12d347>
- 見つけて使った資料:
  - REF-168 Share session output as artifacts <https://code.claude.com/docs/en/artifacts>（`reference`）
  - REF-169 Using randomness <https://www.remotion.dev/docs/using-randomness>（`reference`）
  - REF-170 Does animation enhance learning? A meta-analysis <https://www.sciencedirect.com/science/article/abs/pii/S0360131516301336>（`reference`）
  - REF-171 Understanding SC 2.3.1: Three Flashes or Below Threshold <https://www.w3.org/WAI/WCAG22/Understanding/three-flashes-or-below-threshold.html>（`reference`）
  - REF-172 Understanding SC 2.2.2: Pause, Stop, Hide <https://www.w3.org/WAI/WCAG22/Understanding/pause-stop-hide.html>（`reference`）
  - REF-173 Understanding SC 1.2.2: Captions (Prerecorded) <https://www.w3.org/WAI/WCAG22/Understanding/captions-prerecorded.html>（`reference`）
  - REF-174 prefers-reduced-motion <https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion>（`reference`）

### ART-049 「Claudeを2週間で3倍速にした方法」をAnthropicが解説

- 共有した URL: <https://gigazine.net/news/20260924-anthropic-faster-claude/>
- 見つけて使った資料:
  - REF-082 Natural emergent misalignment from reward hacking <https://www.anthropic.com/research/emergent-misalignment-reward-hacking>（`reference`）
  - REF-175 How we made claude.ai 3x faster in two weeks <https://claude.dev/blog/how-we-made-claude-ai-faster/>（`reference`）
  - REF-176 Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity <https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/>（`reference`）
  - REF-177 SpecBench: Measuring Reward Hacking in Long-Horizon Coding Agents <https://arxiv.org/abs/2605.21384>（`reference`）
  - REF-178 Why lab and field data can be different (and what to do about it) <https://web.dev/articles/lab-and-field-data-differences>（`reference`）
  - REF-179 CI for performance: Reliable benchmarking in noisy environments <https://pythonspeed.com/articles/consistent-benchmarking-in-ci/>（`reference`）

### ART-050 デザインハーネスを個人開発で組んだ — AI が作る画面のずれを止めるまで

- 共有した URL: <https://zenn.dev/yoshihiko555/articles/e9801e0ad1efb8>
- 見つけて使った資料:
  - REF-127 Generated Inaccessible: Measuring WCAG Violations in AI UI Design Tools <https://dl.acm.org/doi/10.1145/3800424.3800430>（`reference`）
  - REF-128 Design Tokens Format Module (W3C Design Tokens Community Group, draft) <https://www.designtokens.org/tr/drafts/format/>（`reference`）
  - REF-192 The Automated Accessibility Coverage Report (Deque) <https://www.deque.com/automated-accessibility-testing-coverage/>（`reference`）
  - REF-193 Visual comparisons (Playwright docs) <https://playwright.dev/docs/test-snapshots>（`reference`）
  - REF-194 Theme variables (Tailwind CSS docs) <https://tailwindcss.com/docs/theme>（`reference`）
  - REF-195 MLLM as a UI Judge: Benchmarking Multimodal LLMs for Predicting Human Perception of User Interfaces <https://arxiv.org/abs/2510.08783>（`reference`）
  - REF-196 Can Multimodal LLMs Model Expert Ratings in Mobile UI Usability Evaluation? <https://link.springer.com/chapter/10.1007/978-3-032-30549-7_12>（`reference`）
  - REF-197 What Are Developers Actually Discussing When Visual Regression Tests Fail? <https://arxiv.org/abs/2608.07020>（`reference`）

### ART-051 判断専用モデルを日本語校正プラグインへ実際に組み込み、所要時間を測った記録

- 共有した URL: <https://zenn.dev/bamboo_nova/articles/c6176164dcffd0>
- 見つけて使った資料:
  - REF-198 Parallel questions (TypeSafe AI cookbooks) <https://docs.typesafe.ai/cookbooks/parallel_questions>（`reference`）
  - REF-199 When Does Confidence-Based Cascade Deferral Suffice? <https://arxiv.org/abs/2307.02764>（`reference`）
  - REF-200 Run Claude Code programmatically (headless / `-p`) <https://code.claude.com/docs/en/headless>（`reference`）
  - REF-201 Jev: Inside TypeSafe AI's First System One Decision Model <https://www.hyperstack.cloud/technical-resources/tutorials/jev-inside-typesafe-ais-first-system-one-decision-model>（`reference`）

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

### REF-003 Secret scanning

- 共有した URL: <https://docs.github.com/en/code-security/concepts/secret-security/secret-scanning>
- 見つけて使った資料:
  - REF-143 Push protection (GitHub) <https://docs.github.com/en/code-security/concepts/secret-security/push-protection>（`reference`）
  - REF-144 Supported secret scanning patterns (GitHub) <https://docs.github.com/en/code-security/reference/secret-security/supported-secret-scanning-patterns>（`reference`）
  - REF-145 Configure permissions (Claude Code) <https://code.claude.com/docs/en/permissions>（`reference`）
  - REF-146 A Comparative Study of Software Secrets Reporting by Secret Detection Tools <https://arxiv.org/abs/2307.00714>（`reference`）
  - REF-147 How Bad Can It Git? Characterizing Secret Leakage in Public GitHub Repositories <https://www.ndss-symposium.org/wp-content/uploads/2019/02/ndss2019_04B-3_Meli_paper.pdf>（`reference`）
  - REF-148 The State of Secrets Sprawl 2026 <https://blog.gitguardian.com/the-state-of-secrets-sprawl-2026/>（`reference`）

### REF-004 Markdown Architectural Decision Records

- 共有した URL: <https://adr.github.io/madr/>
- 見つけて使った資料:
  - REF-138 Documenting Architecture Decisions (Michael Nygard) <https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions>（`reference`）
  - REF-139 One Size Fits All? An Empirical Comparison of ADR Templates regarding Comprehension, Usability, and Ease of Adoption <https://arxiv.org/abs/2604.27333>（`reference`）
  - REF-140 Using Architecture Decision Records in Open Source Projects - An MSR Study on GitHub <https://research.jku.at/en/publications/using-architecture-decision-records-in-open-source-projects-an-ms/>（`reference`）
  - REF-141 Evaluating Large Language Models for Detecting Architectural Decision Violations <https://arxiv.org/abs/2602.07609>（`reference`）
  - REF-142 Coding Agents Love Decision Records <https://www.oreilly.com/radar/coding-agents-love-decision-records/>（`reference`）
