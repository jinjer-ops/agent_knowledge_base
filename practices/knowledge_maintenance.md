---
id: PRACTICE-KNOWLEDGE-MAINTENANCE
title: Knowledge-base maintenance
type: practice
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-003, ART-012, ART-015]
tags: [maintenance, knowledge, agent-instructions]
---

# Knowledge-base maintenance

Run after a material batch of source additions, before a major handoff, or at least annually.

1. Measure source count, derived document count, broken internal links, and entries without a review date.
2. Verify that every `derived` path in `sources/articles.yml` exists.
3. Check that every adopted decision, practice, and skill declares `source_ids`.
4. Archive superseded guidance instead of deleting its source record.
5. Review agent instructions separately from this repository; do not copy detailed procedures into always-loaded instruction files.

Changes that rewrite meaning, merge records, or remove material require review. Link repair and metadata completion are reversible maintenance.
