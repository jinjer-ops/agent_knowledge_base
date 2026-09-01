---
id: HANDOVER
title: Agent knowledge base handover
type: handover
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
tags: [handover, knowledge]
---

# Handover

## Purpose and boundary

This public repository makes externally discovered knowledge reusable without treating an article as an operational truth. It is for source links, decisions, experiments, verified practices, and reusable skills. It does not store article copies, credentials, exports, personal data, or business data.

Acceptance criteria: every supplied article has a source ID and current status; every derived artifact links to source IDs; a new reader can find the relevant topic and distinguish an experiment from an adopted practice.

## Current state — 2026-09-01

Published 2026-09-01: source registry with 15 articles, four topic maps, two architecture decisions, five experiment charters, two practices, and the `knowledge-curator` skill source. Public remote: <https://github.com/jinjer-ops/agent_knowledge_base>.

The source must remain suitable for unrestricted public access.

## How to continue

1. Run the checks in the README and inspect `git status --short`.
2. Create a feature branch and submit a pull request for material changes.
3. Run `knowledge-curator` on the next batch of links. Promote a source only after its derived experiment or practice has evidence.
4. Re-run the public-content checks before every push.

## Decisions

- Sources, interpretations, experiments, practices, and skills are separate layers: `ADR-0001`.
- Shared agent configuration has one canonical source; agent-specific guidance is not force-synchronized: `ADR-0002`.
- Local RAG, Ollama, Mojo, extraction, and codebase graphs are retained as experiments, not discarded or pre-approved.

## Environment

Requires Git, GitHub CLI authenticated to the repository owner, and ripgrep. No secrets belong in the repository.

## Verification and operations

Run `rg -n "^  id:|^  status:|source_ids" sources topics decisions experiments practices skills` and `git diff --check`. Roll back a bad classification with a normal Git revert; do not delete source records. Review experiment status after evidence is added, and review `reference` entries at least yearly.

## Artifacts

- Source registry: `sources/articles.yml`
- Topic entrypoints: `topics/`
- Current decisions: `decisions/`
- Experiment charters: `experiments/`
- Reusable workflow: `skills/knowledge-curator/SKILL.md`
