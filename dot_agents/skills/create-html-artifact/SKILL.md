---
name: create-html-artifact
description: Use when creating a human-facing report, implementation plan, architecture comparison, codebase review, PR review, migration analysis, testability audit, performance investigation, or stakeholder summary where visual structure, diagrams, tables, or collapsible sections make the result easier to review. Do not use for canonical repository documentation, small answers, README files, AGENTS.md, SKILL.md, or files intended for clean git diffs.
---

Create a self-contained HTML file when the task benefits from visual structure.

Prefer HTML for:

- large implementation plans
- architecture comparisons
- codebase reviews
- PR review summaries
- migration reports
- testability audits
- performance investigations
- dependency analyses
- stakeholder-facing summaries

Do not use HTML for canonical source-of-truth documentation unless explicitly requested.

Do not use HTML for files that should be reviewed line-by-line in git.

Use plain HTML, CSS, and minimal JavaScript.

Keep the file self-contained.

Do not depend on remote assets.

Do not use external fonts.

Do not use external CSS frameworks.

Do not use external JavaScript libraries.

Use:

- a clear title
- an executive summary
- a table of contents
- sections with anchors
- tables for comparisons
- cards for grouped findings
- collapsible details for long findings
- code snippets where useful
- diagrams using inline SVG when helpful
- clear severity or priority labels when useful

For engineering reports, include:

- findings
- impact
- evidence
- recommendation
- suggested order of implementation
- validation steps
- open questions
- risks and trade-offs

For implementation plans, include:

- goal
- non-goals
- assumptions
- proposed approach
- step-by-step plan
- validation strategy
- rollback or recovery notes
- suggested atomic change sequence

When useful, add a small copy button for important snippets.

When useful, add a "copy as Markdown" or "copy as prompt" section.

Prefer readability over visual decoration.

The result should be useful when opened directly in a browser.
