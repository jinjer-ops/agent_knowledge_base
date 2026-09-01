---
id: EXPERIMENT-OPEN-WEIGHT-RUNTIME
title: Open-weight model runtime evaluation
type: experiment
status: proposed
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-005, ART-009]
tags: [ollama, open-weight-models, embeddings]
---

# Open-weight runtime evaluation

## Hypothesis

A local runtime such as Ollama provides a stable evaluation boundary for multiple generation and embedding models, including a later local-RAG experiment.

## Scope

Evaluate model execution, embeddings, API compatibility, hardware fit, license, and data-flow behavior. Do not assume a model is suitable because it can be downloaded.

## Evidence required

- Exact model and revision, license, provider, and quantization
- Hardware and runtime version
- Representative quality tasks and latency measurements
- Input/output data path and retention assessment
- Reproducible setup and removal steps

## Exit rule

Do not use for internal content until legal, security, and evaluation evidence are accepted.
