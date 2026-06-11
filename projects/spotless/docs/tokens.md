# Spotless Design Tokens

Single source of truth for visual primitives shared across the customer mobile app (Expo / React Native) and the ops dashboard (Next.js / Tailwind v4). Edit here first, then mirror the change in each implementation file:

- Mobile: `lib/theme/tokens.ts` (typed TS object, consumed by `StyleSheet.create`)
- Ops: `src/app/globals.css` (`@theme` block, exposes tokens as CSS custom properties Tailwind v4 picks up)

The marketing site (`spotless-web`) is intentionally **not** covered here — it's a separate Astro codebase with its own visual language. If we ever unify, this spec is the basis.

## Provenance

Built from the 2026-05-20 UI/UX audit. The canonical brand purple `#5b3fc4` is taken from the mobile app where it appears 171+ times. Ops currently uses Tailwind's `violet-600` (`#7c3aed`) which has drifted from brand — Phase 1 aligns it.

Status-color pairs (light bg + dark fg) are taken from booking-status badges in `app/booking-detail/[id].tsx` on mobile, which the audit found to be the most considered status palette in either app.

---

## Color

### Brand — Purple ramp

| Token | Hex | Use |
|-------|-----|-----|
| `purple.50`  | `#f5f1fd` | Tinted page backgrounds (replaces `#f9f7ff`, `#faf8ff`) |
| `purple.100` | `#ede8fb` | Soft tints, banner backgrounds |
| `purple.200` | `#dccef5` | Subtle borders on tinted cards |
| `purple.300` | `#c4b5fd` | Inactive toggle thumb |
| `purple.400` | `#a78bfa` | Hover-on-tint |
| `purple.500` | `#8b5cf6` | Secondary fill |
| `purple.600` | `#5b3fc4` | **Primary brand. Buttons, links, active tab.** |
| `purple.700` | `#4c33a8` | Hover for primary |
| `purple.800` | `#3d2786` | Pressed for primary |
| `purple.900` | `#291862` | Dark text on purple tint backgrounds |

### Neutrals — Gray ramp

| Token | Hex | Use |
|-------|-----|-----|
| `gray.0`   | `#ffffff` | Card surface |
| `gray.50`  | `#fafafa` | Page background (replaces inconsistent `#f5f5f5`) |
| `gray.100` | `#f4f4f5` | Hover surface, disabled fill |
| `gray.200` | `#e4e4e7` | Default border (replaces drift `#eee`, `#f0f0f0`, `#ddd`) |
| `gray.300` | `#d4d4d8` | Strong border |
| `gray.400` | `#a1a1aa` | Placeholder, disabled icon (replaces `#aaa`) |
| `gray.500` | `#71717a` | Secondary text (replaces `#888`) |
| `gray.600` | `#52525b` | Body text dim (replaces `#555`) |
| `gray.700` | `#3f3f46` | Body text |
| `gray.800` | `#27272a` | Strong text |
| `gray.900` | `#18181b` | Headings (replaces `#111`) |

### Semantic — Status pairs

Each is `{bg, fg}` — bg goes on the badge / banner background, fg goes on the text or icon inside it.

| Token | Bg | Fg | Use |
|-------|----|----|-----|
| `status.scheduled` | `#e3f2fd` | `#1565c0` | Booking scheduled, info banner |
| `status.in_progress` | `#fff3e0` | `#e65100` | Cleaner en route, in-flight action |
| `status.success` | `#e8f5e9` | `#2e7d32` | Completed, success banner, "applied" |
| `status.danger` | `#ffebee` | `#c62828` | Cancelled, error banner, destructive confirm |
| `status.warning` | `#fff7ed` | `#b45309` | Estimator nudge, low-stock, late-cancel |
| `status.neutral` | `#f4f4f5` | `#52525b` | Pending, draft, "no data" |

Solo accent (not paired):

| Token | Hex | Use |
|-------|-----|-----|
| `accent.success` | `#16a34a` | Inline success text ("coupon applied") |
| `accent.danger` | `#dc2626` | Inline destructive text ("delete"), required-field asterisk |
| `accent.warning` | `#b45309` | Inline warning text |

---

## Spacing

8-pt-based scale. Use these tokens, not magic numbers.

| Token | Value | Use |
|-------|-------|-----|
| `space.0` | 0 | |
| `space.1` | 4 | Tight icon padding |
| `space.2` | 8 | Compact gaps |
| `space.3` | 12 | Default field padding |
| `space.4` | 16 | Section gap inside a card |
| `space.5` | 20 | Page horizontal padding (mobile) |
| `space.6` | 24 | Section spacing |
| `space.7` | 32 | Large-block spacing |
| `space.8` | 40 | Page vertical rhythm |
| `space.9` | 48 | Hero spacing |

---

## Radius

| Token | Value | Use |
|-------|-------|-----|
| `radius.sm` | 6 | Pills, small chips |
| `radius.md` | 10 | Buttons, inputs |
| `radius.lg` | 14 | Cards |
| `radius.xl` | 20 | Modals, large containers |
| `radius.full` | 9999 | Circles, avatar |

---

## Typography

Scale below is unit-agnostic — mobile reads it as `px` (RN font-size), ops reads it as `rem` (1rem = 16px) via the `@theme` mapping.

| Token | Mobile (px) | Ops (rem) | Use |
|-------|-------------|-----------|-----|
| `text.xs`   | 11 | 0.6875 | Captions, badge labels |
| `text.sm`   | 13 | 0.8125 | Secondary text, table cells |
| `text.base` | 15 | 0.9375 | Body |
| `text.lg`   | 17 | 1.0625 | Subheading, button labels |
| `text.xl`   | 20 | 1.25   | Section heading |
| `text.2xl`  | 24 | 1.5    | Page heading |
| `text.3xl`  | 30 | 1.875  | Hero (mobile rare, ops dashboard cards) |

Weights:

| Token | Value | Use |
|-------|-------|-----|
| `weight.regular`  | 400 | Body |
| `weight.medium`   | 500 | Labels, table headers |
| `weight.semibold` | 600 | Subheads, button text |
| `weight.bold`     | 700 | Page headings, totals |

Line height: default to `1.4 * fontSize` for body, `1.25 * fontSize` for headings. Don't hard-code line heights as raw numbers — derive from font size.

---

## Elevation / shadow

Mobile uses RN `shadow*` props; ops uses Tailwind's `shadow-*` utilities. Token names align.

| Token | Mobile | Ops (Tailwind) |
|-------|--------|----------------|
| `elevation.0` | none | `shadow-none` |
| `elevation.1` | `{ shadowOpacity: 0.04, shadowRadius: 4, shadowOffset: { width: 0, height: 1 } }` | `shadow-sm` |
| `elevation.2` | `{ shadowOpacity: 0.06, shadowRadius: 10, shadowOffset: { width: 0, height: 4 } }` | `shadow` |
| `elevation.3` | `{ shadowOpacity: 0.10, shadowRadius: 16, shadowOffset: { width: 0, height: 8 } }` | `shadow-lg` |

---

## Motion

Mobile uses `react-native-reanimated` (not yet adopted) / `Animated`; ops uses CSS transitions. Token names align.

| Token | Value | Use |
|-------|-------|-----|
| `duration.fast`   | 120 ms | Hover, press feedback |
| `duration.normal` | 200 ms | Page-element fade, banner slide |
| `duration.slow`   | 320 ms | Modal in/out, drawer |
| `easing.standard` | `cubic-bezier(0.4, 0, 0.2, 1)` | Default |
| `easing.exit`     | `cubic-bezier(0.4, 0, 1, 1)` | Element leaving the screen |

---

## What this spec does NOT cover

- **Iconography** — both apps use `@expo/vector-icons` (Ionicons on mobile) / various on ops. A dedicated icon-set decision is out of scope; document it separately if it ever drifts.
- **Illustration / imagery** — TBD when the marketing site visual language stabilises.
- **Dark mode** — Phase 3 work. The ramps above are designed so a dark-mode mirror is straightforward (swap gray scale, dim purple by 1 step).
- **Per-locale type** — Arabic uses the same scale; a future Arabic-specific font choice would extend `weight` and possibly add an `arabic` family token.
