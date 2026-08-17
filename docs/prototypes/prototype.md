# Prototype Documentation

## 1. Prototype Purpose
The HTML prototype (`docs/prototype.html`) serves as a design validation artifact prior to Flutter implementation.
It ensures that navigation flows, screen layouts, user interactions, component styles, and all screen states are visually agreed upon before development begins.

## 2. Scope
This prototype covers the full authenticated shell and all primary screens for the Shop Ease application.

## 3. Design System Reference

| Token | Value |
|---|---|
| Primary Color | Electric Blue `#2563EB` (Light) / `#ADC6FF` (Dark) |
| Design Language | Material 3 (M3 Expressive) |
| Typography | Inter (400/500/600/700/800) + Noto Sans |
| Icon Set | Material Symbols Rounded (variable font) |
| Shape Scale | xs=8px, sm=12px, md=16px, lg=24px, xl=28px, full=9999px |

## 4. M3 Color Token Architecture
The prototype uses the full Material 3 semantic color role system via CSS custom properties:

```text
Light roles                         Dark roles
──────────────────────────────────  ──────────────────────────────────
--md-sys-color-primary: #2563EB     --md-sys-color-primary: #ADC6FF
--md-sys-color-primary-container    --md-sys-color-primary-container
--md-sys-color-surface-container-*  --md-sys-color-surface-container-*
--md-sys-color-on-surface           --md-sys-color-on-surface
--md-sys-color-outline-variant      --md-sys-color-outline-variant
--md-sys-color-error                --md-sys-color-error
```

No hard-coded colour values are used outside of CSS variable declarations.

## 5. Typography System
All text uses the **Inter** typeface loaded from Google Fonts. Noto Sans is the fallback.

| Role | Size | Weight | Usage |
|---|---|---|---|
| Display | 32px | 800 | App name in Login hero |
| H1 | 24px | 700 | Screen titles |
| H2 | 22px | 700 | Product name in Detail |
| Body Large | 16px | 400 | Form inputs |
| Body | 14px | 500 | List item labels |
| Body Small | 13px | 400 | Subtitles, captions |
| Caption | 11px | 600 | Section headers, badges |
| Button | 14-16px | 600 | Button labels |

## 6. Icon System
Icons use **Material Symbols Rounded**, a variable font loaded from Google Fonts.

```html
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
```

Icons use CSS variation settings:
- `FILL=0` (outline) by default.
- `FILL=1` (filled) for active navigation items and hero icons.
- Class `.icon-fill` applies `FILL=1`.

## 7. Screens Covered

| ID | Screen | File reference |
|---|---|---|
| `screen-login` | Login | `login-prototype.md` |
| `screen-home` | Home / Products | `home-prototype.md` |
| `screen-detail` | Product Detail | `product-detail-prototype.md` |
| `screen-notifications` | Notifications | `notifications-prototype.md` |
| `screen-profile` | Profile | `profile-prototype.md` |
| `screen-settings` | Settings | `settings-prototype.md` |
| `screen-edit-profile` | Edit Profile | `edit-profile-prototype.md` |

## 8. Navigation Flow

```text
Login
  ↓ (success)
Home ──────────────────────────────────────────────┐
  ├── Tap product card → Product Detail → Back → Home
  ├── Nav: Alerts → Notifications → Back
  └── Nav: Profile
              ├── Edit Profile (Coming Soon) → Back
              ├── Settings
              │       └── Theme → Bottom Sheet (System/Light/Dark)
              └── Log Out → Dialog → Confirm → Login
```

## 9. Interaction Requirements
All interactive elements demonstrate:
- Default state
- Hover state (on desktop)
- Pressed/Active state (scale transform)
- Disabled state (opacity 38%)
- Loading state (spinner)
- Error state (error-container + message)

## 10. Screen States
Each state-bearing screen implements four states, toggled via the **Prototype Debug FAB** (bottom-right floating button):

| State | Description |
|---|---|
| Loading | `m3-spinner` (48px M3 circular indicator) centered in content area |
| Success | Content view with real data |
| Empty | Icon + title + body + optional action |
| Error | Error icon + title + body + Retry button |

Navigating to a state-bearing screen automatically triggers the Loading → Success transition (900ms simulated delay).

## 11. Light / Dark / System Themes
```text
Toggle via Settings → Theme → Bottom Sheet:
  ● System default  → respects OS prefers-color-scheme
  ○ Light           → forces light M3 tokens
  ○ Dark            → forces dark M3 tokens
```
Theme changes apply instantly to the entire prototype.

## 12. Motion & Animation

| Name | Duration | Easing |
|---|---|---|
| Screen enter | 350ms | `cubic-bezier(.2,0,0,1.4)` (M3 Emphasized) |
| Icon button press | 200ms | `cubic-bezier(.2,0,0,1)` (M3 Standard) |
| Card press | 200ms | scale(.97) |
| Bottom Sheet | 350ms | `cubic-bezier(.2,0,0,1.4)` slide-up |
| Dialog | 350ms | `cubic-bezier(.2,0,0,1.4)` scale-in |
| Error banner | 200ms | slide-down fade-in |

## 13. Responsive Behaviour
- Portrait phone layout: 393×852px simulated frame.
- `@media (min-width: 600px)`: frame displayed centered with rounded border.
- No fixed widths inside the frame — all layouts use flex/grid.

## 14. Accessibility Requirements
- Semantic HTML (`<nav>`, `<button>`, `<main>`).
- `aria-label` on all icon-only buttons.
- `role="alert"` on error banners.
- `role="dialog"` on modals.
- `aria-checked` on switches.
- Focus rings visible (browser default, not overridden).
- Text + icon (never colour alone) for state differentiation.

## 15. Prototype Acceptance Criteria
- [ ] All 7 screens implemented and navigable.
- [ ] Light, Dark, System themes work correctly.
- [ ] M3 Navigation Bar pill animates on active item.
- [ ] Login: validation, loading, success, and error flows work.
- [ ] Home: Loading / Success / Empty / Error states work.
- [ ] Product Detail: Loading / Success / Not Found / Error work.
- [ ] Notifications: Unread/read styling, Loading / Empty / Error work.
- [ ] Profile: gradient hero, settings group, logout dialog work.
- [ ] Settings: theme bottom sheet and switches interactive.
- [ ] Edit Profile: Coming Soon state displayed, navigation returns to Profile.
- [ ] Prototype debug FAB available on all state-bearing screens.
