# Spotless Business

Host-facing mobile app for short-term-rental turnovers — the STR pivot product.

| | |
|---|---|
| Repo | [iz13m/spotless-business](https://github.com/iz13m/spotless-business) |
| Stack | Expo 56 · React Native 0.85 · TypeScript · `@react-native-firebase/*` (auth, firestore, storage, messaging) · Sentry |
| Firebase | Shares `spotless-140b8` with customer + staff apps, role-discriminated via `hosts/{uid}` (AgDR-0003) |
| Local | `~/Code/app/spotless-business` |

## Scope

- Host sign-in (email/password, invite-only at MVP1), role-gated shell.
- Property portfolio (read-only — ops onboards white-glove per AgDR-0017).
- Turnover booking + list + detail + photo proof viewer + cancel.
- Push notifications (4 events) with deep-linking to turnover detail.
- Account: profile self-edit + App-Store-compliant account deletion.
- Key AgDRs in-repo: AgDR-0001 (bootstrap), AgDR-0002 (Property/Playbook/Turnover schema — canonical), AgDR-0003 (host auth model).

## Conventions

- Firestore schema mirror #1 of 4 (`lib/types.ts`) — canonical source per AgDR-0002.
- EN + AR ship together in `lib/i18n.tsx` (compile-enforced parity); RTL first-class.
- Server calls via `lib/api.ts` (`apiPost` / `apiPatch`) to spotless-operation routes.
