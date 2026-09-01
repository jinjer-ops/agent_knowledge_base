---
id: EXPERIMENT-CODEBASE-GRAPH
title: Codebase knowledge graph evaluation
type: experiment
status: proposed
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-008, ART-016]
tags: [codebase, graph, retrieval]
---

# Codebase knowledge graph

## Hypothesis

A code graph improves impact analysis for a large repository beyond targeted search, language tooling, and maintained architecture documents.

## Gate

Start only after recording repeated search failures or excess investigation time on a specific repository. Define the graph refresh trigger before ingesting code.

## Compare

Use the same impact-analysis questions against the current workflow and graph-assisted workflow. Include multi-hop dependency, exhaustive impact, and type-and-relation questions only when they represent real work. Measure answer completeness, incorrect links, staleness, build time, and operator burden.
