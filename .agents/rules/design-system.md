# Design System Guidelines

These rules enforce the visual language, color tokens, and UI styling standards for all AI agents modifying this project.

---

## 1. Design Tokens First
Never use raw magic hex colors (`#FFFFFF`, `#000000`, `#123456`) or hardcoded pixel numbers for standard radii, padding, and elevation.
Raw values live in `AppTokens`; new colors must be added there first.

## 2. Read Colors from `AppPalette`
Widgets must not branch on brightness (`isDark ? AppTokens.dark… : AppTokens.light…`). Read the color roles of the active theme instead:

```dart
final palette = AppPalette.of(context);
```

`AppPalette` is a `ThemeExtension` registered by `AppTheme` in four variants: light, dark, high-contrast light and high-contrast dark.

- **Surfaces**: `palette.canvas`, `palette.surface`, `palette.card`, `palette.border`
- **Text**: `palette.textPrimary`, `palette.textSecondary`, `palette.textMuted`
- **Actions**: `palette.actionBg`, `palette.actionFg`
- **Accents**: `palette.accent` (icons, highlights, selected items), `palette.navIndicator`
- **Status foregrounds**: `palette.successFg`, `palette.warningFg`, `palette.errorFg`, `palette.infoFg`
- **Other**: `palette.deviceBezel`, `palette.cardShadow`

Brand accents that are the same in every theme remain available on `AppTokens`:
- `AppTokens.primary` (Spruce Evergreen)
- `AppTokens.secondary` (Soft Sage)
- `AppTokens.accentWarning` (Amber)
- `AppTokens.accentError` (Rose)
- `AppTokens.accentSuccess` (Mint Emerald)

---

## 3. Spacing and Radii Scales
- Spacing: `AppTokens.spaceXs` (4px), `AppTokens.spaceSm` (8px), `AppTokens.spaceMd` (16px), `AppTokens.spaceLg` (24px), `AppTokens.spaceXl` (32px).
- Border Radii: `AppTokens.radiusSm` (8px), `AppTokens.radiusMd` (16px), `AppTokens.radiusLg` (24px), `AppTokens.radiusFull` (999px).

---

## 4. Dark Mode, High Contrast & Accessibility
- Every UI widget must look polished in light, dark and both high-contrast themes; test components under each.
- Text and icons must meet WCAG contrast (4.5:1 for body text, 3:1 for large text and icons).
- Interactive targets must be at least 44×44.

---

## 5. Strict Design Token Enforcement (Zero Hardcoded Colors)

1. **No Raw Color Literals**: Constructing ad-hoc colors with `Color(0x...)` or random hex literals is strictly prohibited in widgets, modals, views, or custom painters.
2. **Single Source of Truth**: All colors must be read from `AppTokens`, `AppPalette.of(context)`, or `Theme.of(context)`.
3. **Shadow & Border Tokens**: Use standard token definitions (`AppTokens.lightCardShadow`, `AppTokens.darkCardShadow`, `AppTokens.floatingShadow`, `AppTokens.lightBorder`, `AppTokens.darkBorder`) to prevent visual fragmentation.

---

## 6. File Size & Clean Componentization Standard (<= 300 LOC)

1. **Hard Limit**: Strive to keep all Dart source files **under 300 lines of code**.
2. **Component Separation**: Decompose large files and monolithic views into focused, single-responsibility sub-components in dedicated `components/` or `views/` subdirectories.
3. **Comprehensive Doc Comments**: Every component, constructor, and method should feature descriptive Dart doc comments (`///`) detailing visual mechanics, states, parameters, and architectural classification.
