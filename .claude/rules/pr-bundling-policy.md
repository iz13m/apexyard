# PR Bundling Policy — Portfolio Override

**This rule overrides the default "One Ticket at a Time" rule in `workflow-gates.md` and `CLAUDE.md` for the Spotless portfolio.**

Spotless is a single-developer pre-launch product. PR churn is more expensive than ticket-per-PR purity. Bundle related tickets into one PR when they share surface area.

## When to bundle

Bundle two or more tickets into a single PR when they share **any** of:

- The same files or modules
- The same i18n surface (footer, header, legal pages)
- The same data-layer change (schema, types, query helpers)
- The same UI feature flow (legal + contact, terms + privacy, etc.)

Confirmed precedents:

- `#4 + #5` — marketing-site legal + contact pages
- `#51 + #52` — in-app legal + contract surfaces
- `#46 + #47` — typed Firestore writes + pagination on the same hooks

## When NOT to bundle

Split when the scope risk diverges between tickets:

- One ticket is a risky migration, the other is cosmetic
- One ticket touches auth / payments / data deletion, the other doesn't
- One ticket needs a feature flag, the other ships unconditionally

If in doubt, ask the user before splitting — they consistently prefer bundled even when an advisor flags the pairing as "not naturally related".

## Conventions for bundled PRs

- **Branch name**: `feat/GH-N-M-short-desc` (e.g. `feat/GH-4-5-legal-and-contact`). Use as many ticket numbers as bundled.
- **PR title**: `type(#N): description` — the validators require ONE ticket ID. Pick the lowest number; reference the others in the body.
- **PR body**: `Closes #N` line per ticket — auto-closing works for any number of references.
- **Commit messages**: `Closes #N` per ticket in the trailing block.

## Why

Solo-dev project, churn-sensitive, pre-launch. Observed behaviour:

- User has accepted bundled PRs without splitting, even after advisor pushback.
- The "one ticket per PR" rule was designed for multi-engineer teams where PR ownership and review queue management matter — neither applies here.

## Backstop

`validate-branch-name.sh` and `validate-pr-create.sh` are stricter than this rule allows — they enforce one ticket ID per PR title. That's fine: the body carries the rest via `Closes #N` lines. Do not loosen the validators.
