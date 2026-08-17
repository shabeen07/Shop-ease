# Settings Prototype

## 1. Purpose
Provides application-level preferences: theme selection, notification toggles, and app information.

## 2. Entry Points
- Tapping **Settings** in the Profile screen's settings group.

## 3. Exit Points
- Back button → Profile screen.

## 4. Layout

```
┌────────────────────────────────────────┐
│  ←  Settings                           │  ← M3 Top App Bar with back arrow
├────────────────────────────────────────┤
│                                        │
│  APPEARANCE                            │  ← Section header (Electric Blue)
│  ┌──────────────────────────────────┐  │
│  │ 🎨 Theme            System  ›    │  │  ← Opens M3 Bottom Sheet
│  │ 🅰  Text Size        Default ›    │  │
│  └──────────────────────────────────┘  │
│                                        │
│  NOTIFICATIONS                         │
│  ┌──────────────────────────────────┐  │
│  │ 🔔 Push Notifications   [  ON ] │  │  ← M3 Switch (checked)
│  │ 📣 Promotions           [ OFF ] │  │  ← M3 Switch (unchecked)
│  └──────────────────────────────────┘  │
│                                        │
│  ABOUT                                 │
│  ┌──────────────────────────────────┐  │
│  │ ℹ  App Version          1.0.0    │  │
│  │ 🔒 Privacy Policy           ›    │  │
│  │ ⚖  Terms of Use             ›    │  │
│  └──────────────────────────────────┘  │
│                                        │
└────────────────────────────────────────┘
```

### Theme Bottom Sheet (Modal)

```
┌────────────────────────────────────────┐
│  ▬▬▬  (drag handle)                    │
│  Choose Theme                          │
│                                        │
│  ○  ✨ System default                  │
│  ○  ☀  Light                           │
│  ○  🌙 Dark                            │
│                                        │
│  [ Close ]                             │
└────────────────────────────────────────┘
```

## 5. Components
- **M3 Top App Bar** — `arrow_back` icon button, "Settings" title.
- **Section Header** — Uppercase 11px/600, Electric Blue.
- **Settings Group Card** — Rounded card (`surface-container-low`, 16px radius); items separated by 1px dividers.
- **Settings Item (Chevron)** — 36×36px square icon container (primary-container), label, optional value text, `chevron_right`.
- **Settings Item (Switch)** — 36×36px icon container, label, M3 Switch (right-aligned).
- **Settings Item (Value)** — 36×36px icon container, label, trailing value text (no chevron for read-only).
- **M3 Switch** — Pill track with animated thumb; Electric Blue when ON; outline + grey thumb when OFF.
- **Theme Bottom Sheet** — M3 modal bottom sheet (rounded top corners, drag handle, sheet-up animation); radio options with descriptive icons.

## 6. Material Symbols
- Appearance: `palette`, `text_fields`
- Notifications: `notifications_active`, `campaign`
- About: `info`, `shield`, `gavel`
- Theme sheet: `brightness_auto`, `light_mode`, `dark_mode`
- Back: `arrow_back`
- Trailing: `chevron_right`

## 7. Typography
- Screen title: Inter 22px, weight 400 (M3 top app bar default)
- Section header: Inter 11px, weight 600, uppercase
- Item label: Inter 14px, weight 500
- Item value: Inter 13px, on-surface-variant
- Sheet title: Inter 18px, weight 700

## 8. Theme Bottom Sheet Interaction
```
Tap Theme row
    ↓
Bottom sheet slides up (sheetUp animation)
    ↓
Select radio option → setTheme() updates data-theme attribute + label
    ↓
Tap Close → sheet dismisses
```

Tapping the overlay backdrop also closes the sheet.

## 9. M3 Switch Behaviour
- Toggle switches are interactive in the prototype.
- ON state: Electric Blue track, white thumb.
- OFF state: Outline track, grey thumb.
- Animated thumb transition using `cubic-bezier(.2,0,0,1.4)`.

## 10. Loading State
- `m3-spinner` centred in content area.

## 11. Error State
- `error_outline` icon (error colour) in circular container.
- Title: **Couldn't load settings**
- Tonal button: **Retry**

## 12. Theme Behaviour
- **Light**: Light background, white-ish group cards.
- **Dark**: Dark background, dark group cards (surface-container).
- Theme Bottom Sheet updates the entire prototype instantly.

## 13. Accessibility
- Each switch has an `aria-label` describing the setting.
- Switch has `aria-checked` reflecting its state.
- Bottom sheet has `role="dialog"` with `aria-labelledby`.

## 14. Prototype Acceptance Criteria
- [ ] All three groups (Appearance, Notifications, About) render with correct icons.
- [ ] Tapping Theme row opens bottom sheet.
- [ ] Selecting System / Light / Dark updates the prototype theme instantly.
- [ ] Push Notifications switch toggles ON/OFF visually.
- [ ] Promotions switch toggles ON/OFF visually.
- [ ] Loading / Error states toggle correctly via FAB.
