# Server-Side Workloads — Vercel API Routes, Not Cloud Functions

**Portfolio-wide architectural decision. Codifies AgDR-0006 in `spotless-operation/docs/agdr/` (dated 2026-05-19).**

The Firebase project `spotless-140b8` stays on the **Spark** plan indefinitely. Any server-side workload runs as a **Vercel API route** inside `spotless-operation`, using `firebase-admin` with a service-account JSON in env.

## The rule

When a feature needs server-side logic:

- **Propose a Vercel API route** under `spotless-operation/src/app/api/...`
- **Do NOT propose a Cloud Function**
- **Do NOT propose flipping Blaze** unless the feature genuinely needs one of the re-open triggers below

## The pattern

```
spotless-operation/src/app/api/<domain>/<action>/route.ts
  ↓ calls
spotless-operation/lib/api-auth.ts  →  requireStaff(req)  or  requireUser(req)
spotless-operation/lib/firebase-admin.ts  →  admin SDK init
spotless-operation/lib/<domain>/<thing>.ts  →  pure helper (testable)
```

- **Auth**: `requireStaff` for ops endpoints, `requireUser` for customer-app endpoints.
- **Admin SDK**: `lib/firebase-admin.ts` initialises once per cold start.
- **Helper extraction**: pure logic in a sibling helper so unit tests don't need the route harness.

## Periodic / background work

- Use **Vercel Cron** (Hobby supports 100 cron jobs, daily granularity ±59 min). See [[vercel-cron-is-daily]].
- For sub-daily background work, see the re-open conditions below — do NOT silently propose a 15-minute sweep that won't actually run on Hobby.

## When to re-open the Blaze question

Surface this trade-off explicitly to the user; do NOT just flip back to Cloud Functions:

1. A feature needs to react to a Firestore write from **multiple sources** (not just one UI). API routes can't see writes triggered by other clients.
2. A feature needs **sub-daily background processing** (cron < 24h). Hobby cron is daily-only.
3. Outbound volume exceeds the Spark tier limits in a way the API-route pattern can't avoid.

If none apply, the answer is still Vercel routes.

## What about `spotless/functions/`?

Dormant. See [[functions-dormant]]. Don't propose work in it, don't delete it.

## The new secret

`FIREBASE_SERVICE_ACCOUNT_JSON` in Vercel env (Production + Preview only, NOT Development — local dev uses the Firestore emulator). Generated from Firebase Console → Project Settings → Service Accounts. Treat like a database password.

## Why

- One stack (Vercel) — no second billing relationship, no second observability surface.
- Predictable cost ($0 Hobby → $20/mo Pro if exceeded).
- Workload is overwhelmingly user-driven — every CF-blocked feature has a natural HTTP caller.

Loss accepted: real-time Firestore-trigger reactivity. Replaced with UI-coupled explicit POSTs + daily Vercel Cron sweeps.

## Anti-patterns

- ❌ "Let's add a Cloud Function to send the confirmation email."
- ❌ "I'll create a `onDocumentCreated` trigger for new bookings."
- ❌ "Bump the project to Blaze and deploy `functions/dispatchBroadcast`."
- ✅ "I'll add a `POST /api/bookings/[id]/notify` route the customer-app calls after confirming a booking."
- ✅ "I'll add a Vercel Cron at `/api/cron/expire-coupons` that runs daily."
