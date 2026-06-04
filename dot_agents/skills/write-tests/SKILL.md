---
name: write-tests
description: Use when writing, updating, or reviewing automated tests. Use for unit tests, behavior changes, regression tests, and testability refactors.
---

Write tests before or alongside behavior changes.

Prefer fast, deterministic tests.

Test behavior, not implementation details.

Avoid module mocking when dependency injection can express the seam.

Isolate side effects behind explicit dependencies.

Side effects include:

- time
- filesystem access
- network access
- randomness
- environment variables
- database access
- browser globals
- process globals
- singleton services

When tests are hard to write, stop and propose the smallest refactor that makes the behavior testable.

Prefer small pure functions for core behavior.

Prefer dependency injection over intercepting imports.

Do not introduce broad mocking frameworks unless the repository already requires them.

Follow the repository's existing test runner and assertion style.

If there is no established test style and this is a TypeScript or Node.js project, prefer:

- `node:test`
- `node:assert`
- `test()` only
- explicit assertions
- no `describe`
- no `it`

For non-trivial assertions:

- assign the actual value to an `actual...` variable
- assign the expected value to an `expected...` variable
- assert those values explicitly

Simple primitive assertions may stay inline when they are already clear.

For regression tests:

- reproduce the bug first
- make the failing behavior visible
- implement the smallest fix
- keep the regression test focused

After changing tests, run the relevant test command when possible.

If the full test suite is expensive, run the smallest meaningful test command and explain what was validated.
