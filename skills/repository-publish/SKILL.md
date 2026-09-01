---
name: repository-publish
description: Prepare a repository change for sharing on GitHub when it may be read outside the current project or machine.
metadata:
  short-description: Review repository changes before sharing
---

# Repository publish

Use this skill before committing, pushing, creating a pull request, or making a repository visible to additional readers. Do not use it for local-only changes with no sharing intent.

## Source and boundary

Reference IDs: `REF-003`.

Treat publication as an external mutation. Confirm the target repository, visibility, intended audience, branch, and the user's approval before changing GitHub state. Do not publish merely because a local change is ready.

## Prepare the change

1. Inspect the intended files, working-tree state, tracked files, and `.gitignore`. Preserve unrelated changes.
2. Rewrite for a reader without chat history. Remove personal paths, internal URLs, organization data, credentials, exports, identifiers, and unverified operational claims.
3. Run a targeted scan for secrets, local paths, organization-specific identifiers, and copied external material. Run `git diff --check` and the smallest relevant project verification.
4. Stage only the reviewed paths. Correct material findings and repeat affected checks.

## Handoff

Report the changed paths, verification results, remote and branch, and any intentionally unverified risk. If a secret was exposed, stop normal publication work and rotate or revoke it through the appropriate owner; deleting the file is not sufficient.
