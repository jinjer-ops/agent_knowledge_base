---
id: HANDOVER
title: Agent knowledge base handover
type: handover
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
tags: [handover, knowledge, foundation]
---

# Handover

## Purpose and boundary

This public repository is the single entry point for reusable agent-environment guidance, public-safe jinjer guidance, and external reading notes. It stores source links, decisions, experiments, verified practices, and reusable skills. It does not store article copies, credentials, exports, personal data, business data, internal URLs, or local agent state.

Acceptance criteria: a new reader can identify the three areas from the README, apply a generic Claude Code starter without overwriting local settings, find supplied articles and reference material, and distinguish an experiment from an adopted practice.

## Current state — 2026-09-01

Published 2026-09-01: 15 supplied article records, four official/reference records, four topic maps, two decisions, five experiment charters, two practices, two reusable skills, a Claude Code starter, and a public-safe jinjer overlay. Public remote: <https://github.com/jinjer-ops/agent_knowledge_base>.

The source must remain suitable for unrestricted public access. `organization/jinjer/` is an audience label, not an access-control boundary.

## How to continue

1. Read the README, `docs/contribution.md`, and `docs/public-boundary.md`; then inspect `git status --short`.
2. Add article links through `knowledge/sources/articles.yml`, and connect them to the smallest relevant derived artifact.
3. Add reusable initial settings under `foundation/`; add jinjer-specific material only when it is safe for public disclosure.
4. Run the checks below, create a feature branch, and submit a pull request for material changes.

## Decisions

- Sources, interpretations, experiments, practices, and skills are separate layers: `knowledge/decisions/ADR-0001_knowledge_layers.md`.
- Shared agent configuration has one canonical source; agent-specific guidance is not force-synchronized: `knowledge/decisions/ADR-0002_agent_configuration_ssot.md`.
- Local RAG, Ollama, Mojo, extraction, and codebase graphs are retained as experiments, not discarded or pre-approved.

## Environment

Requires Git, GitHub CLI authenticated to the repository owner, and ripgrep. Claude Code users can copy selected skills into their configured skill location after reading `foundation/claude-code/README.md`. No secrets belong in the repository.

## Verification and operations

Run the following commands from the repository root:

```powershell
rg -n "^  id:|^  status:|source_ids" foundation organization knowledge skills
git diff --check
```

Run `quick_validate.py` for changed skills. Before every push, run a targeted scan for credentials, local paths, organization-only identifiers, and copied external content. Roll back a bad classification with a normal Git revert; do not delete source records. Review experiment status after evidence is added, and review `reference` entries at least yearly.

## Artifacts

- Foundation: `foundation/`
- Public-safe organization overlay: `organization/jinjer/`
- Source registry: `knowledge/sources/articles.yml`
- Topic entrypoints: `knowledge/topics/`
- Current decisions: `knowledge/decisions/`
- Experiment charters: `knowledge/experiments/`
- Reusable workflows: `skills/`
