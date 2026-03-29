# Feature Request: FR-004 No-Verify Policy And Enforcement Alignment

**Priority:** MEDIUM
**Type:** Enhancement
**FR:** FR-004
**Status:** Enforced
**Effort:** 0.5 days
**Requested:** 2026-03-28

## Summary

Align doctrine wording with actual enforcement capability for `--no-verify` behavior.

## Value Statement

Removes ambiguity and prevents a false sense of protection.

## Problem

Policy text states `--no-verify` is automatically terminated by CI, but not all local gates are mirrored in CI today.

## Proposed Solution

Choose one path:

1. Implement full CI parity for all required local gates and keep strong wording.
2. Soften wording to reflect current guarantees until full parity is implemented.

Recommendation: execute FR-003 first, then keep strong wording.

## Judge

**Verdict:** APPROVED WITH SEQUENCING

### Scope Freeze

- In scope: Align policy wording with actual enforceability for `--no-verify` behavior.
- In scope: Define explicit dependency on FR-003 completion before adopting strongest wording.
- In scope: Update documentation in doctrine and README-level enforcement explanation.
- Out of scope: New technical gates beyond FR-003.

### Constraints

- No claim of enforcement without an active CI blocking mechanism.
- Documentation changes must be consistent across all user-facing governance docs.
- Use precise language distinguishing local checks and merge-boundary checks.

### Risks

- Premature strong wording can reintroduce policy drift.

### Mitigation

- Land FR-003 first, then update wording to strongest form.
- If FR-003 is delayed, use explicitly conditional wording.

### Acceptance Criteria

- [x] Policy statement matches actual CI enforcement.
- [x] Documentation specifies which gates are local feedback vs merge blockers.
- [x] Reviewer checklist includes enforcement parity verification.

### Enforcement Evidence

- Updated no-verify wording in `.github/copilot-instructions.md` to reflect CI merge-boundary enforcement model.
- Updated `_templates/.github/copilot-instructions.md` to preserve wording on re-render.
- Updated `README.md` CI section to explicitly state CI is authoritative and local hooks are fast feedback.
- Added `docs/reviewer-checklist.md` with explicit enforcement parity review item.

### Validation Plan

1. Verify docs do not claim automatic CI termination unless corresponding CI checks exist.
2. Verify README and doctrine text agree on enforcement model.
3. Verify reviewer checklist includes parity check as an explicit review item.

## Alternatives Considered

### 1. Keep current wording unchanged
**Rejected.** Maintains policy drift.

## Related

- `.github/copilot-instructions.md`
- `README.md`
- `.github/workflows/`
