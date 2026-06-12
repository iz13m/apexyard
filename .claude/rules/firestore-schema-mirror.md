# Firestore Schema — Four-Repo Mirror Discipline

The Spotless Firestore schema lives in **four places**. Any change to one is a bug if the other three aren't updated in the same PR.

## The four mirrors

| Location | Path | Purpose |
|----------|------|---------|
| Host app (pivot product) | `spotless-business/lib/types.ts` | RN host app's view via `@react-native-firebase/firestore` |
| Customer app | `spotless/lib/types.ts` | RN customer app's view via `@react-native-firebase/firestore` |
| Ops | `spotless-operation/src/types/index.ts` | Next.js admin's view via `firebase-admin` |
| Functions (dormant) | `spotless/functions/src/types.ts` | Kept in sync as reference; see [[functions-dormant]] |

*Verify exact paths against the current repos before edits — the structure is stable but specific filenames may shift.*

## The rule

When editing **any** of the schema mirrors:

1. **Identify all four locations** before writing the edit.
2. **Apply the same shape change to all of them in the same PR.** Adding a field, changing a type, renaming a key, marking optional → required: all must propagate.
3. **Add a one-line note in the PR description** confirming the mirror was applied: "Updated Firestore types in spotless-business, spotless, spotless-operation, and functions/."
4. **If a reader/writer doesn't exist in one repo for the changed field, that's fine** — the type still needs to match so future code doesn't drift.

## When the four repos legitimately disagree

Only one case: a field that **only the admin SDK can write** (e.g. server-time fields, audit columns set by `requireStaff` routes). In that case:

- Customer-app type may mark the field as `readonly` and omit it from create payloads
- Ops type marks it writable
- Both still **share the same field name and value type** — only the create/write surface differs

Annotate the divergence with a comment in both repos: `// admin-only write; customer-app reads via Firestore listener`.

## Detection

Without this rule, drift surfaces as:
- A field exists in ops but the customer-app reads `undefined`
- A field is `string` in customer-app and `string | null` in ops, and customer-app crashes on the null
- A renamed field gets read by stale customer-app code that ships in the next EAS build

Each of these has happened or is one PR away from happening.

## Long-term fix (not part of this rule)

The recurring schema-mirror cost is the strongest argument for a shared `@spotless/types` workspace package — listed in [[project-spotless-overview]] as recurring debt. Until that exists, the mirror rule is the discipline that replaces it.

## Backstop

There is no hook for this — the rule is enforced by Claude noticing the schema file is being edited and proactively listing the other two locations. If a session edits only one mirror, that's a rule violation that should be flagged in the PR description, not silently merged.
