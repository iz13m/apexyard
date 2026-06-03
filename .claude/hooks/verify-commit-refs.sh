#!/bin/bash
# PreToolUse hook on `git commit -m / -F`: scans the commit message for
# issue references (Closes #N, Refs #N, Fixes #N, Resolves #N, Related to #N)
# and blocks the commit if any reference points at an issue that doesn't
# exist in the tracker repo.
#
# Backstop for the ticket-vocabulary rule (.claude/rules/ticket-vocabulary.md).
# The primary enforcement is self-discipline: never use tracker notation for
# plan items that have no real issue behind them. This hook catches the
# downstream symptom — a fabricated #N that made it into a commit message
# on its way to becoming durable history.
#
# Interactive commits (no -m / -F) are NOT checked. Parsing .git/COMMIT_EDITMSG
# before the editor opens would race with git's own validation, and Claude
# rarely uses the interactive path anyway. Accepted gap.
#
# Tracker repo resolves in this order:
#   1. .claude/project-config.json `.tracker_repo` (from the resolved repo root)
#   2. origin remote of the resolved repo root
#
# Resolving the repo root accounts for cross-repo commits — `cd <path> && git
# commit` from inside Claude Code's session PWD. Without this, the hook would
# check refs against Claude's session repo instead of the commit's actual
# repo. See iz13m/apexyard#5.

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Only check on git commit
if ! echo "$COMMAND" | grep -qE '\bgit\s+commit\b'; then
  exit 0
fi

# Extract the commit message. Try -m "..." / -m '...' first, then -F <file>.
# If neither is present, assume interactive commit — skip.
#
# IMPORTANT: Claude and humans both commonly use multi-line -m arguments via
# HEREDOC substitution like `git commit -m "$(cat <<EOF ... EOF)"`, which means
# the literal -m value spans multiple lines in the command string. `sed -nE`
# processes stdin line-by-line by default, so a regex like `-m "([^"]*)"`
# cannot span lines and silently fails to match.
#
# Fix: flatten the command string with `tr '\n' ' '` before sed processing.
# The message then parses as a single logical line. The ref-pattern grep
# below doesn't care about line breaks either way.
#
# Without this flattening, the hook was INERT for any multi-line commit —
# which is the default shape for Claude-generated commits. Confirmed via
# smoke test before the fix.
COMMAND_FLAT=$(echo "$COMMAND" | tr '\n' ' ')

MSG=""

# -m 'single quoted'
MSG=$(echo "$COMMAND_FLAT" | sed -nE "s/.*-m[[:space:]]+'([^']*)'.*/\1/p" | head -1)

# -m "double quoted"
if [ -z "$MSG" ]; then
  MSG=$(echo "$COMMAND_FLAT" | sed -nE 's/.*-m[[:space:]]+"([^"]*)".*/\1/p' | head -1)
fi

# -F <file> / --file <file>
if [ -z "$MSG" ]; then
  MSG_FILE=$(echo "$COMMAND_FLAT" | sed -nE 's/.*(-F|--file)[[:space:]]+([^[:space:]]+).*/\2/p' | head -1)
  if [ -n "$MSG_FILE" ] && [ -f "$MSG_FILE" ]; then
    MSG=$(cat "$MSG_FILE")
  fi
fi

# No message found → interactive commit or parse failure. Skip.
if [ -z "$MSG" ]; then
  exit 0
fi

# Extract issue references. Patterns matched (case-insensitive):
#   Closes #N / Close #N / Closed #N
#   Fixes #N / Fix #N / Fixed #N
#   Resolves #N / Resolve #N / Resolved #N
#   Refs #N / Ref #N / References #N / Related to #N
# One reference per line is the common pattern; multiples in one line also work.
REFS=$(echo "$MSG" | grep -oEi '\b(close[sd]?|fix(e[sd])?|resolve[sd]?|ref(s|erences)?|related to)[[:space:]]+#[0-9]+' | grep -oE '#[0-9]+' | sort -u)

if [ -z "$REFS" ]; then
  exit 0
fi

# Resolve the effective working directory of the git command. The hook runs
# in Claude Code's session PWD, but the actual `git commit` may execute in a
# different repo via `cd <path> && git commit ...` (the typical Claude/shell
# idiom). Pull the path out of the command's prefix and use it as the anchor
# for the tracker lookup.
#
# We look at the slice BEFORE `git commit` only — any `cd` in the commit body
# (`-m "... cd somewhere ..."`) is content, not a working-directory change.
# `git -C <path> commit` is out of scope here: the gate above (`\bgit\s+commit\b`)
# and the wrapper's `Bash(git commit *)` matcher both filter that shape out
# before this hook runs, so any extraction would be unreachable.
# BSD/macOS sed -E does not support `\b` word boundaries; the pattern below
# uses an explicit "start-of-string or whitespace" group instead. The gate
# above already guarantees the command contains a real `git commit` token,
# so the first match in the prefix is the right one.
EFFECTIVE_CWD=""
PREFIX=$(echo "$COMMAND_FLAT" | sed -nE 's|^((.*[[:space:]])?)git[[:space:]]+commit.*|\1|p')
if [ -n "$PREFIX" ]; then
  # Use the LAST cd in the prefix so `cd a && cd b && git commit` resolves to b.
  EFFECTIVE_CWD=$(echo "$PREFIX" | grep -oE '\bcd[[:space:]]+("[^"]+"|'"'"'[^'"'"']+'"'"'|[^[:space:];&|]+)' | tail -1 | sed -E 's/^cd[[:space:]]+//' | sed -E 's/^["'"'"']|["'"'"']$//g')
fi

# Expand a leading ~ to $HOME — the command string isn't shell-expanded yet.
case "$EFFECTIVE_CWD" in
  "~"*) EFFECTIVE_CWD="$HOME${EFFECTIVE_CWD#~}";;
esac

# Anchor REPO_ROOT to the effective CWD when it's a real directory; otherwise
# fall back to the hook's PWD (preserves prior behavior for same-repo commits
# and for any case where the cd-extraction yielded something we can't trust).
if [ -n "$EFFECTIVE_CWD" ] && [ -d "$EFFECTIVE_CWD" ]; then
  REPO_ROOT=$(cd "$EFFECTIVE_CWD" && git rev-parse --show-toplevel 2>/dev/null)
else
  REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
fi

TRACKER_REPO=""
if [ -f "${REPO_ROOT}/.claude/project-config.json" ]; then
  TRACKER_REPO=$(jq -r '.tracker_repo // empty' "${REPO_ROOT}/.claude/project-config.json" 2>/dev/null)
fi
if [ -z "$TRACKER_REPO" ] && [ -n "$REPO_ROOT" ]; then
  # Anchor the origin lookup to REPO_ROOT too — without -C, git would read the
  # remote of whatever repo PWD points at, defeating the fix above.
  ORIGIN_URL=$(git -C "$REPO_ROOT" remote get-url origin 2>/dev/null)
  TRACKER_REPO=$(echo "$ORIGIN_URL" | sed -nE 's|.*[:/]([^/:]+/[^/]+)\.git$|\1|p; s|.*[:/]([^/:]+/[^/]+)$|\1|p' | head -1)
fi

if [ -z "$TRACKER_REPO" ]; then
  echo "WARN: verify-commit-refs.sh could not resolve tracker repo. Skipping." >&2
  exit 0
fi

# Verify each referenced issue exists. Fabricated #N (issue not found) is
# BLOCKING — that's the failure mode the ticket-vocabulary rule targets.
# References to CLOSED issues are WARNED (not blocked) because a commit may
# legitimately reference the closed issue it just finished (e.g. a revert or
# a follow-up clarification commit after the closing PR already shipped).
# The PR-level hook (validate-pr-create.sh) is the right place to enforce
# "every PR needs its own OPEN ticket".
MISSING=""
CLOSED=""
for REF in $REFS; do
  NUM=$(echo "$REF" | tr -d '#')
  ISSUE_JSON=$(gh issue view "$NUM" --repo "$TRACKER_REPO" --json number,state 2>/dev/null)
  if [ -z "$ISSUE_JSON" ]; then
    MISSING="${MISSING}${REF} "
    continue
  fi
  ISSUE_STATE=$(echo "$ISSUE_JSON" | jq -r '.state // empty' 2>/dev/null)
  if [ "$ISSUE_STATE" = "CLOSED" ]; then
    CLOSED="${CLOSED}${REF} "
  fi
done

if [ -n "$MISSING" ]; then
  cat >&2 <<MSG
BLOCKED: Commit message references issues that do not exist in ${TRACKER_REPO}:
  ${MISSING}

This is the failure mode the ticket-vocabulary rule exists to prevent — do NOT
use tracker notation (Closes #N, Refs #N, etc.) for plan items that have no
real issue behind them. See .claude/rules/ticket-vocabulary.md.

If you intended to reference a real issue, verify the number(s).
If you were about to commit work that has no ticket yet, create one first:
  gh issue create --repo ${TRACKER_REPO} --title "..."
and use the returned number in your commit message.

If the reference is truly informational (cross-repo link that can't be verified
with \`gh issue view\`), write it as a plain URL instead of #N notation.
MSG
  exit 2
fi

if [ -n "$CLOSED" ]; then
  cat >&2 <<MSG
WARN: Commit message references CLOSED issue(s) in ${TRACKER_REPO}:
  ${CLOSED}
This commit is allowed through — a commit may legitimately reference the
issue it just closed. But at PR-create time the stricter rule applies: every
PR needs its own OPEN ticket. If this commit will end up in a PR that points
at the closed issue as its primary ticket, create a new open ticket first.
MSG
fi

exit 0
