---
name: knowledge-curator
description: Curate supplied articles or notes into a versioned knowledge base, preserving source links and separating references, experiments, practices, and skills.
metadata:
  short-description: Curate article knowledge safely
---

# Knowledge curator

Use this skill when the user provides article URLs, reading notes, or a knowledge backlog and wants them retained and made reusable. Do not use it for a one-off factual answer with no knowledge-base intent.

## Provenance

source_ids: [ART-001, ART-003, ART-006, ART-007, ART-012, REF-002]

## Source of truth

For this repository, read `knowledge/sources/articles.yml` for the source record, `knowledge/reading-guide.md` for the card that explains it, and the existing documents listed in that source's `derived` field before editing. Preserve the original source URL and use source IDs in every derived artifact.

Do not copy full articles into the repository. Record only source metadata, a concise original assessment, and links to related local documents.

## Triage

Classify each source as `reference`, `experiment`, `adopted`, or `superseded`.

- Keep `reference` entries: different scope is not a reason to discard them.
- Use `experiment` when the idea is plausible but needs local evidence, an owner, a safety boundary, and an exit rule.
- Use `adopted` only for an actual current decision or verified practice.
- Use `superseded` when replacing prior guidance; retain the source and link its replacement.

Prefer primary documentation when a tool behavior, version, license, security posture, or current capability could affect the recommendation. Label unverified publication dates and claims as such.

## Derive reusable knowledge

Create or update the smallest appropriate artifact. The directories below are candidates for new material and are created when the first such document is added; do not assume they already hold anything:

- `knowledge/topics/` for "when would I use this?" routing;
- `knowledge/decisions/` for a chosen rule and its alternatives;
- `knowledge/experiments/` for a bounded comparison;
- `knowledge/practices/` for a locally verified procedure;
- `skills/` only for a recurring workflow with clear trigger, inputs, verification, and stopping condition.

Do not create a new skill merely because an article describes a tool. Do not silently install dependencies, create a remote repository, or publish a change. Ask for approval immediately before an external or otherwise material mutation.

## Completion check

Before reporting completion, verify that every new source has an ID, URL, status, `use_when`, and existing derived paths; and every derived artifact declares `source_ids`.
