# Addendum: Backend Engineer — Spotless Firebase/Firestore Context

> Read this file IN ADDITION to [`roles/engineering/backend-engineer.md`](../engineering/backend-engineer.md) whenever the Backend Engineer role activates in the Spotless portfolio. Extends, does not replace.

## When this addendum applies

Auto-activate alongside Backend Engineer when the PR diff touches any of:

- `**/firestore.rules`, `**/firestore.indexes.json`
- `**/lib/firebase-admin.ts`, `**/lib/firestore*.ts`
- Schema files: `**/types/firestore.ts`, `**/lib/types.ts`, `spotless/functions/src/types.ts`
- Any Vercel API route in `spotless-operation/src/app/api/**` that calls Firestore
- Any `useCollection` / `useDocument` hook or `firestore()` call in customer-app

## Additional responsibilities

- **Schema mirror discipline** — every Firestore type change propagates to all three mirrors in the same PR (see [[firestore-schema-mirror]]).
- **Security rules** — Firestore rules are code and must be tested in the **emulator** before merge. A `firestore.rules` change without an emulator-test diff is a rule violation.
- **Composite indexes** — declared in `firestore.indexes.json`, not waited for at runtime. Firestore will error on the first uncovered query; predicting the query shape ahead of time is the Backend Engineer's job.
- **Region invariant** — every Firestore client / admin init points at `me-central2`. Cross-region reads add ~200ms and create inconsistency windows.
- **Admin SDK boundary** — `firebase-admin` only ever runs inside `spotless-operation` (Vercel API routes) or the dormant `functions/`. It NEVER ships in the customer-app bundle.
- **Vercel-route pattern** — server-side logic = API route + `requireStaff/User` + admin SDK + pure helper. See [[server-side-via-vercel-routes]]. Never a Cloud Function.
- **Query cost awareness** — Firestore charges per document read. Listening to a 10k-document collection from the customer-app is a billing incident waiting to happen. Always paginate, always project, always think about the `select`-equivalent.

## Additional CAN / CANNOT

### CAN
- Block any PR that changes one schema mirror without updating the other two
- Reject security-rule changes that lack an emulator-test diff
- Demand a composite index entry alongside any new compound `where(...).orderBy(...)` query
- Override an "I'll use the JS SDK" suggestion in the customer-app — it must be `@react-native-firebase/*`

### CANNOT
- Re-open the Blaze plan unilaterally — that requires a superseding AgDR per [[server-side-via-vercel-routes]]
- Add a new Cloud Function — must be a Vercel route instead
- Skip the emulator-test step for security-rule changes "because it's a tiny edit"

## Firestore-PR checklist

Before any Firestore-touching PR is ready for merge:

- [ ] All three schema mirrors updated (customer-app, ops, `functions/`)
- [ ] Security rules updated to match (and tested against the emulator)
- [ ] Composite indexes declared in `firestore.indexes.json` for any new compound query
- [ ] Region is `me-central2` everywhere
- [ ] Admin SDK is NOT imported into the customer-app bundle
- [ ] Query cost is bounded — pagination present where the collection can grow > 100 docs
- [ ] Listener cleanup verified on the customer-app side (no leaked `onSnapshot` subscriptions)
- [ ] AgDR written if the change introduces a new collection or significantly changes access patterns

## Spotless anti-patterns

- ❌ Importing `firebase/firestore` (JS SDK) in the customer-app — must be `@react-native-firebase/firestore`
- ❌ Schema change in `spotless-operation/src/lib/types.ts` without the matching update in `spotless/types/firestore.ts`
- ❌ `firestore().settings({ host: 'localhost:8080' })` in production code — emulator config must be env-gated
- ❌ `region: 'us-central1'` anywhere in the codebase
- ❌ Calling `firestore().collection('bookings').get()` (full collection read) from any user-facing code path
- ❌ Writing security rules and merging without emulator coverage — even "tiny" rule changes can lock all users out

## Related rules

- [[firestore-schema-mirror]] — the 3-repo mirror discipline
- [[server-side-via-vercel-routes]] — server-side workloads via Vercel, not Cloud Functions
- [[functions-dormant]] — `spotless/functions/` is reference, not active
- [[egypt-first-defaults]] — `me-central2` region invariant
