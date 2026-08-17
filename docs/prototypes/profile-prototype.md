# Profile Prototype

## 1. Purpose
Displays the authenticated user's account information and provides access to account-level actions (Edit Profile, Settings, Logout).

## 2. Entry Points
- Tapping **Profile** in the M3 Navigation Bar.

## 3. Exit Points
- **Edit Profile** → Edit Profile screen.
- **Settings** → Settings screen.
- **Log Out** → Logout confirmation dialog → Login screen.

## 4. Layout

```
┌────────────────────────────────────────┐
│  ┌──────────────────────────────────┐  │
│  │  (Gradient hero: Blue → Indigo)  │  │  ← Profile Hero (no app bar)
│  │           ◯                      │  │
│  │         Avatar (JD)              │  │
│  │         John Doe                 │  │
│  │      john.doe@example.com        │  │
│  │       [ Edit Profile ]           │  │  ← Frosted-glass pill button
│  └──────────────────────────────────┘  │
│                                        │
│  ACCOUNT                               │  ← Section header (Electric Blue)
│  ┌──────────────────────────────────┐  │
│  │ 🖊  Edit Profile          ›      │  │  ← Settings group card
│  │ ⚙   Settings              ›      │
│  │ ❓  Help & Support         ›      │
│  └──────────────────────────────────┘  │
│                                        │
│  SESSION                               │  ← Section header (Error colour)
│  ┌──────────────────────────────────┐  │
│  │ 🚪  Log Out                      │  │  ← Error-coloured icon + label
│  └──────────────────────────────────┘  │
│                                        │
├────────────────────────────────────────┤
│  🏠 Home    🔔 Alerts    👤 Profile    │  ← M3 Navigation Bar (Profile active)
└────────────────────────────────────────┘
```

## 5. Components
- **Profile Hero** — Gradient background (Electric Blue → Indigo); glassmorphism avatar (88×88px, frosted border, JD initials); full name; email; frosted-glass pill **Edit Profile** button.
- **Section Header** — Uppercase 11px/600; Electric Blue for Account, Error colour for Session.
- **Settings Group** — Rounded card container (`surface-container-low`); items separated by 1px dividers.
- **Settings Item** — Leading 36×36px square icon (primary-container background); label; trailing `chevron_right`.
- **Log Out Item** — Leading icon container with error-container background and error-colour icon; error-colour label and weight 600.
- **M3 Navigation Bar** — Profile pill active.

## 6. Material Symbols
- Avatar: text initials (no icon)
- Account items: `edit`, `settings`, `help_outline`
- Logout item: `logout`
- Navigation: `home`, `notifications`, `person` (FILL=1 when active)
- Trailing: `chevron_right`

## 7. Typography
- Full name: Inter 20px, weight 700, white
- Email: Inter 13px, white 80% opacity
- Edit Profile hero button: Inter 13px, weight 600, white
- Section header: Inter 11px, weight 600, uppercase, letter-spacing 1px
- Item label: Inter 14px, weight 500
- Logout label: Inter 14px, weight 600, error colour

## 8. Logout Flow

```
Tap Log Out
    ↓
M3 Dialog appears (scale-in animation)
    ├── [Cancel] → dismiss dialog
    └── [Log out] → clear session → navigate to Login
```

## 9. Logout Dialog
- Icon: `logout` in error-container circle.
- Title: **Log out?**
- Body: "Are you sure you want to log out of your account?"
- Actions: **Cancel** (outlined) | **Log out** (error filled).

## 10. Loading State
- `m3-spinner` centred in scrollable content area.

## 11. Error State
- `error_outline` icon (error colour) in circular container.
- Title: **Couldn't load profile**
- Body: "We couldn't load your profile information."
- Tonal button: **Retry**

## 12. Theme Behaviour
- **Light**: Hero gradient unchanged; content area uses light surface tokens.
- **Dark**: Hero gradient unchanged (always vivid); content area uses dark surface tokens.
- Avatar background: `rgba(255,255,255,0.2)` — always readable against gradient.

## 13. Accessibility
- Avatar has `aria-label="Profile picture: John Doe"`.
- Log Out button has `role="button"` and accessible name.
- Dialog has `role="dialog"` with `aria-labelledby` pointing to the dialog title.

## 14. Prototype Acceptance Criteria
- [ ] Gradient hero renders with avatar, name and email.
- [ ] Settings group shows Edit Profile, Settings, Help items with correct icons.
- [ ] Session group shows Log Out with error-colour styling.
- [ ] Tapping Log Out opens dialog.
- [ ] Dialog Cancel dismisses; Log Out navigates to Login.
- [ ] Loading / Error states toggle correctly via FAB.
- [ ] Navigation bar shows Profile pill active.
