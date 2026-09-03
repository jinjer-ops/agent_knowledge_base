---
title: Knowledge validation CI audit manifest
date: 2026-09-03
scope: focused
---

# Knowledge validation CI audit manifest

## Target and intended outcome

Target files are `.github/workflows/knowledge-validation.yml`, the ART-013 card in
`knowledge/reading-guide.md`, and this audit record. The workflow must run the existing,
standard-library-only `scripts/validate_knowledge.py` on pull requests targeting `main` and on
pushes to `main`, with read-only repository permission. The ART-013 card must state only claims
confirmed across all three public pages of its registered URL.

## Acceptance criteria

- The workflow checks out the repository, pins a Python runtime, and runs the validator without
  installing packages or receiving write permissions.
- Its triggers cover pull requests into `main` and changes merged into `main`.
- The validator succeeds locally on the base commit and after the proposed card update.
- The ART-013 card remains `reference`, contains no long quotation or unsupported measurement,
  and no longer claims that later pages are unreviewed.

## Boundary and known facts

This is a public repository. The workflow must not deploy, publish, use secrets, write to GitHub,
or run untrusted pull-request code with elevated permissions. No production data is involved.
The validator currently reports 20 sources, 12 declaring documents, and 20 guide cards. GitHub
Actions was not configured when PR #3 merged. ART-013's URL was reviewed on 2026-09-03 across its
three public pages; it is a secondary-source account, not local evidence of adoption.

## Focused lenses and evidence

| Lens | Question | Evidence |
| --- | --- | --- |
| Correctness | Does the workflow run the canonical validator on both change paths? | Workflow file and local validator output |
| Security | Does it avoid secrets, write permission, deployment, and privileged PR events? | Workflow `permissions`, events, and steps |
| Operability | Can a reader identify the failing command and reproduce it locally? | Job name, command, README command |
| Succession | Are scope, rationale, and residual limits recorded? | This manifest and `REPORT.md` |

## Prohibited operations

Do not change source URLs or source status, add dependencies, add a license, enable branch
protection, alter repository settings, push, open a PR, or merge as part of this audit.
