---
id: TOPIC-KNOWLEDGE-SYSTEM
title: Knowledge system and retrieval options
type: topic
status: active
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-001, ART-005, ART-007, ART-008, ART-009, ART-012, ART-016]
tags: [knowledge, rag, retrieval, llm-wiki]
---

# Knowledge system and retrieval options

Use this topic when the question is "where should we retain knowledge so humans and agents can find it later?"

| Need | First choice | Escalate when |
| --- | --- | --- |
| Decision, procedure, or project context | Versioned Markdown in this repository | Cross-document questions become demonstrably hard to answer. |
| Recall a source article and why it matters | `knowledge/sources/articles.yml` plus a topic map | The registry becomes too large for direct search. |
| Search approved internal documents semantically | Local RAG experiment | Recall, provenance, and refresh can be measured. |
| Repeated codebase impact analysis | Code graph experiment | File search, LSP, and repository docs are measured bottlenecks. |
| Multi-hop, exhaustive, or type-and-relation questions | Graph/ontology-assisted RAG experiment | The question set shows that vector retrieval alone misses required relationships. |
| Extract structured facts from long text | Grounded extraction experiment | Manual review cost is lower than structured capture. |

RAG and an LLM Wiki are complementary: the latter is the maintained, readable knowledge layer; the former is a possible retrieval layer over approved content.

See [ADR-0001](../decisions/ADR-0001_knowledge_layers.md) and [experiments](../experiments/).
