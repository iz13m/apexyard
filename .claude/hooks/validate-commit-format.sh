#!/bin/bash
# PreToolUse hook on `git commit`: validates the commit message subject line
# against the conventional commit format defined in
# .claude/rules/git-conventions.md:
#
#   type: subject
#
# Where type is one of: feat, fix, refactor, test, docs, chore, style, perf
#
# Note: the PR *title* format is `type(TICKET): description` (with scope in
# parens) — that's enforced by validate-pr-create.sh. Commit messages use
# the simpler `type: subject` form without the scope because commits often
# don't correspond 1:1 to tickets.
#
# Multi-line -m messages are handled by flattening newlines before parsing
# (same pattern as verify-commit-refs.sh). Interactive commits (no -m / -F)
# are skipped.
#
# ApexYard also accepts the scoped form `type(scope): subject` as a valid
# superset — if a project wants to use scopes in commits, that's fine, but
# the scope is not required.

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

if ! echo "$COMMAND" | grep -qE '\bgit\s+commit\b'; then
  exit 0
fi

# Extract commit message (multi-line safe).
#
# `-m "$(cat <<'EOF' subject ... body ... EOF )"` is a common Claude idiom for
# multi-line messages. The flatten-then-regex path below treats the heredoc's
# outer `"..."` as one literal string and ends up with the substitution syntax
# (`$(cat <<'EOF' subject ... EOF )`) as the subject — which never matches
# any conventional-commit type. Detect this shape first and pull the heredoc
# body directly from the un-flattened COMMAND. See iz13m/apexyard#7.
MSG=""
HEREDOC_TERM=$(echo "$COMMAND" | grep -oE '<<-?["'"'"']?[A-Za-z_][A-Za-z0-9_]*' | head -1 | sed -E "s/^<<-?[\"']?//")
if [ -n "$HEREDOC_TERM" ] && echo "$COMMAND" | grep -qE '\-m[[:space:]]+"\$\(cat[[:space:]]+<<'; then
  # Walk the original (newline-preserving) COMMAND. Lines strictly between
  # the `<<TERM` opener and the closing `TERM` line are the heredoc body.
  # Awk handles the multi-line awareness; sed multi-line is a footgun here.
  MSG=$(echo "$COMMAND" | awk -v t="$HEREDOC_TERM" '
    BEGIN { capturing = 0 }
    {
      stripped = $0
      sub(/^[[:space:]]+/, "", stripped)
      if (capturing) {
        # Close on a line that is exactly TERM, or starts with TERM followed
        # by `)` (handles `EOF)` and `EOF)"` on the same line).
        if (stripped == t || stripped ~ ("^" t "[[:space:]]*\\)")) {
          capturing = 0
        } else {
          print $0
        }
      } else if (match($0, "<<-?[\"\047]?" t)) {
        capturing = 1
      }
    }
  ')
fi

COMMAND_FLAT=$(echo "$COMMAND" | tr '\n' ' ')

if [ -z "$MSG" ]; then
  MSG=$(echo "$COMMAND_FLAT" | sed -nE "s/.*-m[[:space:]]+'([^']*)'.*/\1/p" | head -1)
fi
if [ -z "$MSG" ]; then
  MSG=$(echo "$COMMAND_FLAT" | sed -nE 's/.*-m[[:space:]]+"([^"]*)".*/\1/p' | head -1)
fi
if [ -z "$MSG" ]; then
  MSG_FILE=$(echo "$COMMAND_FLAT" | sed -nE 's/.*(-F|--file)[[:space:]]+([^[:space:]]+).*/\2/p' | head -1)
  if [ -n "$MSG_FILE" ] && [ -f "$MSG_FILE" ]; then
    MSG=$(cat "$MSG_FILE")
  fi
fi

if [ -z "$MSG" ]; then
  # Interactive commit — skip (accepted gap, matches sibling hooks)
  exit 0
fi

# Get the first line of the message (the subject)
SUBJECT=$(echo "$MSG" | head -1)

if [ -z "$SUBJECT" ]; then
  exit 0
fi

# Validate:
#   type: subject              (no scope)
#   type(scope): subject       (with scope)
#   type!: subject             (breaking change, Conventional Commits 1.0)
#   type(scope)!: subject      (breaking change with scope)
#
# Default types per .claude/rules/git-conventions.md:
#   feat, fix, refactor, test, docs, chore, style, perf, build, ci, revert
#
# Projects can override the type list via .claude/project-config.json:
#   { "commit_types": ["wip", "feat", "fix"] }
# When set, ONLY those types are accepted. The default list is NOT merged —
# the override replaces it entirely. This lets teams with strict conventions
# whitelist exactly the types they use.
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
DEFAULT_TYPES="feat|fix|refactor|test|docs|chore|style|perf|build|ci|revert"
TYPES="$DEFAULT_TYPES"
if [ -n "$REPO_ROOT" ] && [ -f "${REPO_ROOT}/.claude/project-config.json" ]; then
  CUSTOM=$(jq -r '.commit_types // [] | join("|")' "${REPO_ROOT}/.claude/project-config.json" 2>/dev/null)
  if [ -n "$CUSTOM" ] && [ "$CUSTOM" != "null" ] && [ "$CUSTOM" != "" ]; then
    TYPES="$CUSTOM"
  fi
fi
TYPE_REGEX="^(${TYPES})(\([^)]+\))?!?:[[:space:]]+.+"

if ! echo "$SUBJECT" | grep -qE "$TYPE_REGEX"; then
  cat >&2 <<MSG_END
BLOCKED: Commit subject doesn't match the conventional commit format.

Subject was:
  ${SUBJECT}

Expected format (from .claude/rules/git-conventions.md):
  type: subject
  type(scope): subject
  type!: subject             (breaking change)
  type(scope)!: subject      (breaking change with scope)

Where type is one of:
  feat, fix, refactor, test, docs, chore, style, perf, build, ci, revert

Examples:
  feat: add user avatar upload
  fix(auth): handle expired refresh tokens
  feat!: remove deprecated v1 endpoints
  feat(api)!: change response format to JSON:API
  refactor: split order service into read/write sides
  docs(#42): update deployment runbook

The scope in parens is optional for commits (but REQUIRED for PR titles
with a ticket reference — that's enforced by validate-pr-create.sh).

To unblock:
  1. Amend the commit: git commit --amend -m "type: your subject"
  2. Or write a new commit with a conforming subject

If you think this rule is too strict for your project, customize the type
list in .claude/hooks/validate-commit-format.sh or file a ticket to add
\`.commit_types\` as a project-config option.
MSG_END
  exit 2
fi

exit 0
