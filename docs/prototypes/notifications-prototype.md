# Notifications Prototype

## 1. Purpose
Provides a centralised list of app notifications, distinguished by read/unread state.

## 2. Entry Points
- Tapping **Alerts** in the M3 Navigation Bar.

## 3. Exit Points
- Tapping **Home** or **Profile** in the Navigation Bar.

## 4. Layout

```
┌────────────────────────────────────────┐
│  Notifications            ✓✓           │  ← M3 Top App Bar; "done_all" action icon
├────────────────────────────────────────┤
│  TODAY                                 │  ← Section label (primary, uppercase)
│  ┌──────────────────────────────────┐  │
│  │ 📦 Order Shipped            [●]  │  │  ← Unread (primary-container tint + dot)
│  │    Your order #12345…            │  │
│  │    2 hours ago                   │  │
│  └──────────────────────────────────┘  │
│  ┌──────────────────────────────────┐  │
│  │ 🏷 Flash Sale — 30% OFF!   [●]  │  │  ← Unread
│  │    Electronics are 30% off…      │  │
│  │    5 hours ago                   │  │
│  └──────────────────────────────────┘  │
│                                        │
│  YESTERDAY                             │  ← Section label
│  ┌──────────────────────────────────┐  │
│  │ 🎉 Welcome to Shop Ease          │  │  ← Read (surface-container-low, no dot)
│  │    Enjoy 10% off your first…     │  │
│  │    Yesterday                     │  │
│  └──────────────────────────────────┘  │
│                                        │
├────────────────────────────────────────┤
│  🏠 Home    🔔 Alerts    👤 Profile    │  ← M3 Navigation Bar (Alerts active)
└────────────────────────────────────────┘
```

## 5. Components
- **M3 Top App Bar** — Bold 24px title, trailing `done_all` icon button.
- **Section Labels** — Uppercase 11px/600, Electric Blue, spaced above groups.
- **Notification Item (Unread)** — `primary-container` background, bold title, coloured icon container, trailing unread dot.
- **Notification Item (Read)** — `surface-container-low` background, regular weight, primary-container icon container; no trailing dot.
- **Notification Icon** — 44×44px pill; unread uses inverted icon colours.
- **M3 Navigation Bar** — Alerts pill active.

## 6. Material Symbols
- App bar action: `done_all`
- Notification icons: `local_shipping`, `sell`, `celebration` (all FILL=1)
- Navigation: `home`, `notifications` (FILL=1 active), `person`

## 7. Typography
- Screen title: Inter 24px, weight 700
- Section label: Inter 11px, weight 600, uppercase, letter-spacing 1px
- Notification title (unread): Inter 14px, weight 600
- Notification title (read): Inter 14px, weight 500
- Notification body: Inter 13px, line-height 1.4
- Notification time: Inter 11px, on-surface-variant

## 8. User Interactions
- Scroll notification list.
- Tap a notification item → slight highlight press state (prototype only).
- `done_all` icon button → visual feedback only.

## 9. Loading State
- `m3-spinner` centred.
- No caption required (spinner implies loading).

## 10. Empty State
- `mark_email_read` icon (FILL=1) in circular container.
- Title: **All caught up!**
- Body: "You have no new notifications."

## 11. Error State
- `error_outline` icon (error colour) in circular container.
- Title: **Couldn't load notifications**
- Body: "Please check your connection and try again."
- Tonal button: **Retry**

## 12. Unread vs Read Differentiation
| Property | Unread | Read |
|---|---|---|
| Background | `primary-container` | `surface-container-low` |
| Title weight | 600 (Bold) | 500 (Medium) |
| Trailing dot | Visible (Electric Blue) | Hidden |
| Icon colours | Inverted (on-primary-container / primary-container) | primary-container / on-primary-container |

> Unread/read distinction is **not** colour-only — weight and trailing dot also differentiate.

## 13. Theme Behaviour
- **Light**: White-ish notification backgrounds; primary-container is light blue for unread.
- **Dark**: Dark surface-container-low for read; dark primary-container for unread.

## 14. Accessibility
- Unread items have `aria-label` including "(unread)" suffix.
- Dot is `aria-hidden="true"` (purely decorative; text weight conveys unread).

## 15. Prototype Acceptance Criteria
- [ ] Section date labels appear above notification groups.
- [ ] Unread items show primary-container background and trailing dot.
- [ ] Read items show neutral background, no dot.
- [ ] Loading / Empty / Error states toggle correctly via FAB.
- [ ] Navigation bar shows Alerts pill active.
