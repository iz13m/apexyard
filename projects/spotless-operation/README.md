# Spotless Operation

Next.js ops admin + all server-side Vercel API routes for the Spotless portfolio.

| | |
|---|---|
| Repo | [iz13m/spotless-operation](https://github.com/iz13m/spotless-operation) |
| Stack | Next.js (App Router) · TypeScript · Tailwind · firebase-admin · next-intl |
| Deploy | Vercel (Hobby) — all server-side workloads per AgDR-0006 (no Cloud Functions, Spark plan) |
| Local | `~/Code/app/spotless-operation` |

## Scope

- Ops admin UI: bookings, cleaners, drivers, routes, payments, payouts, coupons, referrals, incidents, notifications — plus the STR-pivot surfaces (properties, playbooks, turnovers, quality review, hosts).
- `/api/**` Vercel routes: customer-app server calls, host-app server calls (booking, cancel, account deletion, profile), staff-triggered notifications, daily crons.
- Key AgDRs in-repo: AgDR-0006 (Vercel routes, no Blaze), AgDR-0015 (Arabic), AgDR-0017 (STR pivot), AgDR-0018 (turnover specialist pool), AgDR-0019 (host account deletion).

## Conventions

- Firestore schema mirror #2 of 4 (`src/types/index.ts`) — see the firestore-schema-mirror rule.
- Server-side auth helpers: `requireStaff` / `requireUser` / `requireHost` in `src/lib/api-auth.ts`.
- Pure-helper extraction pattern for all route logic (unit-tested without the admin SDK).
