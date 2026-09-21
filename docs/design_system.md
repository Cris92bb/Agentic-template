# Design System & Palette Specification

This document provides the canonical design system specification for the **Agentic Template** application. It details all visual tokens, color roles, typography, elevation models, and component guidelines used across the interface.

---

## 1. Aesthetic Philosophy

The Agentic Template interface is designed with a **focused, editorial, and tactile** aesthetic. It rejects harsh, unstyled wireframe aesthetics (such as stark `#FFFFFF` paired with heavy `#000000` strokes) in favor of:
- **Atmospheric Tranquility**: A soft, focused sage green light palette (`#F4F6F0` canvas, `#E9EFE4` surface) and a deep slate/forest dark palette (`#111713` canvas, `#202C24` card) that reduce visual fatigue.
- **Physical Depth & Layer Separation**: Subtle value stepping (`#F4F6F0` → `#E9EFE4` → `#F9FAF7`) with soft ambient shadows and low-opacity borders rather than heavy outlines.
- **Intentional Action Accents**: Grounded spruce evergreen (`#2A3C31` light, `#43604E` dark) anchors primary actions with authority and clarity.
- **High Contrast Accessibility**: First-class support for WCAG AAA compliance through dedicated high-contrast light and dark palette overrides.

---

## 2. Design Token Variable Reference (`AppTokens`)

### 2.1 Core Palette Tokens (Light Mode)

| Variable / Token | HEX Code | Visual Tone | Semantic Usage |
| --- | --- | --- | --- |
| `AppTokens.lightCanvasBg` | `#F4F6F0` | Soft warm sage-tinted white | Main page backdrop, root scaffold canvas |
| `AppTokens.lightSurfaceBg` | `#E9EFE4` | Faded misty sage surface | Secondary containers, navigation panels, toolbar surface |
| `AppTokens.lightCardBg` | `#F9FAF7` | Ultra-light tinted off-white | Card surfaces, modal sheets, elevated tiles |
| `AppTokens.lightBorder` | `#D6DFD0` | Soft leafy gray | 1.0px card outlines, dividers, structural borders |
| `AppTokens.lightTextPrimary` | `#19241D` | Deep forest near-black | Primary headings, card titles, prominent text |
| `AppTokens.lightTextSecondary` | `#5A695F` | Muted sage slate | Body descriptions, auxiliary counters, subtitle text |
| `AppTokens.lightTextMuted` | `#8A998F` | Soft olive-slate | Placeholder hints, timestamps, secondary icons |
| `AppTokens.lightActionBg` | `#2A3C31` | Dark spruce evergreen | Primary interactive button fill, active indicators |
| `AppTokens.lightActionFg` | `#FFFFFF` | Pure white | Primary action button text and icons |

### 2.2 Core Palette Tokens (Dark Mode)

| Variable / Token | HEX Code | Visual Tone | Semantic Usage |
| --- | --- | --- | --- |
| `AppTokens.darkCanvasBg` | `#111713` | Deep obsidian slate | Dark theme background canvas |
| `AppTokens.darkSurfaceBg` | `#19221C` | Deep charcoal green | Secondary panels, navigation rail, toolbars |
| `AppTokens.darkCardBg` | `#202C24` | Elevated dark card surface | Cards, modals, elevated surfaces |
| `AppTokens.darkBorder` | `#2E3E33` | Subdued forest border | 1.0px subtle dividers, container boundaries |
| `AppTokens.darkTextPrimary` | `#EEF3EC` | Off-white sage | Primary headers, high-emphasis text |
| `AppTokens.darkTextSecondary` | `#A2B3A7` | Light muted sage | Secondary body text, descriptions |
| `AppTokens.darkTextMuted` | `#6E8073` | Olive slate | Timestamps, placeholder labels |
| `AppTokens.darkActionBg` | `#43604E` | Medium sage forest | Interactive button background |
| `AppTokens.darkActionFg` | `#FFFFFF` | Pure white | Action button text and icons |

### 2.3 Functional Accents & Status Tokens

| Variable / Token | HEX Code | Semantic Usage |
| --- | --- | --- |
| `AppTokens.primary` | `#2A3C31` | Evergreen brand accent |
| `AppTokens.primaryLight` | `#4A6553` | Soft brand accent tint |
| `AppTokens.secondary` | `#DDE6D7` | Soft sage secondary container |
| `AppTokens.accentSuccess` | `#2E7D32` | Success indicators, verified badges |
| `AppTokens.accentWarning` | `#D97706` | Warning indicators, caution alerts |
| `AppTokens.accentError` | `#DC2626` | Destructive actions, errors, alert states |
| `AppTokens.accentInfo` | `#2563EB` | Informational badges and hyperlinks |

---

## 3. Theme Extension: `AppPalette`

Rather than branching conditionally on brightness (`isDark ? ... : ...`), UI widgets consume colors dynamically through `AppPalette.of(context)`:

```dart
final palette = AppPalette.of(context);

Container(
  color: palette.card,
  child: Text('Example', style: TextStyle(color: palette.textPrimary)),
);
```

### `AppPalette` Roles

| Palette Property | Description |
| --- | --- |
| `palette.canvas` | Root page background color |
| `palette.surface` | Sidebar, navigation rail, and secondary toolbar surface |
| `palette.card` | Elevated card container background |
| `palette.border` | Standard 1.0px divider and border color |
| `palette.textPrimary` | High-emphasis headline and title typography |
| `palette.textSecondary` | Medium-emphasis description and body typography |
| `palette.textMuted` | Low-emphasis captions, counters, and hint labels |
| `palette.actionBg` | Primary interactive button fill |
| `palette.actionFg` | Primary interactive button icon and text color |
| `palette.accent` | Focus rings, selection highlights, active chips |
| `palette.navIndicator` | Active indicator in navigation rail / bottom bar |
| `palette.deviceBezel` | Bezel color in in-app device simulator preview |
| `palette.cardShadow` | Multi-layered ambient box shadows for cards |

---

## 4. Spacing, Radii & Shadows

### 4.1 Spacing Scale
- `AppTokens.spaceXs`: `4.0` px
- `AppTokens.spaceSm`: `8.0` px
- `AppTokens.spaceMd`: `16.0` px
- `AppTokens.spaceLg`: `24.0` px
- `AppTokens.spaceXl`: `32.0` px
- `AppTokens.spaceXxl`: `48.0` px

### 4.2 Border Radii
- `AppTokens.radiusSm`: `8.0` px (chips, badges, compact inputs)
- `AppTokens.radiusMd`: `16.0` px (standard cards, dialogs, action panels)
- `AppTokens.radiusLg`: `24.0` px (large sheets, modal dialogs)
- `AppTokens.radiusXl`: `32.0` px (feature heros, floating sheets)
- `AppTokens.radiusFull`: `999.0` px (round icon buttons, pill tags)

### 4.3 Ambient Shadow Models
- **`AppTokens.lightCardShadow`**: Soft dual-layer ambient shadow minimizing harsh outlines:
  - Layer 1: `BoxShadow(color: Color(0xFF0F172A).withValues(alpha: 0.04), blurRadius: 8, offset: Offset(0, 2))`
  - Layer 2: `BoxShadow(color: Color(0xFF0F172A).withValues(alpha: 0.02), blurRadius: 24, offset: Offset(0, 8))`
- **`AppTokens.darkCardShadow`**: Ambient black shadow (`blurRadius: 12`, `alpha: 0.35`).
- **`AppTokens.floatingShadow`**: Floating elevation shadow for toolbars and overlays (`blurRadius: 20`, `alpha: 0.18`).

---

## 5. Smartwatch & Wear OS Guidelines

When rendering on Wear OS or circular smartwatches (`longestSide <= 320.0`):
- **OLED Black First**: Smartwatch backdrops leverage pure `#000000` black to optimize battery efficiency and blend into circular display bezels.
- **Circular Display Insets**: Utilize `WearableUtils.getSafeCircularPadding(context)` to compute the maximal inscribed rectangular padding, preventing content clipping on circular bezels.
- **Touch Targets & Glanceable Typography**: Minimum interactive target of $44 \times 44$ pt. Clear, high-contrast typography with compact line heights.
- **Gesture Conflict Resolution**: Accommodate system swipe-to-dismiss edge gestures by restricting horizontal carousel navigation or using vertical-first scrolling.

---

## 6. Strict Design Token Consistency & Zero Hardcoded Colors

1. **No Raw Color Literals**: Raw `Color(0x...)` or random hex literals are strictly forbidden across UI components, modals, views, and custom painters.
2. **Single Source of Truth**: All visual styles, borders, radii, and shadows must reference `AppTokens`, `AppPalette.of(context)`, or `Theme.of(context)`.
3. **Palette Cohesion**: Changes must look intentional and polished across all four supported variants: Light, Dark, High-Contrast Light, and High-Contrast Dark.

---

## 7. File Size & Clean Componentization Standard (<= 300 LOC)

1. **Hard Limit**: All Dart source files must ideally remain **under 300 lines of code**.
2. **Component Separation**: Large widgets, composite cards, and monolithic views must be extracted into dedicated `components/` or `views/` subdirectories.
3. **Comprehensive Dart Doc Comments**: Every public component, class, method, and constructor must include descriptive Dart doc comments (`///`) detailing purpose, interaction model, parameters, and architectural layer.
