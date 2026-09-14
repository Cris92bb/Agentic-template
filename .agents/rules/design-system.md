# Design System Guidelines

These rules enforce the visual language, color tokens, and UI styling standards for all AI agents modifying this project.

---

## 1. Design Tokens First
Never use raw magic hex colors (`#FFFFFF`, `#000000`, `#123456`) or hardcoded pixel numbers for standard radii, padding, and elevation.
Always reference `AppTokens` or `Theme.of(context)`:

- **Surface Tokens**:
  - `AppTokens.lightCanvasBg` / `AppTokens.darkCanvasBg`
  - `AppTokens.lightSurfaceBg` / `AppTokens.darkSurfaceBg`
  - `AppTokens.lightCardBg` / `AppTokens.darkCardBg`
  - `AppTokens.lightBorder` / `AppTokens.darkBorder`
- **Text Tokens**:
  - `AppTokens.lightTextPrimary` / `AppTokens.darkTextPrimary`
  - `AppTokens.lightTextSecondary` / `AppTokens.darkTextSecondary`
  - `AppTokens.lightTextMuted` / `AppTokens.darkTextMuted`
- **Accent Tokens**:
  - `AppTokens.primary` (Spruce Evergreen)
  - `AppTokens.secondary` (Soft Sage)
  - `AppTokens.accentWarning` (Amber)
  - `AppTokens.accentError` (Rose)
  - `AppTokens.accentSuccess` (Mint Emerald)

---

## 2. Spacing and Radii Scales
- Spacing: `AppTokens.spaceXs` (4px), `AppTokens.spaceSm` (8px), `AppTokens.spaceMd` (16px), `AppTokens.spaceLg` (24px), `AppTokens.spaceXl` (32px).
- Border Radii: `AppTokens.radiusSm` (8px), `AppTokens.radiusMd` (16px), `AppTokens.radiusLg` (24px), `AppTokens.radiusFull` (999px).

---

## 3. Dark Mode & High Contrast
Every UI widget must look visually polished in both light and dark modes. Always test components under both brightness states.
