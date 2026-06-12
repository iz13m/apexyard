# `spotless/functions/` is Dormant Reference Code

The `spotless/functions/` workspace is **retained but not deployed**. It exists as reference for what the Cloud Function version would look like if Blaze is ever re-opened.

## The rule

- **Do not propose work in `functions/`.** Any new server-side logic goes into `spotless-operation/src/app/api/...` — see [[server-side-via-vercel-routes]].
- **Do not delete `functions/`.** It is the canonical reference for AgDR-0013 in `iz13m/spotless` (CF foundation plan).
- **Do not deploy from `functions/`.** Spark plan doesn't allow CF deploys; running `firebase deploy --only functions` will fail.
- **Do not "clean up" the `package.json` dependencies inside `functions/`.** They look stale because the workspace is frozen on purpose.

## When `functions/` can be touched

Only these reasons justify edits inside `functions/`:

1. **Schema mirror sync** — see [[firestore-schema-mirror]]. The `functions/src/types.ts` mirror still gets kept in sync even though no code runs from it.
2. **A user-initiated decision to re-open Blaze** — would resurrect this code. Until then, hands off.
3. **The user explicitly asks** — "update the function for X".

## When the user re-opens Blaze (future)

If/when the conditions in [[server-side-via-vercel-routes]] § "When to re-open" trigger:

1. AgDR-0006 (spotless-operation) gets a superseding AgDR entry: "Blaze re-opened for <reason>."
2. The `functions/` workspace gets a refresh PR before any deploy: dependency bump, types resync, smoke tests.
3. Only **then** does CF deployment happen.

Skipping these steps and just running `firebase deploy --only functions` from a stale workspace will produce subtle correctness bugs because of drift from the API-route implementations that have shipped in the meantime.

## Why the workspace stays

- The CF version captures **one canonical answer** to "how would the dispatch / notification / coupon flow look as Firestore triggers?" — useful reference if Blaze re-opens.
- Deleting + re-creating is more expensive than keeping it dormant.
- It does not affect production (Spark won't deploy it) so the carrying cost is near-zero.
