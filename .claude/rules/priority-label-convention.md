# Priority Label Convention

Spotless uses **inline priority tags** in issue titles, GitHub Issues only, no external tracker.

## The format

Every non-trivial issue title starts with a priority tag:

- `[P0]` — launch blocker / production-down / data-loss risk
- `[P1]` — important, blocks a milestone but not launch
- `[P2]` — nice-to-have, polish, low-impact bug

Examples:

- `[P0] Customer app crashes on cold start when AsyncStorage is empty`
- `[P1] Booking-confirmation email missing AR translation`
- `[P2] Marketing-site hero image lazy-load above the fold`

Untagged issues default to `[P2]`. Anything tagged `[P0]` should also have a `priority/P0` GitHub label.

## Ticket reference format

- **`#N` only.** This portfolio is GitHub-Issues-native; do not use `ABC-123` / Linear / Jira formats.
- **Branch names**: `feature/GH-N-description` (matches the bundling rule format).
- **PR titles**: `type(#N): description`.
- **Commit trailers**: `Closes #N`, `Refs #N`, `Fixes #N`.

The apexyard default validators accept both `#N` and `ABC-123` shapes — for Spotless, use `#N` exclusively. Don't introduce a `SPOT-N` or similar prefix; the registry-level `ticket_prefix: GH` in `apexyard.projects.yaml` already encodes this.

## No Linear, no Jira

[[project-spotless-overview]] confirms: Linear is not used. Jira is not used. Issues live in each project's GitHub repo. `apexyard/projects/<name>/` holds the per-project apexyard docs but is **not** a tracker — see [[ticket-vocabulary]] for the rule against pretending plan items are tickets.

## Cross-repo references

When a PR in one repo closes an issue in another repo (e.g. `spotless-operation` PR closes a coordination issue in `apexyard`):

- Use the fully-qualified form in the commit trailer: `Closes iz13m/apexyard#42`
- Keep the PR title bound to the **PR's own repo's issue** (`fix(#15): description` where `#15` is in `spotless-operation`).

Cross-repo `Closes` works on GitHub but does not auto-link in the PR title validator — the title only sees the local-repo number.

## What `apexyard/` itself uses

ApexYard's own GitHub repo has issues **disabled** per [[project-spotless-overview]]. Coordination tickets for the portfolio (cross-repo work, framework-level decisions) live in whichever project repo they originate from. The fork's local `projects/<name>/` docs are notes, not tickets.

## Anti-patterns

- ❌ `[P0]` issues with no real prod-down rationale (`[P0]` inflation kills the signal)
- ❌ Untagged issues silently treated as `[P0]` because they're recent
- ❌ Linear-style `SPOT-42` references
- ❌ Plain `42:` in PR titles without `#` (validator rejects)
