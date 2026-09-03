---
id: HANDOVER
title: Agent knowledge base handover
type: handover
status: active
created_at: 2026-09-01
updated_at: 2026-09-03
owners: [knowledge-stewards]
tags: [handover, knowledge, foundation]
---

# Handover

## Purpose and boundary

This public repository is the single entry point for reusable agent-environment guidance, public-safe jinjer guidance, and external reading notes. It stores source links, a human reading guide, reusable configuration, and reusable skills. It does not store article copies, credentials, exports, personal data, business data, internal URLs, or local agent state.

Acceptance criteria: a new reader can identify the three areas from the README, apply a generic Claude Code starter without overwriting local settings, find every supplied article through the reading guide, and tell from the registry whether a source is adopted or kept only for reference.

## Current state — 2026-09-03

Sources: 23 records in `knowledge/sources/articles.yml`, made up of 19 article records (`ART-001`–`ART-019`) and 4 official or reference records (`REF-001`–`REF-004`). Current status split: 8 `adopted`, 15 `reference`, 0 `experiment`.

Human entry point: `knowledge/reading-guide.md` holds one Japanese card per source, 23 cards in total, covering what each URL says, what it implies here, its current status, and the evidence that supports that status. `ART-013` was reviewed across all three public pages and is adopted only for the general automation-safety principle in `foundation/README.md`; its reported figures are not treated as local verification.

Machine entry point: `knowledge/sources/articles.yml` is canonical for source IDs and URLs. Its `derived` field is the complete reverse index of the documents that declare a source in `source_ids`, so a reader can list every related document from the registry alone. `derived` is an index of related documents; it is not the basis for status.

Other current material: `foundation/` (6 files), `organization/jinjer/` (2 files), `skills/` (2 skills), and `docs/` (this handover, the contribution guide, and the public boundary policy).

There are currently no separate topic, decision, experiment, or practice documents. Thirteen such documents were removed by the repository owner before this change, and the registry was rebuilt around what remains: stale `derived` paths were dropped, six sources moved from `experiment` to `reference` because no experiment charter survives, and one moved from `adopted` to `reference`. Those removals and the rebuilt registry belong to the same publication change and are not published separately. The structure still allows verified decisions, experiments, and practices to be added later; see `docs/contribution.md`.

Public remote: <https://github.com/jinjer-ops/agent_knowledge_base>. The source must remain suitable for unrestricted public access. `organization/jinjer/` is an audience label, not an access-control boundary.

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
- Validator: `scripts/validate_knowledge.py`
- CI workflow: `.github/workflows/knowledge-validation.yml`
- CI audit: `docs/audits/2026-09-03-knowledge-validation-ci/`
- Source-adoption audit: `docs/audits/2026-09-03-source-adoption-review/`
