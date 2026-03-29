# Feature Request: FR-003 CI Quality Parity And Coverage Enforcement

**Priority:** HIGH
**Type:** Enhancement
**FR:** FR-003
**Status:** Enforced
**Effort:** 1.5 days
**Requested:** 2026-03-28

## Summary

Add CI parity for critical local quality gates and enforce test coverage threshold in CI.

## Value Statement

Merge boundary enforcement becomes trustworthy even when local hooks are skipped or required tools are missing.

## Problem

Local hooks can skip if tools are not installed, and configured coverage threshold is not currently enforced by CI.

## Proposed Solution

Add or extend CI workflow to run:

- `pytest` with coverage and fail-under threshold
- `radon` complexity gate
- `jscpd` duplicate check
- `vulture` dead-code check
- `scripts/req_coverage.py --strict`

Keep local hooks as fast feedback, but make CI authoritative.

## Judge

**Verdict:** APPROVED

### Scope Freeze

- In scope: Add CI enforcement for coverage threshold, requirement coverage strict mode, complexity, duplication, and dead-code checks.
- In scope: Ensure these checks run as merge-boundary blockers for pull requests.
- In scope: Update docs to clarify local hooks are fast feedback and CI is authoritative.
- Out of scope: Packaging/release automation changes.
- Out of scope: Refactoring local hook scripts.

### Constraints

- Keep implementation readable and reproducible in GitHub Actions.
- Use explicit, deterministic tool installation in CI.
- Preserve current project thresholds unless explicitly changed in configuration.

### Risks

- CI runtime may increase and impact developer cycle time.
- Tool version drift can cause non-deterministic failures.

### Mitigation

- Pin tool versions where practical.
- Start with one consolidated quality job and split later only if runtime requires it.
- Document expected runtime and failure interpretation.

### Acceptance Criteria

- [x] CI blocks merges on coverage below threshold.
- [x] CI runs complexity, duplication, and dead-code gates.
- [x] CI runs strict requirement coverage check.
- [x] Documentation clearly states local hooks are convenience, CI is authoritative.

### Enforcement Evidence

- Added `.github/workflows/quality.yml` with merge-boundary checks for:
	- `scripts/req_coverage.py --strict`
	- pytest coverage fail-under from `scripture.yaml`
	- radon, vulture, and jscpd gates on changed Python files
- Added `_templates/.github/workflows/quality.yml` so `render.sh` preserves the policy.
- Updated `README.md` CI workflow section to document CI authority over local hooks.

### Validation Plan

1. Open a PR that intentionally violates each gate and verify corresponding CI failure.
2. Open a PR that satisfies all gates and verify all required statuses pass.
3. Confirm coverage fail-under is enforced by CI, not just documented in `scripture.yaml`.

## Alternatives Considered

### 1. Keep gates local-only
**Rejected.** Does not protect merge boundary against bypasses.

## Related

- `.github/workflows/`
- `hooks/radon-check.sh`
- `hooks/jscpd-check.sh`
- `hooks/vulture-check.sh`
- `scripts/req_coverage.py`
- `scripture.yaml`
