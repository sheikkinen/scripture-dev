# Feature Request: FR-001 Fix Changelog Hook Stage Wiring

**Priority:** HIGH
**Type:** Bug
**FR:** FR-001
**Status:** Enforced
**Effort:** 0.5 days
**Requested:** 2026-03-28

## Summary

Restore local changelog enforcement by wiring the `changelog-required` pre-commit hook to the correct `commit-msg` stage.

## Value Statement

Developers get immediate local feedback on missing changelog fragments for `feat` and `fix` commits, reducing CI churn and policy drift.

## Problem

The hook script expects a commit message file argument, but the hook is currently registered under `pre-commit`, where no commit message file is provided. The script exits early and the rule is effectively disabled locally.

## Proposed Solution

Update hook registration to run at `commit-msg` stage. Keep script behavior unchanged.

## Judge

**Verdict:** APPROVED

### Scope Freeze

- In scope: Change only hook stage wiring for `changelog-required` from `pre-commit` to `commit-msg`.
- In scope: Verify behavior with one failing and one passing commit-message scenario.
- Out of scope: Any CI workflow changes.
- Out of scope: Rewriting `hooks/changelog-required.sh` logic.
- Out of scope: Changes to unrelated hooks.

### Constraints

- Minimum-diff fix only.
- Preserve existing commit policy semantics for `feat` and `fix`.
- No new dependencies.

### Risks

- If `commit-msg` hook is not installed locally, enforcement still will not run.

### Mitigation

- Ensure setup docs explicitly include `pre-commit install --hook-type commit-msg`.

### Acceptance Criteria

- [x] `changelog-required` runs in `commit-msg` stage.
- [x] A `feat` or `fix` commit without changelog fragment is blocked locally.
- [x] A `feat` or `fix` commit with fragment in `changelog/unreleased/` passes.

### Enforcement Evidence

- Hook wiring changed in `.pre-commit-config.yaml` from `stages: [pre-commit]` to `stages: [commit-msg]`.
- Negative validation executed with `feat` commit message and no staged changelog fragment: exit code `1` with message `FAIL: feat/fix commits must include a changelog fragment in changelog/unreleased/`.
- Positive validation executed with staged file under `changelog/unreleased/`: exit code `0`.

### Validation Plan

1. Install hooks:
	- `pre-commit install`
	- `pre-commit install --hook-type commit-msg`
2. Negative test:
	- Create a `feat:` commit without staged file under `changelog/unreleased/`.
	- Expect commit to fail with changelog-required error.
3. Positive test:
	- Stage a valid file under `changelog/unreleased/`.
	- Retry same `feat:` commit.
	- Expect commit to pass changelog-required gate.

## Alternatives Considered

### 1. Parse commit type in pre-commit from staged files only
**Rejected.** Commit type cannot be reliably inferred before commit message exists.

## Related

- `.pre-commit-config.yaml`
- `hooks/changelog-required.sh`
