---
id: AgDR-0006
timestamp: 2026-05-15T14:30:00Z
agent: claude
model: claude-opus-4-7
trigger: user-prompt
status: executed
---

# Spotless post-backlog sequencing — marketing-site P0s + account deletion in parallel, then Cloud Functions foundation

> In the context of having shipped the original 10-item Spotless feature backlog and facing a launch-readiness P0 cluster plus polish/audit work, I decided to start Phase 1 (marketing-site P0s in `iz13m/spotless-web` together with the account-deletion compliance ticket in `iz13m/spotless`), then move to Phase 2 (the Cloud Functions foundation in `iz13m/spotless#55`) as the unblocker for the remaining launch dependencies, to achieve the fastest visible launch readiness while clearing the regulatory gate and freeing the dependency chain, accepting that Sentry, VAT invoicing, polish, and audit findings are deferred until the launch path is clear.

## Context

- Three repos under management: `iz13m/spotless` (customer app), `iz13m/spotless-operation` (ops), `iz13m/spotless-web` (marketing site). Original 10-item backlog (issues #25–#31, #38–#40, #27, #28) is shipped.
- Live state of the marketing site shows Saudi copy + SAR pricing — anyone visiting the URL sees an embarrassing launch-blocker. `spotless-web#1/#2/#3` are tiny fixes (copy + rebuild + link config).
- App Store and Egypt's Data Protection Law both require an in-app account-deletion path; `spotless#56` is the compliance gate. Independent of Cloud Functions (can be done via Admin SDK from ops + a customer-app UI flow).
- `spotless#55` (Cloud Functions foundation) is the linchpin for `#62` subscription session generation, the notification dispatch worker that closes the loop from `#25`/`#38`, and future payment-webhook handling. The longer it waits, the more downstream features stay broken.
- Payment-gateway integration and the cleaner/driver app are explicitly deferred by the founder; not in scope here.

## Options Considered

| Option | Pros | Cons |
|--------|------|------|
| **Phase 1 (marketing-site P0s + account deletion in parallel) → Phase 2 (CF foundation)** (chosen) | Marketing-site fixes are visible and tiny; account deletion clears a regulatory gate; CF foundation unblocks the longest downstream chain. Two repos in flight at once but different files / different concerns, so no contention. | Slightly more cognitive load than single-track; demands disciplined commit hygiene across repos. |
| **Cloud Functions foundation first** | Unblocks dependent work the earliest. | Marketing-site embarrassment persists for days; account deletion stays in regulatory limbo; CF is the biggest single ticket and shouldn't be a one-week solo blocker. |
| **Polish / audit cluster first** (Rex follow-ups + `spotless#41–#50` / ops `#44–#53`) | Quick wins, low risk. | Doesn't move the launch needle; visible marketing-site issues stay broken; regulatory gate stays open. |
| **Sentry / observability first** (`spotless#60`, ops `#56`) | "Eyes on" before bigger changes — safer foundation for the CF migration. | Small wins but doesn't move the launch P0s. Better as a parallel slip-in alongside Phase 1 or Phase 2. |

## Decision

Chosen: **Phase 1 (marketing-site P0s + account deletion) in parallel, then Phase 2 (CF foundation)**, because:

1. Marketing-site P0s are the cheapest visible launch fix — `spotless-web#1`, `#2`, `#3` ship together in ~1 PR each.
2. Account deletion (`spotless#56`) is regulatory; it has hard external gates (App Store review, Egypt DPL) and no Cloud Functions dependency — it can advance independently while marketing-site PRs land.
3. CF foundation (`spotless#55`) is the longest-blocking single ticket — starting it during Phase 1 risks both tracks slipping. Sequencing it after Phase 1 means full focus when it lands.

## Ordered work plan

```
Phase 1 (parallel, ~1 week):
  1. spotless-web#1  Saudi → Egypt copy
  2. spotless-web#2  Rebuild + redeploy with EGP pricing
  3. spotless-web#3  Real App Store / Google Play CTAs
  4. spotless#56     Account deletion + data export

Phase 2 (focused, ~1 week):
  5. spotless#55     Cloud Functions foundation (Firebase Blaze + functions/ workspace)

Phase 3 (depends on #55):
  6. spotless#62     Subscription session generation
  7. (new ticket)    Notification dispatch CF — closes #25/#38 loop
  8. (future)        Payment-gateway webhooks — depends on a gateway integration ticket

Slip-in (can land any time):
  -  spotless#60 + spotless-operation#56  Sentry on both apps
  -  spotless-operation#59                VAT invoicing (gating depends on revenue stage)

Deferred (post-launch):
  -  Rex follow-ups: spotless#36, #37, #38
  -  Audit findings: spotless#41–#50, spotless-operation#44–#53
  -  Cleaner/driver app (founder-deferred)
  -  Payment gateway integration (founder-deferred; not ticketed)
```

## Consequences

- The next ticket to start: `spotless-web#1` (Saudi → Egypt copy) — smallest visible win.
- Marketing-site PRs can be batched if the diffs are small enough; copy + rebuild + CTAs may fit in one PR rather than three.
- `spotless#56` runs in parallel; doesn't block on marketing-site work.
- `spotless#55` requires Firebase Blaze plan enablement — a billing prerequisite that must be confirmed before the ticket starts. The founder needs to flip the project to Blaze.
- Polish and audit clusters are explicitly off the table until Phase 2 lands. If the user requests a quick win out of band, this AgDR is not a hard contract — re-evaluate.
- Sentry (`spotless#60`, ops `#56`) can be picked up between Phase 1 and Phase 2 if there's a natural lull; it's small enough to be a "between-the-cracks" ticket.

## Artifacts

- (anticipated) PR series in `iz13m/spotless-web` for #1, #2, #3
- (anticipated) PR in `iz13m/spotless` for #56
- (anticipated) PR in `iz13m/spotless` for #55
