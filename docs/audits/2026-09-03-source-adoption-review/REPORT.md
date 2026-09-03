---
title: Source adoption review audit report
date: 2026-09-03
scope: full
result: one-adoption-gap-closed
---

# Source adoption review audit report

## Result

23 source records, their Japanese reading cards, the registry's reverse index, and the current
foundation, rules, skills, and contribution guide were reviewed. Seven sources already had an
actual local policy or practice. One source, `ART-013`, had a safe general principle missing from
the current foundation; it is now adopted: multi-step automation needs explicit evidence-based
completion, bounded retry, safe stopping, and a human escalation point. The remaining references either require a
specific tool or service context, an owned experiment, or are already present only as an option or
an official source of truth.

This review checks adoption coverage against the source cards verified when they were ingested; it
is not a new factual or freshness review of every external page.

## Per-source decision

| Source | Decision | Evidence and smallest safe action |
| --- | --- | --- |
| ART-001 | Reference remains | Provenance and source URLs are already preserved by `knowledge-curator`; retaining text-position evidence would require a separate extraction workflow and inputs. |
| ART-002 | Reference remains | `foundation/presentations` already lists Reveal.js as an option. No reusable project workflow or output establishes it as the default. |
| ART-003 | Already adopted | `foundation/README.md` and the Claude Code starter separate always-read facts, rules, and skills. |
| ART-004 | Already adopted | The new-project template and review rule require structured procedures and explain safety constraints. |
| ART-005 | Needs experiment | A local RAG runtime requires approved data, hardware, model, ownership, security boundary, and evaluation criteria. |
| ART-006 | Already adopted | Foundation and organization guidance keep shared facts in one source of truth and leave tool-specific procedures local. |
| ART-007 | Reference remains | The repository already curates human and machine knowledge separately. An LLM wiki needs an explicit freshness owner and retrieval evaluation before adoption. |
| ART-008 | Needs experiment | Graph indexing claims depend on codebase size, query mix, token cost, and answer quality; no measured local need exists. |
| ART-009 | Reference remains | A personal Ollama setup note is not a portable model-evaluation or operating procedure. |
| ART-010 | Already adopted | `foundation/presentations/README.md` requires verified reusable visual assets and final rendering checks. |
| ART-011 | Reference remains | It is product news, not a validated runtime choice or portable procedure. |
| ART-012 | Already adopted | Foundation and curation guidance cover knowledge freshness, orphaning, and keeping agent instructions short. |
| ART-013 | Adopted | `foundation/README.md` now requires evidence-based completion, a bound, safe stop, and human handoff for multi-step automation. |
| ART-014 | Reference remains | Application repository-pattern guidance does not fit this configuration and knowledge repository. |
| ART-015 | Already adopted | Foundation guidance keeps always-read instructions short and moves detail to rules, skills, or reference documents. |
| ART-016 | Needs experiment | Ontology and graph retrieval need a defined corpus, query set, coverage metric, answer-quality metric, and security boundary. |
| ART-017 | Already adopted | The review rule now places decisions across deterministic checks, rules, semantic review, and human judgment. |
| ART-018 | Reference remains | Identity separation is sound, but adoption needs a real internal service, identity provider, administrator, and security review. |
| ART-019 | Needs experiment | Graph, semantic-search, and language-server tools need a local comparison against current search, with security and maintenance evaluation. |
| REF-001 | Official reference remains | The Claude Code memory specification is cited by the foundation; it is a source of truth, not a local practice. |
| REF-002 | Official reference remains | The skills specification is cited by the foundation and curation skill; it remains the external format authority. |
| REF-003 | Official reference remains | Public-boundary policy and publish skill use it for the limits of secret scanning. |
| REF-004 | Official reference remains | The review rule cites the ADR format; no active decision record warrants creating an ADR merely to change its status. |

## Closed finding: bounded multi-step automation was implicit, not explicit

The current foundation requires acceptance criteria and verification, and its skills require clear
trigger and completion conditions. It did not state what happens when an agent repeats work, cannot
verify a result, or reaches a limit. `ART-013` supplies a general, non-tool-specific complement,
now added to the foundation: automation should produce evidence, have a retry or iteration bound,
stop safely, and return the remaining decision to a human. This rule does not authorize unattended
execution or deployment.

## Residual risk

`ART-005`, `ART-008`, `ART-016`, and `ART-019` may be valuable later, but adopting them now would
invent a local RAG or code-analysis capability without a bounded problem, owner, data boundary, or
success measure. `ART-018` is security-sensitive and must not become a public generic recipe for
an internal identity system without a concrete architecture review.

No other immediate, safe adoption gap was found in the reviewed scope.
