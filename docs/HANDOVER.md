---
id: HANDOVER
title: Agent knowledge base handover
type: handover
status: active
created_at: 2026-09-01
updated_at: 2026-10-06
owners: [knowledge-stewards]
tags: [handover, knowledge, foundation]
---

# Handover

## Purpose and boundary

This repository is the single entry point for reusable agent-environment guidance, public-safe jinjer guidance, and external reading notes. It stores source links, a human reading guide, reusable configuration, and reusable skills. It does not store article copies, credentials, exports, personal data, business data, internal URLs, or local agent state.

Acceptance criteria: a new reader can identify the three areas from the README, apply a generic Claude Code starter without overwriting local settings, find every supplied article through the reading guide, and tell from the registry whether a source is adopted or kept only for reference.

## Current state — 2026-10-06

Sources: 103 records in `knowledge/sources/articles.yml`, made up of 34 article records (`ART-001`–`ART-034`) and 69 official or reference records (`REF-001`–`REF-069`). Current status split: 8 `adopted`, 95 `reference`, 0 `experiment`.

Human entry point: `knowledge/reading-guide.md` holds one Japanese card per source, 103 cards in total, covering what each URL says, what it implies here, its current status, and the evidence that supports that status. `ART-013` is adopted only for the general automation-safety principle in `foundation/README.md`; its reported figures are not treated as local verification, and a re-check on 2026-10-06 found the article is member-gated past the second page, so the card records that the earlier full read could not be repeated and that the judgement now rests on the primary sources `REF-049`–`REF-057`. A later page of that article carries its own URL; it is covered by the same `ART-013` card rather than a second source record, since one article gets one ID.

Machine entry point: `knowledge/sources/articles.yml` is canonical for source IDs and URLs. Its `derived` field is the complete reverse index of the documents that declare a source in `source_ids`, so a reader can list every related document from the registry alone. `derived` is an index of related documents; it is not the basis for status.

Other current material: `foundation/` (20 files, including eleven areas added on 2026-10-06: `foundation/agents-md/` for keeping one canonical instruction file across coding agents, `foundation/instruction-upkeep/` for reviewing and trimming instruction files, `foundation/skill-authoring/` for writing and verifying a skill once the decision to extract one has been made, `foundation/memory-upkeep/` for checking agent-written memory against outside facts, which is a question of accuracy rather than size, and which now also records that volume alone can do harm — a controlled measurement reports memory utility rising and then falling below the no-memory baseline, with a keep-the-raw-trace control beating the consolidators, so re-summarising is not a default action and "no memory" stays the comparison, while a peer-reviewed study names the two ways a shrinking loop breaks (brevity bias drops the environment-specific detail first, repeated whole-file rewrites erode what was accumulated), which is why trimming is done as line-level replacement rather than a rewrite, `foundation/heavy-read-delegation/` for deciding, from measured read sizes rather than a published threshold, whether to route large per-call reads to a cheaper model, `foundation/token-drain-review/` for locating what spends tokens besides your own prompts, starting from the product's own usage attribution rather than from a list of suspect settings, `foundation/cost-change-evaluation/` for judging whether a reduction actually helped, since shortening a single tool response can raise the cost of the whole task, and `foundation/model-tier-selection/` for choosing which model tier to start a task on, where the payoff of starting cheap depends on the price ratio and the first-try success rate, and where splitting the work across a supervising tier and a cheaper one is the third option, and `foundation/retrieval-structure-decision/` for deciding, before building an index, knowledge graph, or ontology, whether the retrieval path itself is what is failing, since the product's own default is runtime search rather than a prebuilt index, a graph only pays on multi-hop, temporal, and exhaustive questions, and a peer-reviewed code-graph evaluation reports token costs going up rather than down when the length of query results cannot be bounded, and `foundation/autonomous-loop-delegation/` for deciding how many turns to hand to an agent without a human checkpoint, where the limit is set by whether the work has a machine-checkable test rather than by how capable the model is, where the length that can be delegated falls as the tolerated failure rate falls, and where what actually holds an unattended run to its rules is the strength of the stop mechanism rather than the wording of the instruction file, since instruction-file text is advisory while a hook is deterministic, and which now also records how such a loop is assembled — one task per pass, the specs re-stacked every pass, tests used as back pressure, and the queue, run book, blocked-items list and spec template kept outside the conversation — a shape a field report reached independently of the vendor's own write-up, along with the three ways that report saw it break, and which closes with the counterweight to all of that: a second field report whose checking machinery grew to 644 lines of workflow rules plus 7,200 lines of check code before being cut back to 146, so a gate that cannot show a change it actually stopped is cost rather than safety, and `foundation/review-design/` for deciding how many reviewers to run, how to sort what they report, and when to close the gate, since a published 31-day record had about 79 percent of candidate findings refuted before disclosure, which is why only a finding with a reproducing input counts as a blocker and why the round cap has to close the gate itself rather than wait for the findings to stop; that area is tool-neutral and sits beside, not inside, the Claude Code example rule at `foundation/claude-code/rules/review.md`, which stays short because it is the conditionally-loaded layer; it also holds one unverified hook design under `foundation/claude-code/hooks/always-on-budget/`, kept as a README with the code in a fenced block because unexecuted scripts are not placed in the repository as files, and `foundation/agent-report-handoff/` for the question that follows once a human checkpoint has been placed — whether the person at it can actually catch the error — where a peer-reviewed review of 35 studies reports that adding explanation raises how acceptable a system feels without improving decision accuracy, and that the intervention shown to work is raising the reader's own verification effort, and where a peer-reviewed study reports that verbalized confidence is inflated precisely when the answer is wrong, so an agent's own certainty labels can order what to read first but cannot gate a human check; the resulting rule is to hand over something the reader can open or re-run rather than a better-worded explanation), `organization/jinjer/` (2 files), `skills/` (2 skills), and `docs/` (this handover, the contribution guide, the public boundary policy, and, since 2026-10-06, the Knowledge Inbox coordination folder `docs/knowledge-inbox/`).

There are currently no separate topic, decision, experiment, or practice documents. Thirteen such documents were removed by the repository owner before this change, and the registry was rebuilt around what remains: stale `derived` paths were dropped, six sources moved from `experiment` to `reference` because no experiment charter survives, and one moved from `adopted` to `reference`. Those removals and the rebuilt registry belong to the same publication change and are not published separately. The structure still allows verified decisions, experiments, and practices to be added later; see `docs/contribution.md`.

Remote: <https://github.com/jinjer-ops/agent_knowledge_base>. The repository has been private since 2026-10-06 at the owner's decision; the content must still remain suitable for unrestricted public access so that it can be made public again. `organization/jinjer/` is an audience label, not an access-control boundary.

## How to continue

1. Read the README, `docs/contribution.md`, and `docs/public-boundary.md`; then inspect `git status --short`.
2. Add article links through `knowledge/sources/articles.yml`, add one card per source to `knowledge/reading-guide.md`, and declare `source_ids` in any document that uses the source so the reverse index stays complete.
3. Add reusable initial settings under `foundation/`; add jinjer-specific material only when it is safe for public disclosure.
4. Run the checks below, create a feature branch, and submit a pull request for material changes.

## Decisions in force

- Sources, the human reading guide, and reusable configuration are separate layers, and the same content is not copied between them.
- Shared agent configuration has one canonical source; agent-specific guidance is not force-synchronized.
- `derived` is the complete reverse index of documents declaring a source. Status is decided separately, by whether a verified decision, practice, guidance, or experiment charter exists.
- Sources are never deleted when their local material goes away. They move to `reference` and keep their URL and reading-guide card.

## Environment

Requires Git and Python 3 for the validator, which uses only the standard library. GitHub CLI is needed to open pull requests. Claude Code users can copy selected skills into their configured skill location after reading `foundation/claude-code/README.md`. No secrets belong in the repository.

## Verification and operations

Run the following commands from the repository root:

```powershell
python scripts/validate_knowledge.py
git diff --check
```

`validate_knowledge.py` checks the source ID count, that every `derived` path exists, that `source_ids` declarations and `derived` agree in both directions, that the reading guide holds exactly one card per source, and that the retired term `local guidance` is gone. It prints the specific missing or unsupported paths and exits 1 on failure.

`.github/workflows/knowledge-validation.yml` runs this same command for pull requests targeting `main` and pushes to `main`. It has read-only `contents` permission, installs no project dependencies, and does not deploy or change repository state. The workflow reports validation results, but branch protection is a separate GitHub administrator setting.

Before every push, run a targeted scan for credentials, local paths, organization-only identifiers, and copied external content. Roll back a bad classification with a normal Git revert; do not delete source records. Review a source's status when new local evidence is added, and review `reference` entries at least yearly.

## Artifacts

- Foundation: `foundation/`
- Public-safe organization overlay: `organization/jinjer/`
- Source registry: `knowledge/sources/articles.yml`
- Human reading guide: `knowledge/reading-guide.md`
- Knowledge area entry point: `knowledge/README.md`
- Reusable workflows: `skills/`
- Contribution rules and public boundary: `docs/contribution.md`, `docs/public-boundary.md`
- Knowledge Inbox coordination (status and open questions between the Android app and the PC worker): `docs/knowledge-inbox/`
- Validator: `scripts/validate_knowledge.py`
- CI workflow: `.github/workflows/knowledge-validation.yml`
- CI audit: `docs/audits/2026-09-03-knowledge-validation-ci/`
- Source-adoption audit: `docs/audits/2026-09-03-source-adoption-review/`
