# Vercel Cron — Daily Granularity Only (Hobby Plan)

Spotless runs on the Vercel **Hobby** plan. Vercel Cron on Hobby is **daily granularity** with ±59 min jitter — it is not a real cron, it's a daily sweep that fires within a one-hour window.

## The rule

Before proposing any Vercel Cron job, check the cadence:

- **≥ 24 hours** → fine. Use Vercel Cron under `spotless-operation/src/app/api/cron/...`.
- **< 24 hours** → **STOP**. Vercel Cron will not run that often on Hobby. Surface the trade-off to the user before proposing anything else.

## Trade-offs to surface when sub-daily is needed

Present these options; do not silently pick one:

1. **Re-open the Blaze question** — a scheduled Cloud Function (`onSchedule`) supports cron expressions down to the minute. See [[server-side-via-vercel-routes]] for the Blaze re-open criteria.
2. **Upgrade Vercel to Pro** ($20/mo) — unlocks cron expressions with sub-daily granularity.
3. **Re-architect to user-driven** — can the work be triggered when a user takes an action instead of on a schedule?
4. **Defer the feature** — is sub-daily latency actually required, or would once-a-day suffice?

The user has chosen option 3 (user-driven) as the default fallback in [[project-spotless-blaze-pending]]. Option 1 should only surface if there's a real reason a user action can't drive the work.

## Cron-route conventions

When the cadence does fit Hobby:

- Path: `spotless-operation/src/app/api/cron/<job-name>/route.ts`
- Auth: check `Authorization` header against `process.env.CRON_SECRET` (Vercel injects this automatically when called by the platform — also gate manually-triggered calls with the same secret).
- Schedule: declared in `vercel.json` → `crons` array.
- Idempotent: a Hobby cron may run twice in a window if the platform retries — make the handler safe to re-run.

## Anti-patterns

- ❌ Adding `0 */15 * * *` (every 15 min) to `vercel.json` on Hobby — it will silently get truncated/refused.
- ❌ Suggesting "let's run this every hour" without flagging the Hobby limit.
- ✅ "This needs to run hourly — that's sub-daily, so we either need Vercel Pro or to trigger it from a user action. Which do you prefer?"
