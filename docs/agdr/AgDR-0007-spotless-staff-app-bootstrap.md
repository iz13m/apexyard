---
id: AgDR-0007
timestamp: 2026-05-21T00:00:00Z
agent: claude-opus-4-7
model: claude-opus-4-7[1m]
session: spotless-staff-bootstrap
trigger: user-prompt
status: executed
---

# Spotless Staff App — bootstrap (override AgDR-0006 deferral)

> In the context of Spotless rolling out a workforce coordination layer alongside the customer app, facing the prior deferral of the driver/cleaner app in AgDR-0006, I decided to build the staff app now as a separate `iz13m/spotless-staff` repo using Expo SDK 54 managed + React Native Firebase, sharing the customer app's Firebase project, to ship a v0.0.1 role-routed shell quickly while keeping the customer + staff stacks identical, accepting that role resolution starts as a Firestore-read on every auth event (not yet a custom-claim) and that the parked `fix/GH-3-store-ctas` work will eventually conflict on the registry edit.

## Context

[AgDR-0006](./AgDR-0006-spotless-launch-sequencing.md) (currently unmerged on `fix/GH-3-store-ctas`) sequenced the post-backlog Spotless work and explicitly noted *"Payment-gateway integration and the cleaner/driver app are explicitly deferred by the founder; not in scope here."*

That stance is being reversed. The founder wants the workforce app ready to slot in once the customer app's Cloud Functions foundation (#55) and account-deletion gate (#56) clear, so dispatch can flow end-to-end as soon as ops-side endpoints exist.

The customer app `iz13m/spotless` already runs on:

- Expo SDK 54 (managed-ish — has `ios/` and `android/` directories, dev-client style)
- Expo Router 6, with `main` = `expo-router/entry`
- React Native Firebase 24 (`@react-native-firebase/{app,auth,firestore,messaging}`)
- Sentry 7.2
- TypeScript 5.9 strict
- Jest 30, ts-jest

The staff app has zero shipped artefacts today. The portfolio convention is one repo per project, registered in `apexyard.projects.yaml`.

## Options Considered

### Repo strategy

| Option | Pros | Cons |
|---|---|---|
| Separate repo `iz13m/spotless-staff` | Matches ApexYard portfolio model; independent CI; clean visibility/permissions split (private from day one); future sharing via a published package | Two repos to upgrade Expo SDK in lockstep; no automatic code-share until a package is extracted |
| Monorepo with the customer app | Trivial code-share for design tokens, Firebase init, types | Requires migrating the customer app's existing tooling; large blast radius; not how the portfolio is shaped today |
| Combined-app, role-switched at runtime in `iz13m/spotless` | Single bundle, single CI | Mixes customer + workforce UX in one TestFlight build; reviewer confusion; harder app-store reviews; impossible to give staff-only beta access without exposing the customer surface |

### Cross-platform framework

| Option | Pros | Cons |
|---|---|---|
| Expo (managed) | Fastest setup; EAS Build handles iOS/Android signing; OTA updates; matches the customer app | Native-module additions need EAS dev builds (still cheap, just not "expo go") |
| Bare React Native | Full native control | Slower bootstrap; needs Xcode + Android Studio manual config; diverges from customer app |
| Flutter | Strong tooling, performant | Dart not in the Spotless stack; no code-share with the React Native customer app |

### Backend integration

| Option | Pros | Cons |
|---|---|---|
| Share `spotless` Firebase project, add iOS/Android app records for `com.spotless.staff` | Users + Firestore already exist; a single uid carries `role: driver / cleaner / customer`; dispatch logic is a simple Firestore write | All apps share the same Firestore data — security rules must distinguish staff vs customer reads precisely; one project's billing covers both |
| New Firebase project for the staff app | Clean isolation, separate billing | Auth + user data must be mirrored or synced; cross-project dispatch becomes a two-system problem; significantly more setup |
| Defer Firebase config; v0.0.1 ships without real auth | Lowest risk of being blocked on Firebase-console admin | "Role routing works" can't be verified — the whole point of v0.0.1 |

### Role source of truth

| Option | Pros | Cons |
|---|---|---|
| Firestore `users/{uid}.role` read on auth event | Works without any Cloud Function; trivial for v0.0.1 | One extra round-trip per auth state change; security depends on Firestore rules; doesn't survive offline first-launch |
| Firebase Auth custom claims set via Cloud Function | Lives in the ID token; survives offline; rules can reference `request.auth.token.role` | Needs a Cloud Function — `iz13m/spotless` doesn't have a Functions deploy yet (per AgDR-0006, that's #55 still in flight) |

## Decision

Chosen on each axis:

- **Repo strategy**: separate `iz13m/spotless-staff` repo, private.
- **Framework**: Expo managed (SDK 54), exact version-pinning to mirror `iz13m/spotless`.
- **Backend integration**: share the customer app's Firebase project; add new iOS + Android app records for bundle id `com.spotless.staff`.
- **Role source**: Firestore `users/{uid}.role` for v0.0.1, migrate to custom claims once a Cloud Function exists.

Justification: the path of least divergence from the customer app while still creating a clean repo boundary. The Firebase-project share is the single decision with the most leverage — it means a uid can be both "a customer who also drives" or "a cleaner who also books cleans" without any data sync, and a future dispatch write from the ops dashboard touches one Firestore, not two.

## Consequences

### Immediate
- New repo `iz13m/spotless-staff` exists, private, with v0.0.1 = login + role-routed shell + CI.
- `apexyard.projects.yaml` now lists `spotless-staff`. `/projects`, `/inbox`, `/status` aggregate it from next session onward.
- Two new app records (`com.spotless.staff`) exist in the `spotless` Firebase project. `GoogleService-Info.plist` and `google-services.json` are issued for those records — **gitignored** in the staff-app repo; teammates download fresh copies from the Firebase console.

### Near-term follow-ups (out of v0.0.1 scope)
- Update Firestore security rules in `iz13m/spotless` once dispatch collections exist — staff reads/writes need `request.auth.token.role` (or fallback to `getAfter(/users/$uid).data.role`) gating.
- Wire `Sentry.init` with an `EXPO_PUBLIC_SENTRY_DSN`. v0.0.1 has the SDK installed but un-initialised.
- EAS Build + TestFlight + Play Internal channels.

### Longer-term
- When a `setStaffClaims` Cloud Function exists in `iz13m/spotless`, migrate the staff-app guard from Firestore read to ID-token claim. Removes one round-trip per sign-in and enables offline-first launch.
- A shared `@spotless/ui` or `@spotless/firebase` package may be worth extracting once a second concrete UI screen needs the same component on both apps.

### Risks accepted
- **Registry conflict on `fix/GH-3-store-ctas` merge**: that branch is stashed locally and carries its own `apexyard.projects.yaml` edit (adding `spotless-web`). When it reopens its PR after this one merges, expect a conflict in the projects list — resolve by keeping both entries.
- **Shared Firebase blast radius**: a misconfigured staff-app Firestore rule could affect customer data. Mitigated by review on the rules PR in `iz13m/spotless` when it lands.

## Artifacts

- Plan file: `/Users/iz13m/.claude/plans/it-s-time-to-work-zippy-stearns.md`
- Ops-repo ticket: [iz13m/apexyard#1](https://github.com/iz13m/apexyard/issues/1)
- Staff-app first ticket: iz13m/spotless-staff#1 (created in step 7 of execution)
- Supersedes the "cleaner/driver app deferred" stance in [AgDR-0006](./AgDR-0006-spotless-launch-sequencing.md) — AgDR-0006 remains correct on every other point.
