# Design Document

**Project:** Flutter Spec-Driven Development Project  
**Version:** 1.0  
**Platform:** Flutter / Dart  
**Architecture:** Clean Architecture + BLoC  
**Primary Color:** Electric Blue  
**Design System:** Latest Flutter Material 3  
**Theme Modes:** Light / Dark / System

---

## 1. Purpose

This document defines the visual design system and user experience requirements for the Flutter application.

The design must remain consistent with the approved Task, Architecture, Navigation and Feature Specification documents.

The approved feature set is:

```text
Login
Home / Products
Product Detail
Profile
Settings
Notifications
```

The design establishes:

- Visual identity.
- Color system.
- Material 3 theme architecture.
- Typography.
- Spacing.
- Component styling.
- Screen layouts.
- Navigation UI.
- User interactions.
- Loading, empty and error states.
- Accessibility.
- Responsive behavior.
- HTML prototype requirements.

The existing design direction remains modern, clean, professional, simple and accessible, with Electric Blue as the primary visual accent. fileciteturn5file4L640-L688

---

## 2. Design Direction

The application should use a **modern, clean and professional mobile UI**.

Visual priorities:

- Clarity.
- Simplicity.
- Strong visual hierarchy.
- Consistent spacing.
- Clear interaction feedback.
- Accessible contrast.
- Minimal visual clutter.

Electric Blue should primarily communicate:

- Primary actions.
- Active navigation.
- Selected controls.
- Links.
- Focus states.
- Progress indicators.
- Important interactive elements.

It should not dominate large content areas unnecessarily. fileciteturn5file4L662-L688

---

## 3. Material 3 Design System

The application must use the latest Flutter Material 3 design approach.

`ThemeData` is the global styling mechanism and should define:

- `ColorScheme`.
- Typography.
- Input decoration.
- Buttons.
- Cards.
- App bars.
- Dialogs.
- Progress indicators.
- Navigation components.

The existing design specifies `ColorScheme.fromSeed` using Electric Blue as the seed. fileciteturn5file6L986-L1011

### 3.1 Material 3 Theme Principle

The UI should consume semantic Material 3 color roles rather than hard-coded colors:

```text
ColorScheme
├── primary
├── onPrimary
├── primaryContainer
├── onPrimaryContainer
├── secondary
├── surface
├── surfaceContainer
├── onSurface
├── outline
├── error
└── onError
```

Feature widgets should obtain colors from the active theme.

```dart
final colors = Theme.of(context).colorScheme;
```

Do not directly use raw color constants inside feature widgets.

---

# 4. Color System

## 4.1 Primary — Electric Blue

Recommended base:

```text
#2563EB
```

Flutter representation:

```dart
const electricBlue = Color(0xFF2563EB);
```

The exact shade may be adjusted during visual validation, but Electric Blue remains the primary brand/action color. fileciteturn5file2L380-L388

### 4.2 Electric Blue Usage

| UI             | Usage                       |
| -------------- | --------------------------- |
| Primary action | Primary button              |
| Navigation     | Active destination          |
| Form           | Focus indicator             |
| Selection      | Selected controls           |
| Links          | Interactive links           |
| Progress       | Progress indicators         |
| Icons          | Primary action/accent icons |

These usages are already defined by the existing design system. fileciteturn5file2L390-L400

---

## 4.3 Supporting Palette

The supporting palette should remain neutral so Electric Blue remains the dominant accent.

Current recommendations:

| Token           | Value     | Usage                    |
| --------------- | --------- | ------------------------ |
| Background      | `#FFFFFF` | Main light background    |
| Surface         | `#F8FAFC` | Cards/secondary surfaces |
| Surface Variant | `#F1F5F9` | Inputs/subtle surfaces   |
| Text Primary    | `#0F172A` | Main text                |
| Text Secondary  | `#475569` | Supporting text          |
| Text Disabled   | `#94A3B8` | Disabled text            |
| Border          | `#CBD5E1` | Borders/dividers         |
| Success         | `#16A34A` | Success                  |
| Warning         | `#D97706` | Warning                  |
| Error           | `#DC2626` | Error                    |

These are implementation recommendations and remain subject to prototype validation. fileciteturn5file2L402-L421

---

# 5. Light and Dark Themes

The application supports:

```text
System
Light
Dark
```

Default:

```text
System
```

## 5.1 System

When System is selected:

```text
OS Light → Light Theme
OS Dark  → Dark Theme
```

## 5.2 Light

The light theme should prioritize:

- White/light neutral background.
- High-contrast dark text.
- Neutral surfaces.
- Electric Blue primary actions.
- Subtle borders/elevation.

## 5.3 Dark

The dark theme should prioritize:

- Dark neutral background.
- Dark Material 3 surface roles.
- Light text.
- Electric Blue as the primary accent.
- Avoiding excessively bright large surfaces.

Electric Blue must remain readable in both themes.

### 5.4 Theme Architecture

```text
Settings
   ↓
Theme Preference
   ↓
App Theme
   ↓
MaterialApp.router
   ↓
All Screens
```

Theme changes should apply without application restart.

Theme preference persistence belongs to Settings/data infrastructure, not individual screens.

---

# 6. Typography

The approved typeface is **Inter** (Google Fonts). Noto Sans is the fallback.

Inter must be registered in the Flutter project as a custom font via `pubspec.yaml` and set as the `fontFamily` on `ThemeData`.

Approved type scale (validated in `docs/prototype.html`):

| Style      |  Size | Weight | Usage                                    |
| ---------- | ----: | ------ | ---------------------------------------- |
| Display    |    32 | 800    | App name / Login hero                    |
| H1         |    24 | 700    | Screen titles (Home, Notifications)      |
| H2         |    22 | 700    | Product name in Detail                   |
| H3         |    20 | 600    | Section headings                         |
| Body Large |    16 | 400    | Form inputs, important content           |
| Body       |    14 | 500    | List tile labels, standard content       |
| Body Small |    13 | 400    | Subtitles, notification body             |
| Button     | 14–16 | 600    | Button labels                            |
| Caption    |    11 | 600    | Section headers, badge chips, timestamps |

Flutter implementation must consume:

```dart
Theme.of(context).textTheme
```

rather than creating independent text styles inside screens.

---

# 7. Spacing

Use a consistent 4-point spacing system:

```text
4   xs
8   sm
12  md
16  lg
24  xl
32  2xl
40  3xl
48  4xl
```

The spacing system should remain consistent across all screens. fileciteturn5file5L782-L808

---

# 8. Border Radius

Recommended:

```text
Small components → 8
Cards            → 12
Inputs           → 10
Buttons          → 10
Large containers → 16
```

Avoid introducing unnecessary radius values. fileciteturn5file5L812-L826

---

# 9. Elevation and Surfaces

Use subtle Material 3 elevation.

Guidelines:

- Flat surfaces by default.
- Light elevation where separation is needed.
- Avoid heavy shadows.
- Use surface contrast and borders where appropriate.

This follows the existing design direction. fileciteturn5file5L830-L841

---

# 10. Shared Components

Potential shared components:

```text
PrimaryButton
SecondaryButton
AppTextField
LoadingView
ErrorView
EmptyView
ProductCard
SectionHeader
SettingsTile
ProfileHeader
NotificationItem
```

A component should be shared only when it has a genuine reusable responsibility.

Feature-specific components remain inside their feature until reuse is justified. fileciteturn5file3L514-L527

---

# 11. Login Screen

## 11.1 Layout

```text
┌────────────────────────────────┐
│                                │
│             LOGO               │
│                                │
│       Welcome / Sign in        │
│                                │
│   Username                     │
│   ┌────────────────────────┐   │
│   │                        │   │
│   └────────────────────────┘   │
│                                │
│   Password                     │
│   ┌────────────────────────┐   │
│   │                        │   │
│   └────────────────────────┘   │
│                                │
│   ┌────────────────────────┐   │
│   │          LOGIN         │   │
│   └────────────────────────┘   │
│                                │
└────────────────────────────────┘
```

This retains the existing approved Login structure. fileciteturn5file7L1104-L1138

## 11.2 Interaction

```text
Tap Login
   ↓
Validate
   ↓
Invalid → Inline validation
   ↓
Valid
   ↓
Loading
   ↓
API
   ├── Failure → Error
   └── Success → Home
```

---

# 12. Authenticated Application Shell

All authenticated screens should share a consistent application shell.

Primary destinations:

```text
Home
Notifications
Profile
```

Settings is a secondary destination accessed from Profile.

## 12.1 Compact Navigation

Recommended Material 3 navigation pattern:

```text
┌──────────────────────────────┐
│                              │
│       Screen Content         │
│                              │
├──────────────────────────────┤
│  Home   Notifications Profile│
└──────────────────────────────┘
```

Use a Material 3 `NavigationBar` for compact layouts.

## 12.2 Larger Layouts

A Material 3 `NavigationRail` may be used when the available width supports it:

```text
┌──────┬───────────────────────┐
│ Home │                       │
│ Bell │    Screen Content     │
│ User │                       │
│      │                       │
└──────┴───────────────────────┘
```

The final breakpoint and exact navigation treatment must be validated in the HTML prototype.

---

# 13. Home Screen

## 13.1 Purpose

Home displays the Product resource selected for the application.

The assignment supports a Products/Recipes resource choice; the current project scope has selected **Products**.

## 13.2 Layout

```text
┌────────────────────────────────┐
│ Products                  🔔 👤│
├────────────────────────────────┤
│                                │
│ Search / optional filter       │
│                                │
│ ┌────────────────────────────┐ │
│ │ Product Image              │ │
│ │                            │ │
│ │ Product Name               │ │
│ │ Category                   │ │
│ │ ★ Rating      $ Price      │ │
│ └────────────────────────────┘ │
│                                │
│ ┌────────────────────────────┐ │
│ │ Product Image              │ │
│ │                            │ │
│ │ Product Name               │ │
│ │ Category                   │ │
│ │ ★ Rating      $ Price      │ │
│ └────────────────────────────┘ │
│                                │
├────────────────────────────────┤
│ Home Notifications Profile     │
└────────────────────────────────┘
```

The existing design requires clear card hierarchy and sufficient spacing for scanning. fileciteturn5file7L1166-L1206

## 13.3 Product Card

Each card should prioritize:

1. Product image.
2. Product title.
3. Category.
4. Price.
5. Rating.
6. Optional discount/stock indicator.

The card should be tappable.

```text
Tap Product
    ↓
Product Detail
```

## 13.4 Home States

### Loading

Use a consistent skeleton or loading presentation.

### Success

Display product cards.

### Empty

```text
No products available

There are currently no products to display.

[ Retry ]
```

### Error

```text
Something went wrong

We couldn't load the products.

[ Retry ]
```

The existing design requires loading, empty and error states rather than only the success state. fileciteturn6file0L40-L46

---

# 14. Product Detail Screen

## 14.1 Purpose

Product Detail presents complete information for the product selected from Home.

## 14.2 Layout

```text
┌────────────────────────────────┐
│ ← Back              Product    │
├────────────────────────────────┤
│                                │
│       Product Image            │
│                                │
│ Product Name                   │
│ Category                       │
│                                │
│ ★ 4.5        $29.99            │
│                                │
│ Discount / Availability        │
│                                │
│ Description                    │
│                                │
│ Product Information            │
│ Brand                          │
│ Stock                          │
│ SKU                            │
│                                │
└────────────────────────────────┘
```

The existing Detail design prioritizes image, name, primary information, description and additional information. fileciteturn5file7L1210-L1238

## 14.3 Image Treatment

- Maintain aspect ratio.
- Use a neutral Material surface behind images.
- Avoid image distortion.
- Provide a useful fallback when an image cannot load.

## 14.4 Detail States

```text
Loading
Success
Not Found
Error
```

Not-found should be communicated as a normal user-facing state rather than a raw API error.

---

# 15. Profile Screen

## 15.1 Purpose

Profile provides account information and account-level actions.

## 15.2 Layout

```text
┌────────────────────────────────┐
│ Profile                        │
├────────────────────────────────┤
│                                │
│            ◯                   │
│          Avatar                │
│                                │
│       First Last               │
│       @username                │
│       email@example.com        │
│                                │
├────────────────────────────────┤
│ Account                        │
│                                │
│ Edit Profile              ›    │
│                                │
│ Settings                  ›    │
│                                │
├────────────────────────────────┤
│                                │
│ Log out                         │
│                                │
└────────────────────────────────┘
```

## 15.3 Profile Information

Display when available:

- Avatar.
- First name.
- Last name.
- Username.
- Email.

Optional missing fields must not produce broken or empty-looking UI.

## 15.4 Logout

Logout is a destructive/session-ending action and should require confirmation.

```text
Log out?

Are you sure you want to log out?

[Cancel] [Log out]
```

After confirmation:

```text
Clear session
    ↓
Login
```

The navigation stack must not allow the user to return to protected screens after logout.

---

# 16. Edit Profile Screen

The initial scope defines Edit Profile as an entry point.

```text
┌────────────────────────────────┐
│ ← Back       Edit Profile      │
├────────────────────────────────┤
│                                │
│ Profile editing                │
│                                │
│ This functionality will be    │
│ available in a future version. │
│                                │
└────────────────────────────────┘
```

No fake profile persistence should be represented in the prototype.

If a real profile API is approved later, the design will be expanded.

---

# 17. Settings Screen

## 17.1 Purpose

Settings controls application-level preferences.

## 17.2 Layout

```text
┌────────────────────────────────┐
│ ← Back       Settings          │
├────────────────────────────────┤
│                                │
│ Appearance                     │
│ ┌────────────────────────────┐ │
│ │ Theme                 ›     │ │
│ │ System                    │ │
│ └────────────────────────────┘ │
│                                │
│ Notifications                  │
│ ┌────────────────────────────┐ │
│ │ Notifications        [ ON ]│ │
│ └────────────────────────────┘ │
│                                │
│ About                          │
│ ┌────────────────────────────┐ │
│ │ App Version           1.0.0│ │
│ └────────────────────────────┘ │
│                                │
│ Legal                          │
│ Privacy Policy            ›    │
│ Terms of Use              ›    │
│                                │
└────────────────────────────────┘
```

## 17.3 Theme Selector

Selecting Theme opens a Material 3 selection surface:

```text
Theme

○ System
○ Light
○ Dark

[ Done ]
```

Current selection must be clearly communicated.

## 17.4 Notification Preference

Use a Material 3 switch for the local notification preference.

The prototype must not imply that push notifications are functional unless the feature is actually implemented.

---

# 18. Notifications Screen

## 18.1 Purpose

Notifications provides a central place to view notifications.

The feature is currently optional/planned because the assignment does not define a notifications API.

## 18.2 Layout

```text
┌────────────────────────────────┐
│ Notifications                  │
├────────────────────────────────┤
│                                │
│ ● Appointment reminder         │
│   Your appointment is tomorrow │
│   10 min ago                   │
│                                │
│   Welcome                      │
│   Welcome to the application   │
│   Yesterday                    │
│                                │
└────────────────────────────────┘
```

## 18.3 Unread State

Unread notifications should be visually distinct using:

- Weight.
- Background/surface treatment.
- Leading indicator where appropriate.

Do not rely only on color.

## 18.4 Empty State

```text
No notifications

You're all caught up.
```

## 18.5 Error State

```text
Couldn't load notifications

Please try again.

[ Retry ]
```

No undocumented remote notification API should be represented in the prototype.

---

# 19. Navigation Behavior

Approved logical navigation:

```text
Login
  ↓
Home
 ├── Product Detail
 ├── Notifications
 └── Profile
       ├── Edit Profile
       ├── Settings
       └── Logout
             ↓
           Login
```

Settings remains secondary navigation under Profile.

Product Detail is reached from a Product Card and returns to Home.

---

# 20. App Bars

Use Material 3 app bar patterns consistently.

### Top-level screens

```text
Home
Notifications
Profile
```

may use a standard top app bar without a back button.

### Secondary screens

```text
Product Detail
Edit Profile
Settings
```

should use a back navigation affordance.

Example:

```text
← Settings
```

Titles should remain concise and descriptive.

---

# 21. Buttons

## Primary

Electric Blue filled treatment:

```text
┌──────────────────────────────┐
│            LOGIN             │
└──────────────────────────────┘
```

Use for the main action.

## Secondary

Outlined or neutral treatment:

```text
┌──────────────────────────────┐
│            RETRY             │
└──────────────────────────────┘
```

The existing design defines Electric Blue primary actions and neutral/outlined secondary actions. fileciteturn5file0L13-L48

---

# 22. Text Fields

Text fields must provide:

- Clear label.
- Visible focus.
- Electric Blue focus indicator.
- Error state.
- Adequate input height.
- Password masking where required.

These states are already established in the design system. fileciteturn5file0L52-L83

---

# 23. Loading States

Loading must communicate that a request is in progress.

Approved approaches:

- Skeleton loading.
- Circular progress indicator.
- Button progress indicator.

The same approach should be used consistently across screens. fileciteturn5file7L1242-L1252

Recommended:

```text
Login       → Button progress
Home        → Skeleton/list loading
Detail      → Skeleton/detail loading
Profile     → Content loading where required
Settings    → Immediate/local loading only when necessary
Notifications → List loading
```

---

# 24. Empty States

An empty state must:

- Explain the situation.
- Avoid technical terminology.
- Provide an action when appropriate.

Example:

```text
No products available

There are currently no products to display.

[ Retry ]
```

This follows the existing empty-state rules. fileciteturn5file1L183-L199

---

# 25. Error States

Errors should be clear without being disruptive.

Example:

```text
Something went wrong

We couldn't load the content.
Please try again.

[ Retry ]
```

Never expose:

- Stack traces.
- Raw exceptions.
- API implementation details.

Use the semantic Material 3 `error` color role. fileciteturn5file1L203-L220

---

# 33. Design Constraints

Mandatory:

1. Electric Blue (`#2563EB`) is the primary application color.
2. Latest **Material 3 Expressive** patterns must be used.
3. Light, Dark and System themes must be supported.
4. Visual hierarchy must remain clear.
5. Colors must come from centralized M3 semantic design tokens — never hard-coded in widgets.
6. UI widgets must not contain business logic.
7. Loading, empty and error states must be designed for every data-bearing screen.
8. Interactive states (default, hover, pressed, disabled, loading, error) must be visually distinguishable.
9. Screens must support common mobile sizes without overflow.
10. Approved `docs/prototype.html` must be the reference for all Flutter UI implementation.
11. Major design changes must be documented in `docs/design.md` and revalidated in `docs/prototype.html`.
12. Accessibility must be considered on every screen.
13. Profile, Settings and Notifications must follow the same design system as Login, Home, and Detail.
14. Settings must not visually expose unsupported functionality as implemented functionality.
15. Notifications must not imply a remote backend that has not been specified.
16. Typography must use the **Inter** font. No other font families are permitted without approval.
17. Icons must use **Material Symbols Rounded** variable font. Emoji icons are not permitted.
18. Motion must follow M3 Standard (`cubic-bezier(.2,0,0,1)`) and Emphasized (`cubic-bezier(.2,0,0,1.4)`) easing.

---

# 26. Interaction States

All interactive components must define:

```text
Default
Focused
Pressed
Disabled
Loading
Error
Selected
```

where applicable.

The existing design specifically requires these states. fileciteturn5file1L224-L243

Electric Blue should communicate active/selected/focused states without becoming the only indicator.

---

# 27. Accessibility

The entire application must:

- Maintain sufficient contrast.
- Avoid color-only communication.
- Provide meaningful labels.
- Maintain adequate touch targets.
- Support text scaling.
- Show visible focus states.
- Use semantic controls.
- Avoid overly small text.

These requirements apply to Login, Home, Detail, Profile, Settings, Notifications and Navigation. fileciteturn5file1L247-L260

Additional screen-specific requirements:

### Profile

Avatar should have a meaningful semantic label.

### Settings

Switch and theme-selection controls must expose their current state.

### Notifications

Unread/read state must remain understandable without relying solely on color.

### Navigation

Navigation destinations must have meaningful labels and selected state semantics.

---

# 28. Responsive Design

The UI must support:

- Small phones.
- Standard phones.
- Large phones.
- Supported orientations.

Avoid:

- Fixed widths.
- Hard-coded screen dimensions.
- Text clipping.
- Overlapping controls.

Flutter implementation should use appropriate responsive layout primitives such as:

```text
Expanded
Flexible
LayoutBuilder
MediaQuery
SafeArea
SingleChildScrollView
```

The existing design establishes these responsive requirements. fileciteturn5file1L264-L293

---

# 29. Screen State Matrix

| Screen         | Initial    | Loading                   | Success        | Empty            | Error            |
| -------------- | ---------- | ------------------------- | -------------- | ---------------- | ---------------- |
| Login          | Login form | Button loading            | Navigate Home  | N/A              | Validation/API   |
| Home           | Initial    | Skeleton/list loading     | Product list   | No products      | Retry            |
| Product Detail | Initial    | Detail loading            | Product detail | Not found        | Retry            |
| Profile        | Initial    | Profile loading if needed | Profile        | N/A              | Retry/message    |
| Settings       | Initial    | Local loading if needed   | Settings       | N/A              | Preference error |
| Notifications  | Initial    | List loading              | Notifications  | No notifications | Retry            |

This extends the existing Login/Home/Detail state matrix to the newly approved features. fileciteturn6file0L40-L46

---

# 30. Design Tokens

Visual constants must be centralized.

Recommended:

```text
app/
└── theme/
    ├── app_theme.dart
    ├── app_colors.dart
    ├── app_typography.dart
    ├── app_spacing.dart
    └── app_theme_extensions.dart
```

The existing design system already recommends centralized theme files and avoiding hard-coded colors/spacing in widgets. fileciteturn5file6L953-L982

---

# 31. HTML Prototype Requirements

Before Flutter implementation, every approved screen must have a static HTML prototype.

Prototype screens:

```text
01-login.html
02-home.html
03-product-detail.html
04-notifications.html
05-profile.html
06-settings.html
07-edit-profile.html
```

The prototype should validate:

- Layout.
- Typography.
- Colors.
- Spacing.
- Component hierarchy.
- Navigation.
- Validation messages.
- Loading states.
- Error states.
- Empty states.
- Responsive behavior.
- Light theme.
- Dark theme.

The existing Design Document explicitly requires static HTML prototypes before Flutter implementation and defines them as design-validation artifacts rather than production UI. fileciteturn6file0L18-L36

---

# 32. Prototype Interaction Requirements

The HTML prototype should allow reviewers to experience the intended application flow:

```text
Login
  ↓
Home
  ↓
Product Detail
  ↓
Back
  ↓
Home
```

And:

```text
Home
  ↓
Notifications
```

And:

```text
Home
  ↓
Profile
  ↓
Settings
  ↓
Theme
  ├── System
  ├── Light
  └── Dark
```

And:

```text
Profile
  ↓
Logout
  ↓
Login
```

The prototype does not need a real backend. Interactions should demonstrate the approved UX.

---

# 33. Design Constraints

Mandatory:

1. Electric Blue is the primary application color.
2. Latest Material 3 patterns must be used.
3. Light, Dark and System themes must be supported.
4. Visual hierarchy must remain clear.
5. Colors must come from centralized design tokens.
6. UI widgets must not contain business logic.
7. Loading, empty and error states must be designed.
8. Interactive states must be visually distinguishable.
9. Screens must support common mobile sizes.
10. Approved HTML prototypes must be reflected in Flutter.
11. Major design changes must be documented and revalidated.
12. Accessibility must be considered.
13. Profile, Settings and Notifications must follow the same design system as Login/Home/Detail.
14. Settings must not visually expose unsupported functionality as implemented functionality.
15. Notifications must not imply a remote backend that has not been specified.

These extend the existing design constraints. fileciteturn6file0L50-L63

---

# 34. Design Completion Criteria

The Design phase is complete when:

- [ ] Electric Blue color system approved.
- [ ] Material 3 color scheme approved.
- [ ] Light theme approved.
- [ ] Dark theme approved.
- [ ] System theme behavior approved.
- [ ] Typography approved.
- [ ] Spacing approved.
- [ ] Component styles approved.
- [ ] Login layout approved.
- [ ] Home layout approved.
- [ ] Product Detail layout approved.
- [ ] Profile layout approved.
- [ ] Settings layout approved.
- [ ] Notifications layout approved.
- [ ] Edit Profile layout approved.
- [ ] Navigation UI approved.
- [ ] Loading states defined.
- [ ] Empty states defined.
- [ ] Error states defined.
- [ ] Responsive behavior validated.
- [ ] Accessibility reviewed.
- [ ] Static HTML prototypes created.
- [ ] HTML prototypes reviewed/approved.
- [ ] Flutter implementation can be traced back to the approved design.

The existing completion criteria already require approval of the visual system, Login/Home/Detail, states, responsiveness, accessibility and static prototypes. fileciteturn6file0L67-L84

---

# 35. Relationship With Other Documents

```text
task.md
    ↓
architecture.md
    ↓
engineering.md
    ↓
navigation.md
    ↓
design.md
    ↓
feature specifications
    ↓
HTML prototypes
    ↓
UX/UI validation
    ↓
Flutter implementation
    ↓
Testing
    ↓
Documentation update
```

The Design Document must not introduce functional requirements that are not defined or approved by the Task and Feature documents. fileciteturn6file0L88-L106
