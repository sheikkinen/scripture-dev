# Feature Request: FR-002 Branch-Agnostic CI Diff Gates

**Priority:** HIGH
**Type:** Bug
**FR:** FR-002
**Status:** Enforced
**Effort:** 0.5 days
**Requested:** 2026-03-28

## Summary

Make changelog and diary CI gates branch-agnostic by using pull request base/head SHAs instead of `origin/main...HEAD`.

## Value Statement

Teams using non-`main` default branches get reliable CI behavior without false failures.

## Problem

Current CI gate scripts hardcode `origin/main...HEAD` diff checks. This fails or behaves incorrectly when default branch names differ.

## Proposed Solution

In CI, inject `BASE_SHA` and `HEAD_SHA` from pull request metadata and diff using:

```bash
git diff --name-only "$BASE_SHA" "$HEAD_SHA"
```

Apply this to changelog and diary gates.

## Judge

**Verdict:** APPROVED

### Scope Freeze

- In scope: Replace `origin/main...HEAD` diff logic in changelog and diary gates with PR base/head SHA diffing.
- In scope: Use pull_request-provided `BASE_SHA` and `HEAD_SHA` environment variables in workflow steps.
- Out of scope: Any additional CI gates unrelated to diff source selection.
- Out of scope: Non-PR workflows.

### Constraints

- Keep workflow structure and gate semantics unchanged.
- Minimum-diff patch in `.github/workflows/commitlint.yml` only.
- No behavior changes to FR matching or diary filename policy.

### Risks

- Incorrect SHA wiring can cause false negatives if variables are missing in non-PR contexts.

### Mitigation

- Restrict changes to existing PR-only jobs and validate syntax with a local YAML parse check.

### Acceptance Criteria

- [x] No `origin/main...HEAD` dependency remains in gate steps.
- [x] Changelog gate works on repos with `main`, `master`, or custom default branch names.
- [x] Diary gate works on repos with custom default branch names.

### Enforcement Evidence

- Updated root workflow in `.github/workflows/commitlint.yml` to use PR-provided `BASE_SHA` and `HEAD_SHA` in changelog and diary gates.
- Updated template workflow in `_templates/.github/workflows/commitlint.yml` to preserve behavior on re-render.
- Removed dependency on `origin/main...HEAD` in both gate paths.

### Validation Plan

1. Confirm `.github/workflows/commitlint.yml` no longer contains `origin/main...HEAD`.
2. Confirm both changelog and diary gates use:
	- `BASE_SHA: ${{ github.event.pull_request.base.sha }}`
	- `HEAD_SHA: ${{ github.event.pull_request.head.sha }}`
3. Run a workflow syntax sanity check (YAML parse) locally.

## Alternatives Considered

### 1. Use `origin/$(git symbolic-ref refs/remotes/origin/HEAD)` in CI
**Rejected.** Less explicit and more brittle than PR-provided SHAs.

## Related

- `.github/workflows/commitlint.yml`
