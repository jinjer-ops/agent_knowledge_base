---
id: TOPIC-ML-ARCHITECTURE
title: ML infrastructure and application architecture
type: topic
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-011, ART-014]
tags: [ml, mojo, architecture, repositories]
---

# ML infrastructure and application architecture

Use this topic when selecting a low-level ML runtime or reviewing application boundaries.

- Mojo is a technology-radar experiment, not a migration mandate. Compare one profiled hot path to its current implementation and retain correctness, performance, portability, and maintenance evidence.
- Keep business and application rules outside repositories. A repository or gateway should focus on data access and persistence concerns.
