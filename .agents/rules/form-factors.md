# Form Factors & Multi-Device Guidelines

This repository supports four distinct device and viewport tiers:

| Tier | Enum | Condition / Width | Primary Target Devices | Layout Archetype |
|---|---|---|---|---|
| **Wearable** | `ScreenTier.wearable` | `shortestSide <= 320.0` | Wear OS, Apple Watch | Circular/glanceable, high-contrast, rotary/swipe gestures |
| **Smartphone** | `ScreenTier.compact` | `width < 600.0` | Mobile phones, folded foldables | Single-column stacked, bottom navigation / app bar |
| **Foldable / Tablet** | `ScreenTier.foldOrTablet` | `600.0 <= width < 1024.0` | Foldables unfolded, 8-11" tablets | Dual-pane split view, master-detail, wide deck |
| **Desktop / Web** | `ScreenTier.desktopWeb` | `width >= 1024.0` | Linux, macOS, Windows, Full Web | Expanded sidebar / navigation rail, multi-column workspace |

---

## 1. Wearable Guidelines
- Inset safe padding using `WearableUtils.getSafeCircularPadding(context)` so circular bezels never clip text or action buttons.
- Touch targets on wearable displays must be compact yet easily tappable with generous touch pads.
- Handle gestures carefully: avoid horizontal gestures that conflict with watch system dismiss swipe.

## 2. Foldable & Smartphone Guidelines
- Support fold state transitions smoothly without losing user input or navigation state.
- In compact view, show master view; upon selecting an item or when unfolded, expand into dual-pane view.

## 3. Web & Linux Desktop Guidelines
- Support keyboard navigation (`FocusNode`, `onKeyEvent`, Shortcuts).
- Support desktop mouse hover states (`MouseRegion`, `InkWell`).
- Integrate Linux window controls via `MethodChannel('app/window')` for custom dragging/resizing when needed.
