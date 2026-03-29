# LinkedIn Article: scripture-dev

## 980 Commits, 208 Feature Requests, Zero Manual Changelog Edits: How I Built a Governance Framework for AI-Assisted Development

Over the past year I shipped a YAML-first LLM pipeline framework called **YAMLGraph** — 980+ commits, 130+ feature requests, 300+ retrospective diary entries, 2,900+ tests with requirement traceability.

Every line of Python was written by AI. Not a single one by me.

What I wrote was the *process*: the constraints, the gates, the feedback loops that made AI-generated code reliable at scale. I extracted that process into a reusable template: **scripture-dev**.

GitHub: https://github.com/sheikkinen/scripture-dev/
Origin: https://github.com/sheikkinen/yamlgraph

## TL;DR

- **Origin**: extracted from YAMLGraph (980+ commits, 2,900+ tests) into a reusable governance template.
- **Ideology**: Plan → Judge → Enforce — a structured loop where AI agents fill explicit roles.
- **Contents**: doctrine, templates, hooks, CI gates, changelog fragments, requirement traceability, reviewer checklist.
- **Operating rule**: local hooks are fast feedback; CI is merge-boundary authority. Bypassing local hooks with `--no-verify` does not bypass required CI gates.
- **Why it matters**: AI code quality improves when feedback loops are concrete and enforceable, not aspirational.

## Background: Why scripture-dev exists

In AI-native workflows, the same failures repeat:

- Process is discussed, not enforced.
- Local habits diverge from merge-gate reality.
- Requirements, tests, and changelogs drift out of sync.
- "We will document it later" becomes permanent ambiguity.

scripture-dev turns process intent into concrete, reviewable, automatable rules.

## The Commandments

The framework is anchored in 10 engineering commandments. A few that carry the most weight:

- **Be faithful to TDD** — Red-Green-Refactor. No bug shall be fixed unless first condemned by a failing test. Commit the RED and the GREEN separately; git log is the proof trail.
- **Bear witness of thy errors** — Hide nothing. Expose every fault to linters and to CI. A plausible wrong answer is harder to catch than a crash.
- **Kill all entropy** — Split modules before they bloat. No file over 450 lines. Cyclomatic complexity capped at 21. Duplication detected and blocked. Dead code burned.
- **Sanctify outputs with types** — All data passes through validation. No untyped dicts wander the codebase.

Each commandment has a corresponding enforcement mechanism: a hook, a CI gate, or both.

## Process Ideology: Plan → Judge → Enforce → Distill

The operating model is intentionally simple:

1. **Plan** — Write explicit feature requests with acceptance criteria and alternatives.
2. **Judge** — Challenge scope, remove ambiguity, freeze constraints, define validation.
3. **Enforce** — Implement minimum-diff changes, prove behavior, block regressions with hooks and CI.
4. **Distill** — Write a retrospective diary entry. Name the cognitive trap. Extract a heuristic. Plant a seed question.

In YAMLGraph, each phase is handled by a role-specialized AI agent: a **Chaplain** watches for new feature requests, a **Planner** drafts proposals, a **Judge** challenges scope and grants authority, and an **Enforcer** implements the approved plan in an isolated git worktree. The human steers; the agents execute under governance.

Core principle: **local hooks are fast feedback; CI is authoritative**.

## The Knowledge Graph: Learning from Mistakes at Scale

The most distinctive part of the methodology is what happens *after* implementation.

Every completed feature produces a diary entry. Recurring patterns — cognitive traps, effective cures, process insights — get graduated into a Knowledge Graph embedded in the doctrine itself.

Examples from 300+ diary entries:

- **quick_confidence**: "When I feel certain → Judge instead." Overconfidence is the most common trap.
- **downstream_fix**: "Guard added where symptom manifests → normalize at entry boundary instead." Fix the cause, not the crash site.
- **spec_kill**: "The cheapest bug is the one killed in the spec." Requirements reviewed before code is written.

This creates a self-improving loop: practice → reflection → heuristic → enforceable rule → stronger practice.

## Two-Tier Enforcement

Here is what "enforcement" looks like concretely:

A developer (AI) commits a `feat:` change without a changelog fragment. The local `commit-msg` hook blocks the commit immediately with a clear message. If the developer bypasses with `--no-verify`, the CI changelog-gate blocks the PR at merge. The feature cannot ship without the fragment.

**Bypassing local hooks with `--no-verify` does not bypass required CI gates. PRs cannot merge until required CI checks pass.**

scripture-dev ships these enforcement layers as working assets:

- **Pre-commit hooks**: file size, complexity, duplication, dead code, forbidden terms, diary stubs
- **Commit-msg hooks**: changelog fragment required for feat/fix, FR reference required for feat
- **CI gates**: all of the above plus coverage threshold, requirement traceability, dependency vulnerability scans

## How to adopt scripture-dev

Clone the template. Set your project name and thresholds in one YAML file (`scripture.yaml`). Run the renderer. Install hooks. Your first commit is already governed.

Then iterate: tighten gates as maturity grows; keep policy aligned with actual enforcement; treat process gaps as feature requests, not tribal knowledge.

## Recap

scripture-dev packages a specific process ideology into reusable project mechanics.
It turns quality from aspiration into control flow: constraint → execution → signal → correction → stronger constraint.

Every line of Python in YAMLGraph was written by AI under this governance framework. The framework itself is the thing I authored.

## Postscript: The Article That Failed Its Own Process

The first draft of this article claimed "208 feature requests" and "150+ tests." Neither number was verified. The real counts: 134 FR files (numbered up to 208 with gaps) and 2,988 pytest-collected tests — one inflated, the other understated by 20x.

The irony: an article *about* enforceable process discipline contained invented numbers because the article itself sat outside every enforcement gate. No hook checks prose for factual accuracy. The doctrine governed code but not the marketing of the doctrine.

The fix took five seconds: `ls feature-requests/FR-*.md | wc -l` and `pytest --collect-only`. The failure was not capability — it was that verification was optional.

Heuristic earned: *Every number in a published claim must have a reproducible command that generates it.* Assertions in prose are the untyped dicts of documentation — they wander unchecked until someone traces them.

What process failures keep recurring in your AI-assisted workflows?
