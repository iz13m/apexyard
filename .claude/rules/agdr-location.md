# AgDR Location & Frontmatter Overlay

AgDRs (Agent Decision Records) for the Spotless portfolio live **in the project repo that owns the decision**, never in the apexyard ops repo.

## The rule

| Decision scope | AgDR location |
|----------------|---------------|
| Customer-app architecture, RN/Expo choices, in-app data flow | `spotless/docs/agdr/AgDR-NNNN-{slug}.md` |
| Ops backend, API routes, Vercel infra, admin SDK | `spotless-operation/docs/agdr/AgDR-NNNN-{slug}.md` |
| Marketing site, Astro structure, SEO, i18n surface | `spotless-web/docs/agdr/AgDR-NNNN-{slug}.md` |
| ApexYard framework changes (rules, hooks, skills) | `apexyard/docs/agdr/AgDR-NNNN-{slug}.md` (rare — most things go in project repos) |

**Each project has its own ID sequence.** `spotless` is at AgDR-0013+, `spotless-operation` is at AgDR-0015+. Numbering does NOT cross repos.

## Frontmatter overlay (Spotless-specific)

The bare `templates/agdr.md` apexyard template is body-only. Spotless AgDRs use a **structured frontmatter overlay** on top:

```markdown
---
id: AgDR-NNNN
timestamp: 2026-MM-DDTHH:MM:SSZ   # ISO8601 UTC, when the decision was made
agent: claude-opus-4-7             # which assistant proposed it
model: claude-opus-4-7[1m]         # full model ID
trigger: <what made this an AgDR>  # e.g. "library choice", "architecture change"
status: accepted | superseded | rejected | proposed
supersedes: AgDR-NNNN              # optional, if this replaces an earlier decision
superseded-by: AgDR-NNNN           # optional, written when a later AgDR replaces this one
---

# {Short Title}

> In the context of {context}, facing {concern}, I decided {decision} to achieve {goal}, accepting {tradeoff}.

## Context
## Options Considered
## Decision
## Consequences
## Artifacts
```

The body sections follow the apexyard template. The frontmatter is the Spotless overlay.

## When `/decide` is invoked

The `/decide` skill writes to `{cwd}/docs/agdr/`. To put the AgDR in the right project:

1. `cd` into the project's working copy first (e.g. `cd ~/Code/app/spotless-operation`)
2. Then invoke `/decide`
3. The skill picks the next `AgDR-NNNN` based on the existing files in that project's `docs/agdr/`

**Do NOT invoke `/decide` from the apexyard repo root** unless the decision is genuinely framework-level (changing a rule, adding a skill, etc.) — in that case the AgDR belongs in apexyard.

## Supersession chain

When a new AgDR replaces an old one (e.g. AgDR-0006 in `spotless-operation` superseded the prior "flip Blaze before suggesting CF work" guidance):

1. New AgDR has `supersedes: AgDR-NNNN` and `status: accepted`
2. Old AgDR gets `superseded-by: AgDR-MMMM` and `status: superseded`
3. Both files stay — the chain is the history, do not delete superseded AgDRs

## Why this differs from the apexyard default

- The apexyard `templates/agdr.md` is intentionally minimal (no frontmatter) so any team can adopt it.
- Spotless has been writing structured frontmatter from day one — see existing AgDR-0006, AgDR-0010, AgDR-0013, AgDR-0015.
- Rewriting old AgDRs to match the minimal template would lose the timestamp + supersession metadata that the Spotless format encodes.

## Anti-patterns

- ❌ Writing an AgDR to `apexyard/projects/spotless/` (those are notes, not AgDRs)
- ❌ Using the bare apexyard template without the frontmatter overlay for new Spotless AgDRs
- ❌ Restarting numbering at AgDR-0001 in a new repo when AgDRs already exist there
- ❌ Deleting a superseded AgDR — the chain is the history
