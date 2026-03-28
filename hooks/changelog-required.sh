#!/usr/bin/env bash
# hooks/changelog-required.sh — Require changelog fragment for feat/fix commits
set -euo pipefail

# This hook runs at commit-msg stage; for pre-commit stage, skip
# since we cannot know the commit message type yet.
if [ -z "${1:-}" ]; then
    exit 0
fi

# Read commit message type
MSG_FILE="$1"
MSG_TYPE=""
if head -1 "$MSG_FILE" | grep -qE '^feat'; then
    MSG_TYPE="feat"
elif head -1 "$MSG_FILE" | grep -qE '^fix'; then
    MSG_TYPE="fix"
fi

STAGED=$(git diff --cached --name-only 2>/dev/null || true)

if [ "$MSG_TYPE" = "feat" ] || [ "$MSG_TYPE" = "fix" ]; then
    if ! echo "$STAGED" | grep -q '^changelog/unreleased/'; then
        echo "FAIL: feat/fix commits must include a changelog fragment in changelog/unreleased/"
        exit 1
    fi
fi
