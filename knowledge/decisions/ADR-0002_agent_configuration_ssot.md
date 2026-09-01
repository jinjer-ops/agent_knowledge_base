---
id: ADR-0002
title: Keep one source of truth for shared agent configuration
type: decision
status: accepted
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-006]
tags: [agents, configuration, single-source-of-truth]
---

# ADR-0002: Shared agent configuration

## Decision

Classify agent configuration before attempting synchronization:

1. **Shared content**: maintain one canonical source and use a supported reference or link where formats are identical.
2. **Convertible content**: define a neutral schema, transform only the owned section, and preserve unrelated settings and comments.
3. **Agent-specific content**: keep separate guidance where provider behavior, prompts, or capabilities materially differ.

When both derived forms change, stop and present the difference. Do not select a winner from file modification times.

## Rationale

Duplicate configuration silently drifts. Conversely, forcing identical prompts or unsupported features across different agent harnesses degrades behavior. A stored fingerprint of the last synchronized semantic value is a safer change detector than a timestamp.

## Boundaries

This ADR is a design rule, not authorization to install a daemon, alter MCP configuration, create links, or rewrite existing agent files. Any implementation must first inventory exact paths, ownership, supported formats, rollback, and test cases.
