---
title: Source adoption review audit manifest
date: 2026-09-03
scope: full
---

# Source adoption review audit manifest

## Objective

Review all 23 records in `knowledge/sources/articles.yml` to determine whether a source with
current `reference` status contains a safe, reusable principle that is missing from the existing
foundation, rule, or skill material. Distinguish an immediately adoptable repository-level rule
from a tool-specific proposal that needs an owner, environment, evidence, and exit criteria.

## Acceptance criteria

- Every source is classified as already adopted, safely adoptable now, needs a bounded experiment,
  or reference-only with a factual reason.
- A proposed adoption is not merely a duplicate of existing guidance and does not make a source's
  unverified tool performance, vendor behavior, or organization-specific configuration normative.
- The review identifies the smallest destination for every safely adoptable principle.
- Findings are checked against the source card, registry `derived` index, and current local
  foundation, rules, skills, and contribution guidance.

## Authority and boundaries

This is a read-first review of public-safe repository material. No external configuration,
credential, authentication flow, dependency, tool installation, commit, push, pull request, or
merge is authorized by this audit itself. Existing uncommitted ART-017 review-rule changes are
preserved and evaluated as a candidate adoption, not discarded or overwritten.

## Evidence and lenses

| Lens | Question | Evidence |
| --- | --- | --- |
| Correctness | Does the candidate express an actual source claim and fit the stated local purpose? | Reading card, source record, local destination |
| Safety | Would adoption accidentally authorize an external action, tool, credential, or high-risk decision? | Rule/skill boundaries and source limitations |
| Operability | Is there a trigger, verification, failure behavior, and owner where a workflow is proposed? | Existing skill/rule text and source card |
| Succession | Can a reader distinguish adopted policy from a lead worth testing later? | Registry status, `derived`, reading guide |
| Duplication | Is the idea already covered by a stronger local or official source? | Reverse index and relevant files |

## Output

`REPORT.md` will list every source by ID, decision, evidence, and the smallest safe next action.
It will separately list only the candidates that need a user decision before implementation.
