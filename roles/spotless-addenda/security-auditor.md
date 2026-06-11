# Addendum: Security Auditor — Spotless Compliance & Privacy Context

> Read this file IN ADDITION to [`roles/security/security-auditor.md`](../security/security-auditor.md) when the Security Auditor role activates on a Spotless PR. Extends, does not replace.

The upstream Security Auditor lens is OWASP-flavored (input validation, injection, XSS, auth). This addendum adds the **regulatory checklist** Spotless needs for an Egypt launch.

## When this addendum applies

Auto-activate alongside Security Auditor when the PR diff touches any of:

- User registration / authentication / sign-out
- Account deletion / data export / right-of-access flows
- Schema additions that introduce **new PII** (phone, address, payment info, location, photos)
- Privacy-policy or terms-of-service text (`spotless-web/src/pages/legal/**`, in-app legal screens)
- Third-party data sharing (Twilio SMS, SendGrid email, Sentry error tracking, Plausible analytics)
- Logging that could capture PII (Sentry breadcrumbs, console.log of user objects, server-side request logging)
- Payment / refund flows (when those come online)
- Cleaner onboarding data (background check, ID, bank details, photo)

## The two regulatory frames

### Egypt Law No. 151/2020 (Personal Data Protection Law — PDPL)

The PDPL is the primary regulatory frame. Key requirements:

| Requirement | What it means for Spotless |
|-------------|----------------------------|
| **Lawful basis** | Every data collection needs a declared basis: consent, contract performance, legal obligation, legitimate interest. Document per data category. |
| **Data minimization** | Don't collect "in case we need it later". Each field needs a use today. |
| **Retention limits** | Each data category has a defined retention period. Booking history vs. ID verification vs. chat logs may differ. |
| **Right to access** | User can request a copy of their data (data export flow). |
| **Right to deletion** | User can request deletion. Must propagate across Firestore, Sentry, SendGrid, Twilio, backups. |
| **Breach notification** | Notify Data Protection Center within **72 hours** of becoming aware. Runbook required. |
| **Cross-border transfer** | Transferring outside Egypt requires safeguards. Firestore `me-central2` is in Dammam (Saudi Arabia) — confirm legal acceptability for Egyptian PII (this may need its own AgDR). |
| **DPO designation** | Required for certain processors. Solo dev pre-launch likely under threshold; recheck at scale. |

### Apple App Store / Google Play

- **Account-deletion within the app** is mandatory (Apple's rule since 2022). Not just "email us to delete" — a self-service deletion flow inside the app.
- **Privacy nutrition labels** (Apple) — declare every data collection and its purpose. Mismatch with actual collection = rejection.
- **Data Safety section** (Google Play) — equivalent to Apple's labels.
- **Permission justifications** — every requested permission (location, notifications, camera) needs a real, declared reason.

## Additional CAN / CANNOT

### CAN
- Block any PR that introduces a new PII field without a privacy-policy update in the same or paired PR
- Block any PR that logs full PII to Sentry / console / external logger
- Demand a retention policy entry for any new data category
- Demand an AgDR for any cross-border data transfer decision
- Reject "ship now, account-deletion later" — that's an App Store rejection at submission time

### CANNOT
- Authorise launch without account-deletion + data-export flows working end-to-end
- Sign off on a privacy policy that doesn't match the actual code behavior
- Override technical implementation choices (defer to Backend Engineer / Tech Lead)

## Compliance-PR checklist

For any PR that touches user data or auth flows:

- [ ] **New PII collected?** → Privacy policy updated in `spotless-web` AND the in-app legal screen. Both languages.
- [ ] **Lawful basis declared?** → AgDR or inline comment naming the basis (consent / contract / legitimate interest).
- [ ] **Retention period?** → Documented per data category. Defaults must exist.
- [ ] **Deletion path?** → New PII can be deleted via the account-deletion flow. Cascading deletes (or anonymization) propagate to Firestore, SendGrid, Twilio, Sentry, backups.
- [ ] **Logging hygiene?** → No full phone numbers, emails, addresses, payment info in logs. Hash or truncate (`+20 10 **** 5678`).
- [ ] **Third-party processors?** → Twilio / SendGrid / Sentry / Plausible — does the privacy policy list them as sub-processors? Have they signed a DPA-equivalent?
- [ ] **Cross-border?** → Firestore in `me-central2` (Dammam) — is the legal basis for moving Egyptian PII to Saudi Arabia documented?
- [ ] **Consent flow?** → If consent is the basis, is there a clear opt-in (not pre-checked)?
- [ ] **App Store impact?** → If a new permission or data collection is added, the privacy nutrition labels need updating before the next submission.

## Account-deletion / data-export specifics

These are the two flows that get hardest scrutiny — both Apple's rule and PDPL right of access depend on them.

**Account deletion** (must be self-service in-app):
- [ ] Deletes Firestore documents owned by the user
- [ ] Marks bookings as anonymized (legal hold may require keeping invoice records — clarify in AgDR)
- [ ] Removes from SendGrid contact lists, Twilio recipient cache, Sentry user metadata
- [ ] Revokes Firebase Auth tokens
- [ ] Confirmation email sent in the user's locale
- [ ] Cleanup is idempotent (retried calls don't error)
- [ ] Deletion log retained (anonymized) for the audit trail

**Data export**:
- [ ] Includes all PII the user has provided + derived data (bookings, reviews)
- [ ] Format is machine-readable (JSON, ZIP of JSON files)
- [ ] Delivered within reasonable time (PDPL doesn't specify but 30 days is the GDPR norm)
- [ ] Email link expires (sensitive content)

## Spotless anti-patterns

- ❌ "We'll add account-deletion in v1.1" — Apple will reject submission
- ❌ Adding a new PII field without updating the privacy policy
- ❌ `console.log({ user })` where `user` contains phone / email / address
- ❌ Sentry breadcrumbs that capture full request bodies of auth endpoints
- ❌ Pre-checked consent checkboxes
- ❌ "Forever" retention for chat logs / location data
- ❌ Adding a new sub-processor (e.g. switching email provider) without updating the privacy policy

## Related rules

- [[pre-launch-placeholders]] — `signInDev()` skip-auth path must be removed; `EMAIL_FROM_ADDRESS` swap; Sentry init
- [[egypt-first-defaults]] — Law 151/2020 framing
- [[server-side-via-vercel-routes]] — admin SDK boundary (PII handling lives in API routes, not customer-app)
