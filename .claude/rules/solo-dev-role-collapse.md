# Solo-Dev Role Collapse

**This rule modifies how `role-triggers.md` applies to the Spotless portfolio.**

The Spotless portfolio is operated by **one human** (iz13m). The 19 role files in `roles/` describe lenses — perspectives, checklists, quality bars — but **all roles collapse to the same person**. There is no team queue, no handoff delay, no second pair of eyes.

## What this rule does

- **Keep the lens, drop the queue.** When a role activates (e.g. Security Auditor on an auth PR), adopt the role's checklist and quality bar. Do NOT propose "wait for the Security Auditor to review" or "hand off to QA" — there is no second person.
- **Skip multi-person handoff artefacts.** Templates that exist to communicate *between* people (formal PRD review meetings, design-review sign-off ceremonies, QA acceptance hand-offs) compress to a self-check pass. Still verify the criteria; skip the ceremony.
- **Do not propose adding people.** Never propose hiring, contracting, or "getting a designer to review". When a CANNOT in a role file requires another role's approval, the same person changes hat and grants it.

## What this rule does NOT change

- **The two-marker merge gate still applies.** `block-unreviewed-merge.sh` requires both `<pr>-rex.approved` and `<pr>-ceo.approved` for every merge. The "CEO" is iz13m. The `/approve-merge <pr>` step is the only thing standing between Claude and an accidental autonomous merge — never bypass it because "there's no separate CEO".
- **QA verification still happens.** Merged PRs still move to a QA mindset before being called Done. The user wears the QA hat themselves and walks the acceptance criteria.
- **AgDRs still get written.** Decisions still get recorded — there's no team to consult, but future-you and Claude in future sessions are the audience.

## Activation pattern

When a role activates per `role-triggers.md`:

1. Read the role file
2. Adopt its checklist, CAN/CANNOT, quality bar
3. Walk through the relevant artefacts (test plan, security checklist, design review)
4. **Self-sign.** No waiting, no handoff.
5. Move on or activate the next role lens.

## Why

Captured in [[project-spotless-overview]] memory — "solo dev" is a deliberate architectural choice, not a temporary state to grow out of. The apexyard role framework was designed for teams; running it as-written would either freeze the solo dev (waiting for non-existent reviewers) or make Claude propose hiring, which is noise.

## Anti-patterns

- ❌ "Let's get a Security Auditor to review this before merge."
- ❌ "QA Engineer will verify the acceptance criteria after deploy."
- ❌ "Hand this off to a designer for design review."
- ✅ "I'll put on the Security Auditor hat — checklist: input validation, no secrets in logs, auth on the route, rate limit. All good."
- ✅ "QA pass: walked AC1 (book a slot), AC2 (cancel within 24h), AC3 (refund flow). All pass."
