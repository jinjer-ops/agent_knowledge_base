---
name: repository-publish
description: Prepare a repository change for sharing on GitHub when it may be read outside the current project or machine.
metadata:
  short-description: Review repository changes before sharing
---

# Repository publish

Use this skill before committing, pushing, creating a pull request, or making a repository visible to additional readers. Do not use it for local-only changes with no sharing intent.

## Provenance

source_ids: [REF-003, REF-143, REF-144, REF-146, REF-147]

## Source and boundary

Treat publication as an external mutation. Confirm the target repository, visibility, intended audience, branch, and the user's approval before changing GitHub state. Do not publish merely because a local change is ready.

## Prepare the change

1. Inspect the intended files, working-tree state, tracked files, and `.gitignore`. Preserve unrelated changes.
2. Rewrite for a reader without chat history. Remove personal paths, internal URLs, organization data, credentials, exports, identifiers, and unverified operational claims.
3. Run a targeted scan for secrets, local paths, organization-specific identifiers, and copied external material. Run `git diff --check` and the smallest relevant project verification.
4. Stage only the reviewed paths. Correct material findings and repeat affected checks.

A clean scan means the configured rules did not fire. It is not evidence that no secret is present: measurements of secret-detection tools report no tool reaching both high precision and high recall, so a high-precision scan misses, and a high-recall scan buries the finding in false positives (`REF-146`). Read the diff for the kinds of secret your rules do not describe — self-issued tokens, connection strings, private keys, and chosen passwords — because the platform's own push-time block (`REF-143`) covers provider-shaped credentials and leaves those categories out by default (`REF-144`).

## Handoff

Report the changed paths, verification results, remote and branch, and any intentionally unverified risk.

If a secret was exposed, stop normal publication work and revoke or rotate it through the appropriate owner first. Deleting the file is not remediation: a field study of public repositories found most leaked secrets were never removed and that the repositories which did remove one still left it in history (`REF-147`), and the platform's own guidance is to rotate first and treat rewriting history as a later step that is often unnecessary once the credential is dead (`REF-003`). Rewriting history before revoking leaves a live credential exposed for the length of that work.
