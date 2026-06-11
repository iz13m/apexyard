# Spotless Staff

Mobile app for the Spotless workforce — drivers and cleaners.

## What it is

A cross-platform (iOS + Android) Expo app that signs staff in, detects their role from the user profile, and routes them to a role-specific home screen. Today it's a thin shell; over the next phases it gains job listings, check-in/out, photo capture, and push notifications.

## Repo

- **Code**: [iz13m/spotless-staff](https://github.com/iz13m/spotless-staff) (private)
- **Live working copy**: `workspace/spotless-staff/` (gitignored in this ops repo)
- **First ticket**: [iz13m/spotless-staff#1 — Bootstrap Expo + role-routed shell](https://github.com/iz13m/spotless-staff/issues/1)

## Stack

| Layer | Choice |
|---|---|
| Framework | Expo SDK 54 (managed) |
| Routing | Expo Router 6 |
| Language | TypeScript 5.9 strict |
| Backend | Firebase (Auth + Firestore + Messaging) via `@react-native-firebase/*` |
| Firebase project | **Shared** with the customer app (`iz13m/spotless`) — separate app records for bundle id `com.spotless.staff` |
| Error tracking | `@sentry/react-native` (installed, DSN not wired in v0.0.1) |
| Testing | Jest 30 + Detox (later) |
| CI | GitHub Actions (`golden-paths/pipelines/ci.yml`) |
| Builds | EAS Build (deferred to follow-up) |

Mirrors the customer app's stack exactly so a shared `@spotless/ui` package becomes trivial later.

## Status

**Phase 1 — shell only.** Login screen, role detection from Firestore `users/{uid}.role`, two empty home screens (DriverHome, CleanerHome). No real workforce features yet.

See [roadmap.md](./roadmap.md) for what's next.

## Owners

- Tech Lead: TBD
- Frontend Engineer: TBD
- QA Engineer: TBD

## Decisions

- [AgDR-0006 — Spotless launch sequencing](../../docs/agdr/AgDR-0006-spotless-launch-sequencing.md) — originally deferred this app
- [AgDR-0007 — Spotless staff app bootstrap](../../docs/agdr/AgDR-0007-spotless-staff-app-bootstrap.md) — overrides AgDR-0006 and records the stack choice

## Open questions / known follow-ups

- Custom-claims migration once a Cloud Function exists in `iz13m/spotless` to set them (more secure than reading `users/{uid}.role` from Firestore on every auth event)
- Security-rules update in `iz13m/spotless` to permit staff reads/writes when dispatch collections exist
- EAS Build + TestFlight + Play Internal channels
- Shared design tokens / UI package extraction once there's a second consumer
