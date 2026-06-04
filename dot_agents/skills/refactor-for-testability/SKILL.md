---
name: refactor-for-testability
description: Use when refactoring code to improve testability, separate side effects, remove hidden dependencies, or introduce dependency injection.
---

Refactor toward explicit boundaries.

Prefer pure functions for core behavior.

Move side effects to the outer boundary.

Inject dependencies explicitly.

Avoid importing hidden dependencies into core logic.

Hidden dependencies include:

- singletons
- global services
- clocks
- random generators
- filesystem access
- network clients
- environment variables
- database clients
- browser globals
- process globals
- module-level mutable state

Keep dependency records minimal.

Do not create large dependency containers.

Do not introduce classes or inheritance unless explicitly requested.

Do not introduce a dependency injection framework unless explicitly requested.

Preserve behavior first.

Add characterization tests when behavior is not already covered.

Keep each refactor small and reversible.

Prefer this order:

1. Identify the behavior that must stay unchanged.
2. Add or update tests around that behavior.
3. Extract pure logic from side-effecting code.
4. Introduce explicit dependencies only where needed.
5. Keep the public API stable unless changing it is part of the task.
6. Run the smallest meaningful validation command.
7. Summarize what became easier to test.

When a refactor would become too large, stop at a clean boundary and summarize the next step.

Do not mix unrelated cleanup with the testability refactor.
