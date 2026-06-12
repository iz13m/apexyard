# Egypt-First Defaults

Spotless launches in **Egypt** first. These defaults are non-negotiable context for any feature, copy change, or infrastructure decision.

## Currency

- All prices in **EGP** (Egyptian Pound).
- Display: `EGP 250` or `250 ج.م` depending on locale; never `$250`.
- Storage: integer minor units (`piastres`) is preferred — `EGP 250.50` stored as `25050`. Floating point on currency is a known foot-gun.
- No mixed-currency states. If a hypothetical international expansion comes up, surface it as an explicit conversation — don't sneak in `currency: 'USD'` as a default.

## Locale & RTL

- **AR is a first-class locale.** Not an afterthought, not a "nice-to-have", not "Phase 2".
- Locale toggle exists in:
  - Customer app: `lib/i18n.tsx`
  - Marketing site: `src/i18n/ui.ts`
- **RTL is real layout direction**, not just text alignment. Forms, navigation drawers, icons (back arrows!), and date pickers all flip.
- Every new screen / page / component:
  - Adds AR copy at the same time as EN copy (not in a follow-up PR)
  - Tests in both LTR and RTL viewports
  - Uses logical CSS properties (`margin-inline-start`, not `margin-left`) where the framework supports it

## Firebase region

- **Firestore**: `me-central2` (Dammam).
- **Cloud Functions** (dormant per [[functions-dormant]]): `region: 'me-central2'` in every function definition.
- **Vercel API routes** that hit Firestore: no region setting required (Vercel functions run in the user's region — be aware of round-trip latency to Dammam; co-locate hot reads with the user via Firestore client SDK where possible).

Captured in AgDR-0013 (iz13m/spotless). Cross-region triggers add ~200ms latency and create silent inconsistency windows — never override this regional choice for a single feature.

## Phone numbers & formats

- Default country code: `+20` (Egypt).
- Validation: accept `+20 10/11/12/15 XXXX XXXX` mobile patterns and `+20 2/3/...` landline patterns.
- Display: international format with spaces (`+20 10 1234 5678`).
- Twilio sender will be a `+20` number once provisioned — see [[pre-launch-placeholders]].

## Legal / compliance

- **Egypt Law No. 151/2020** (Personal Data Protection Law) governs the customer-app's data handling: consent, deletion, export. AgDRs around auth / data flows reference this.
- **App Store deletion** requirement (Apple's account-deletion rule) is also a live blocker, not future work.

## Dates, times, numbers

- Time zone: `Africa/Cairo` for display (UTC+2, no DST since 2014).
- Calendar: Gregorian for everything; Hijri date display is **not** part of the launch scope.
- Number formatting: Eastern Arabic numerals (`٠١٢٣...`) optional in AR locale, Western (`0123...`) elsewhere. Don't mix in the same screen.

## Anti-patterns

- ❌ Adding a feature that defaults to USD with "we'll fix the currency later"
- ❌ Marking AR translation as "Phase 2"
- ❌ Hard-coding `+1` country code in a phone-input component
- ❌ Putting a CF or Firestore listener in `us-central1` because "it's the default"
- ❌ Using `flex-direction: row` without checking RTL flip behaviour
