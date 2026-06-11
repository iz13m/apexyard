# Pre-Launch Placeholder Sweep

Spotless is pre-launch. During build-out, the codebase accumulated placeholder values for unprovisioned services and missing real data. Every placeholder is a known leak between code and reality.

**Before any "production deploy" / "ready to launch" / "first real customer" claim, walk this list and confirm each item is resolved or explicitly deferred.**

## The full inventory (lives in user memory)

Authoritative inventory: the `project-placeholders-to-replace` user memory at
`~/.claude/projects/-Users-iz13m-Code-app/memory/project_placeholders_to_replace.md`.

The high-level groups are below. **Always read the memory file at launch-readiness time** — it gets updated as items are resolved.

### Env vars (currently unset or placeholder)

- **Ops (Vercel `spotless-operation`)**
  - `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, `TWILIO_FROM_NUMBER` — SMS routes 500 without these (PR #86)
  - `NEXT_PUBLIC_SENTRY_DSN`, `SENTRY_AUTH_TOKEN`, `SENTRY_ORG`, `SENTRY_PROJECT` — Sentry project `spotless-ops` not provisioned
  - `EMAIL_FROM_ADDRESS` — currently the user's personal gmail; swap to verified `spotless.eg` sender on SendGrid (see [[project-email-from-address]] memory)
- **Customer app (EAS env vars)**
  - `EXPO_PUBLIC_API_BASE_URL` — set to Vercel ops URL once EAS builds start
  - `EXPO_PUBLIC_SENTRY_DSN`, `SENTRY_AUTH_TOKEN` — Sentry project `spotless-customer` not provisioned
- **Marketing site (Vercel `spotless-web`)**
  - `PUBLIC_PLAUSIBLE_DOMAIN` — set to `spotless.eg` after creating site at plausible.io

### Firestore config docs to seed

- `config/business_profile` — `taxRegistration` + `legalName` (AgDR-0010 has the seed command). Invoices without this snapshot empty values.
- `config/cancellation_policy` — defaults work; seed only to tune.
- `config/referral_program` — defaults work; seed only to tune.

### Hardcoded placeholder data in code

- **`spotless/lib/cleaners.ts MY_CLEANERS`** — 3 mock cleaners + mock reviews. Replace with Firestore-backed real list before launch.
- **`spotless/lib/auth.tsx signInDev()`** — `dev-jane-doe` skip-auth path. Remove or env-gate before App Store submission.
- **`spotless-web/src/i18n/ui.ts CONTACT`** — `+20 2 0000 0000`, `+20 10 0000 0000` are explicit placeholders.
- **`spotless-web/src/components/HomeBody.astro` hero stats** — "500+ Vetted cleaners", "10k+ Homes cleaned", "4.9★" are aspirational. Soften or replace.
- **`spotless-web/public/og-image.png`** — missing; spec in `public/og-image.README.md`. Social shares 404 until added.

### Docs pending real content

- **Sentry dashboard URL** in `spotless-operation/docs/agdr/AgDR-0015-error-tracking-customer.md`
- **Insurance carrier + claim process** in `spotless-operation/docs/incidents.md`

## When this rule fires

Trigger this sweep when any of these happen in conversation:

- User says "ready to launch", "go live", "first customer", "production deploy"
- User asks to flip a feature flag from preview to production
- User asks for a launch checklist or readiness audit
- User merges a PR labelled `launch` or that affects production deploy config

The response is: **read the memory file, walk the user through the unresolved items, get explicit confirmation on each before declaring launch-ready.**

## What "resolved" means per item

- **Env var**: set in Vercel (Production + Preview), confirmed by `vercel env ls`
- **Firestore config doc**: seeded, confirmed by reading the doc back from Firestore
- **Hardcoded mock**: code path replaced (separate PR + AgDR if the replacement is non-trivial)
- **Docs**: real value written in place of the placeholder string

## What "deferred" means per item

The user explicitly says "ship without it, we'll fix in week 1". Note the deferral in the launch AgDR, don't pretend the placeholder doesn't exist.

## Why this is a rule, not a doc

A doc gets forgotten. A rule that fires on "ready to launch" forces the conversation at the moment it matters.
