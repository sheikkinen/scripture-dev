# Reflection: Invented Numbers in the LinkedIn Article

**Date:** 2026-03-29
**FR:** N/A (linkedin-article-scripture-dev.md)
**Trap:** plausible_wrong_answer, audit_as_ritual

## Context

While drafting a LinkedIn article about scripture-dev, the article claimed "208 feature requests" and "150+ tests" for YAMLGraph. Neither number was verified against the actual repository. The real counts: 134 FR files (numbered up to FR-208 with gaps), and 2,988 pytest-collected tests. One number was inflated by confusing the highest FR sequence number with the file count. The other was understated by 20x — likely a stale figure from early development that was never rechecked.

The irony: an article *about* enforceable process discipline contained unverified claims because the article itself sat outside any enforcement gate. No hook checks prose for factual accuracy. No CI gate validates numbers in a markdown file. The doctrine governed code but not the marketing of the doctrine.

## Insight

The trap has two layers:

1. **plausible_wrong_answer** — "208 feature requests" passes a shape check (it's a number, it's in range, it sounds impressive) but is semantically wrong. "150+ tests" is even more dangerous — it's a real number from a past state that became false through growth. Both would have survived a casual review.

2. **Process scope blindness** — The Scripture enforces code, tests, changelogs, and diary entries. But the article is a *claim about the process*, not a product of the process. Nothing in Plan → Judge → Enforce covers "verify factual assertions in documentation that references external repositories." The gap is not in the gates — it is in the scope of what gets governed.

The fix was trivial: run `git rev-list --count HEAD`, `ls feature-requests/FR-*.md | wc -l`, and `pytest --collect-only` against the actual repo. Five seconds of verification. The failure was not capability — it was that verification was optional.

## Heuristic

*Every number in a published claim must have a reproducible command that generates it.* If you cannot `grep` or `wc` the number from the source, it is an assertion, not a fact. Assertions in prose are the untyped dicts of documentation — they wander unchecked until someone traces them.

## Seed

Should scripture-dev include a `claim-verification` pattern — a convention for linking published numbers to the shell commands that produce them? A `<!-- verified: git rev-list --count HEAD => 984 -->` HTML comment next to each stat would make future audits mechanical rather than manual.
