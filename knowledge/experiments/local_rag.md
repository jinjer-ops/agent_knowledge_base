---
id: EXPERIMENT-LOCAL-RAG
title: Local RAG for approved internal knowledge
type: experiment
status: proposed
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-005, ART-007, ART-016]
tags: [rag, retrieval, local-llm]
---

# Local RAG

## Hypothesis

A local retrieval layer can answer recurring cross-document questions with sufficient provenance while keeping approved content within the chosen environment.

## Preconditions

- Content scope and licenses are approved.
- Corpus refresh owner and deletion/retention rules exist.
- A baseline set of user questions and expected source documents exists.

## Comparison

Compare repository search plus curated topic pages, a maintained LLM Wiki, and local RAG. For questions that require multi-hop relationships, exhaustive sets, or type-and-relation joins, compare vector retrieval with graph/ontology-assisted retrieval separately. Measure answer accuracy, source citation accuracy, refresh latency, operator effort, and query latency.

## Success condition

Adopt only for question classes where the retrieval layer materially improves the baseline and returns inspectable source references. Do not add a graph to simple fact lookup without measured evidence of a retrieval gap.
