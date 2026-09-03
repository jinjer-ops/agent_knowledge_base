---
title: Knowledge validation CI audit report
date: 2026-09-03
scope: focused
result: accepted-with-residual-risk
---

# Knowledge validation CI audit report

## Result

The proposed workflow is accepted for a narrow purpose: it runs the repository's existing
knowledge validator on pull requests into `main` and on updates to `main`. It does not publish,
deploy, install project dependencies, use secrets, or receive write permission.

## Evidence by lens

### Correctness

`.github/workflows/knowledge-validation.yml` invokes exactly
`python scripts/validate_knowledge.py`. Its `pull_request` and `push` branch filters both target
`main`. The command succeeded locally on 2026-09-03 with `20 sources, 12 declaring documents,
20 guide cards`.

The ART-013 card was checked against all three public pages of its registered URL on 2026-09-03.
The card now describes the article's staged automation approach and its caution about verification,
without changing its `reference` status or treating the article's reported figures as local proof.

### Security

The workflow declares `permissions: contents: read`, uses `pull_request` rather than
`pull_request_target`, has no secrets, no write-capable GitHub API call, no deployment step, and
no dependency installation. It uses the GitHub-maintained checkout and Python setup actions, then
runs only the repository's standard-library script.

### Operability and succession

The job has a five-minute limit and a descriptive name. The same validator command is documented
in the root README and `docs/HANDOVER.md`, so a failing result can be reproduced locally. The
handover links this audit and states that branch protection is separate from the workflow.

## Residual risk and follow-up

The workflow reports failures but does not itself prevent merging; requiring it is a repository
administrator decision and was out of scope. The GitHub-maintained actions are referenced by
major version tags, so their future updates are not frozen to an immutable commit. Review those
action references when changing the workflow or adopting an action-pinning policy.

No blocking finding was identified in this focused scope. This conclusion does not audit GitHub
organization settings, branch protection, runner availability, or the factual accuracy of sources
other than ART-013's reviewed pages.
