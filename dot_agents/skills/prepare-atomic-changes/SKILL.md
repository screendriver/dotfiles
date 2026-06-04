---
name: prepare-atomic-changes
description: Use when a task spans multiple logical changes and the user wants the working tree prepared for review or later commits.
---

Structure changes as if they could be committed independently.

Do not run `git commit`.

Do not modify history or refs.

Do not create, delete, rename, or switch branches unless explicitly requested.

Separate:

- behavior changes
- refactors
- test changes
- documentation changes
- formatting-only changes
- dependency changes
- generated files
- configuration changes

Avoid mixing unrelated concerns.

Prefer small, reviewable changes.

Keep each logical change understandable on its own.

After the work, summarize the suggested commit sequence.

For each suggested commit, provide:

- suggested commit message
- files changed
- reason
- validation command
- whether the change is behavior, refactor, test, documentation, formatting, dependency, or configuration

Use clear imperative commit subjects.

Avoid Conventional Commit prefixes unless explicitly requested.

Prefer commit subjects like:

- Add validation for empty project names
- Extract message parser dependencies
- Cover expired session retry behavior
- Remove unused WebSocket reconnect branch

Avoid vague subjects like:

- fix stuff
- update code
- refactor
- changes
- wip
- bump deps

Before finishing, show the current git status.

Do not stage files unless explicitly requested.
