# Spotless Staff — Roadmap

## Phase 1 — Shell (v0.0.1, current)

**Goal:** prove the auth + role-routing layer end-to-end. No real workforce features.

- Expo SDK 54 + Expo Router 6 scaffold
- TypeScript strict, ESLint + Prettier
- React Native Firebase (Auth + Firestore) wired against the shared `spotless` Firebase project
- Email/password sign-in
- Role detection from `users/{uid}.role` ∈ `{driver, cleaner}` (customer-role accounts rejected)
- Two empty home screens: `DriverHome`, `CleanerHome`
- One smoke test, CI green
- iOS simulator + Android emulator boot tested

Tracked in [iz13m/spotless-staff#1](https://github.com/iz13m/spotless-staff/issues/1).

## Phase 2 — Today's jobs (per role)

**Goal:** the smallest read-only view that's actually useful.

- Driver: today's pickups / route in date order
- Cleaner: today's assigned cleanings with address + time window
- Pull-to-refresh, empty state, error state
- Backed by Firestore collections that the ops dashboard writes (collection design lives in `iz13m/spotless`, not here)

Blocked on: dispatch collections existing in the shared Firebase project.

## Phase 3 — Check-in / check-out + status updates

**Goal:** staff can mark a job as started, in progress, completed, with photos.

- Check-in (geo-locate, mark on-site)
- Check-out (mark complete, capture before/after photo)
- Status updates ("on the way", "delayed", "issue at site")
- Offline buffering with sync on reconnect

Blocked on: Cloud Functions in `iz13m/spotless` for status transitions + storage rules for photo uploads.

## Phase 4 — Push notifications + polish

**Goal:** staff get notified about new assignments, schedule changes, dispatch messages.

- Firebase Messaging integration (deps already present)
- Notification preferences screen
- Deep links from notifications into specific jobs
- Sentry DSN wired up (error reporting live)
- EAS Build + TestFlight + Play Internal distribution channels
- Detox e2e suite for the critical paths

## Beyond

- Driver-specific: multi-stop routing, mileage tracking
- Cleaner-specific: supplies checklist, customer signature capture
- Shared `@spotless/ui` package extraction (once design tokens are reused across customer + staff apps)
- Custom-claims migration (drop the Firestore role-read in favour of token claims)
