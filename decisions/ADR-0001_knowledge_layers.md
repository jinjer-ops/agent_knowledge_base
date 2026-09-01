---
id: ADR-0001
title: Separate sources, decisions, experiments, practices, and skills
type: decision
status: accepted
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-003, ART-007, ART-012, ART-015]
tags: [knowledge, skills, maintenance]
---

# ADR-0001: Separate knowledge layers

## Decision

Keep supplied articles in `sources/articles.yml`, and keep current interpretation and executable guidance in separate files. A skill is a derived workflow, never the only location of its rationale.

## Rationale

Article facts and tool behavior change. Retaining the source ID preserves the original context, while a short current decision can be revised without rewriting history. This also keeps always-loaded instructions small and makes low-frequency workflows discoverable on demand.

## Status meanings

| Status | Meaning | Promotion condition |
| --- | --- | --- |
| `reference` | A useful option or lens, not yet an intended implementation. | A concrete local use case appears. |
| `experiment` | A bounded hypothesis with success, safety, and exit criteria. | Evidence is recorded and reviewed. |
| `adopted` | A current local decision or verified practice. | Replaced only by a dated decision. |
| `superseded` | Retained history; no longer the current recommendation. | Link the replacement. |

## Consequences

- Do not turn general model knowledge into a note merely because it is true.
- Do record local constraints, evidence, selection rationale, and conditions that change the answer.
- Do not add article copies to Git. Store links and original analysis only.
- Do not build a RAG index over unlicensed copies. Index local documentation or separately approved material.
