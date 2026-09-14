# Multi-Device & Form Factor Guide

This project is built from the ground up to support modern multi-device form factors:

1. **Wearable (Wear OS & Smartwatches)**
2. **Smartphone (Portrait Compact)**
3. **Foldable & Tablet (Unfolded Dual-Pane)**
4. **Web & Linux Desktop (Expanded Multi-Column)**

---

## 1. Breakpoint Philosophy

Breakpoints are centralized in `lib/shared/ui/breakpoints.dart`:

```dart
enum ScreenTier {
  /// Smartwatches / Wear OS (shortest side <= 320 logical pixels)
  wearable,

  /// Smartphones & Folded devices (width < 600)
  compact,

  /// Foldables unfolded & Tablets (600 <= width < 1024)
  foldOrTablet,

  /// Desktop monitors & wide Web browsers (width >= 1024)
  desktopWeb,
}
```

### Usage:
```dart
final tier = Breakpoints.getTier(context);
if (tier == ScreenTier.wearable) {
  return const WearableHomeView();
}
```

---

## 2. Wearable (Smartwatch) Implementation

Smartwatches present unique constraints:
- **Circular Display Insets**: Square viewports clip corners on circular screens. Use `WearableUtils.getSafeCircularPadding(context)` to compute the maximal inscribed rectangular padding.
- **Gesture Conflict Resolution**: Smartwatch OSes use horizontal edge-swipes to dismiss applications. Use directional physics or single-direction page swiping (`LeftOnlyPageScrollPhysics` or vertical scrolling).
- **Glanceable Hierarchy**: Display large typography, concise counters, high contrast, and large touch zones.

---

## 3. Smartphone & Foldable Implementation

- **Smartphone**: Single-pane layout with bottom navigation or compact app bar. Touch targets must follow mobile platform minimum guidelines ($44 \times 44$ pt).
- **Foldable (Unfolded)**: Dual-pane layout dividing the screen into master and detail or side-by-side productive surfaces. State persists smoothly across fold/unfold transitions.

---

## 4. Web & Linux Desktop Implementation

- **Desktop Workspace**: Persistent sidebar or navigation rail, multi-column dashboard, keyboard shortcuts.
- **Linux GTK Integration**:
  - Window theme synchronization via `MethodChannel('app/theme')`.
  - Native window dragging and edge resizing via `MethodChannel('app/window')`.
  - `.desktop` file launcher and bash scripts (`launch_app.sh`, `build_release.sh`).
- **Web**:
  - High-performance WASM-GC compilation via `build_web.sh`.
  - Smooth multi-device scroll behavior with `AppScrollBehavior`.

---

## 5. Built-in In-App Form Factor Simulator

For rapid prototyping and AI testing without physical hardware or multiple emulators:
- The template includes `DeviceSimulatorPicker` and `FormFactorPreviewFrame`.
- Select **Auto**, **Wearable (Round Watch)**, **Smartphone**, **Foldable (Unfolded)**, or **Desktop** directly within the running app to immediately preview all 4 layout tiers in real-time!
