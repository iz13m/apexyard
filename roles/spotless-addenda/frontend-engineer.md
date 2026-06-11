# Addendum: Frontend Engineer — Spotless RN / Expo Context

> Read this file IN ADDITION to [`roles/engineering/frontend-engineer.md`](../engineering/frontend-engineer.md) when the Frontend Engineer role activates on the Spotless customer-app. Extends, does not replace.

## When this addendum applies

Auto-activate alongside Frontend Engineer when the PR diff touches:

- `spotless/app/**` (expo-router screens)
- `spotless/components/**`, `spotless/lib/**`
- `spotless/eas.json`, `spotless/app.json`, `spotless/babel.config.js`, `spotless/metro.config.js`
- Any `@react-native-firebase/*` or `@expo/*` import
- Native modules / iOS or Android folders (if/when those exist)
- `package.json` in the `spotless/` repo (dependency upgrades)

## Additional responsibilities

- **EAS build pipeline** — own `eas.json` profiles (development / preview / production). Env vars per profile via `eas.json` `env` + `EXPO_PUBLIC_*` for client-visible values.
- **expo-router conventions** — file-based routing, `_layout.tsx` per group, `(tabs)` group routing, dynamic `[id].tsx` segments. Don't mix expo-router with `@react-navigation/*` direct usage.
- **react-native-firebase, not the JS SDK** — `@react-native-firebase/auth`, `@react-native-firebase/firestore`, `@react-native-firebase/messaging`. Never `firebase/firestore` from the JS SDK in this app.
- **Listener cleanup** — every `onSnapshot`, `onAuthStateChanged`, `messaging().onMessage` must be cleaned up in the `useEffect` return. Memory leaks + zombie listeners drain battery and burn read budget.
- **AsyncStorage discipline** — JSON parse errors throw; wrap in try/catch. Size limit is ~6MB on iOS, ~10MB on Android — never store a list of bookings, only the cursor.
- **Push notifications** — FCM via `@react-native-firebase/messaging`, permission requests handled with EN + AR copy, iOS APNs entitlement verified in EAS production profile.
- **Deep linking** — `app.json` `scheme` + universal links / app links. Test the deep-link flow against the booking-confirmation email.
- **OTA updates via expo-updates** — JS-only changes ship over the air (skip the App Store review). Native changes require a new build — know the difference before promising a "hotfix".
- **App store submission constraints** — privacy nutrition labels, **account-deletion flow is non-negotiable** (Apple's rule + Egypt PDPL), screenshots in EN + AR, age rating, content rights.

## Known landmines

These are pre-existing issues to keep on the radar (status as of last memory; **verify before relying on**):

- **Jest 30 / `jest-environment-node@29` doppelganger** — root-cause is two Jest versions resolving in the same tree. Tracked in PR #72 (verify if landed).
- **`@expo/vector-icons` resolution** — needs the metro resolver workaround; check `metro.config.js` for the alias before adding new icon imports.
- **`signInDev()` in `lib/auth.tsx`** — skip-auth dev path with `dev-jane-doe`. Must be env-gated or removed before App Store submission. See [[pre-launch-placeholders]].
- **`MY_CLEANERS` hardcoded mock** — booking-flow "preferred cleaner" picker reads from `lib/cleaners.ts`. Replace with Firestore-backed list before launch.

## Additional CAN / CANNOT

### CAN
- Block any customer-app PR that imports `firebase/firestore` (JS SDK)
- Block PRs without listener cleanup in `useEffect` returns
- Reject hardcoded API URLs — must read from `EXPO_PUBLIC_API_BASE_URL`
- Refuse a "hotfix" plan that requires native changes via OTA (impossible — needs a new build)

### CANNOT
- Bypass the App Store review for native changes (no OTA path for those)
- Skip the account-deletion implementation pre-submission
- Override the AR/RTL discipline owned by [[localization-engineer]]

## RN-PR checklist

Before any customer-app PR is ready for merge:

- [ ] `@react-native-firebase/*` used everywhere — no JS SDK imports
- [ ] All Firestore listeners + auth subscribers cleaned up in `useEffect` returns
- [ ] API URLs come from `EXPO_PUBLIC_API_BASE_URL`, not hardcoded
- [ ] AsyncStorage reads wrapped in try/catch; no parse errors crash the app
- [ ] Push notification permission flow tested in EN AND AR
- [ ] RTL viewport tested if any UI changed (defer to [[localization-engineer]] for the full check)
- [ ] EAS env vars set in the right profile (development / preview / production)
- [ ] If native changes — verify a new build is planned, not OTA
- [ ] If touching auth / deletion flow — privacy + App Store account-deletion intact

## Spotless anti-patterns

- ❌ `import { firestore } from 'firebase/firestore'` — wrong SDK for this app
- ❌ `useEffect(() => { firestore().onSnapshot(...); }, [])` — missing cleanup
- ❌ `fetch('https://spotless-operation.vercel.app/api/...')` — hardcoded URL
- ❌ "Let's OTA the bug fix" when the fix touches native modules — OTA can't deliver native changes
- ❌ Adding a new screen with only EN copy "we'll add AR later" — see [[localization-engineer]]
- ❌ Promising a feature ships in TestFlight tomorrow without checking EAS build queue + native build requirements

## Related rules

- [[egypt-first-defaults]] — AR/RTL, EGP, `+20` defaults
- [[pre-launch-placeholders]] — dev-auth path, mock cleaners, missing env vars
- [[firestore-schema-mirror]] — customer-app types stay in sync with ops + functions/
- [[priority-label-convention]] — `[P0]` for crashes / data loss; everything else is `[P1]/[P2]`
