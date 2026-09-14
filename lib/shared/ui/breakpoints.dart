import 'package:flutter/material.dart';
import 'wearable_utils.dart';

/// Semantic viewport tiers spanning Wearable, Smartphone, Foldable, and Desktop/Web.
enum ScreenTier {
  /// Smartwatches / Wear OS (circular or compact square displays <= 320px)
  wearable,

  /// Smartphones & Folded devices (portrait single-column width < 600px)
  compact,

  /// Foldables unfolded & Tablets (dual-pane / wide deck 600px - 1023px)
  foldOrTablet,

  /// Desktop monitors & wide Web browsers (workspace >= 1024px)
  desktopWeb,
}

/// Canonical responsive breakpoints for the application.
class Breakpoints {
  const Breakpoints._();

  /// Upper bound for wearable (smartwatch / Wear OS) displays.
  static const double wearableMax = 320.0;

  /// Threshold dividing compact Smartphone / folded devices from Fold/Tablet layouts.
  static const double compactMax = 600.0;

  /// Threshold dividing Foldable/Tablet layouts from full Desktop / Web workspaces.
  static const double foldOrTabletMax = 1024.0;

  /// Maximum content constraint for wide desktop screens to prevent over-stretching.
  static const double desktopMaxWidth = 1360.0;

  /// Resolves the current semantic screen tier from the build context.
  static ScreenTier getTier(BuildContext context) {
    if (WearableUtils.isWearable(context)) {
      return ScreenTier.wearable;
    }
    final width = MediaQuery.sizeOf(context).width;
    if (width <= wearableMax) {
      return ScreenTier.wearable;
    }
    if (width < compactMax) {
      return ScreenTier.compact;
    }
    if (width < foldOrTabletMax) {
      return ScreenTier.foldOrTablet;
    }
    return ScreenTier.desktopWeb;
  }

  /// Whether current viewport is in wearable mode (Watch / Wear OS).
  static bool isWearable(BuildContext context) =>
      getTier(context) == ScreenTier.wearable;

  /// Whether current viewport is in compact mode (Smartphone or folded foldable).
  static bool isCompact(BuildContext context) =>
      getTier(context) == ScreenTier.compact;

  /// Whether current viewport is in foldable or tablet mode.
  static bool isFoldOrTablet(BuildContext context) =>
      getTier(context) == ScreenTier.foldOrTablet;

  /// Whether current viewport is in wide desktop or web mode.
  static bool isDesktopWeb(BuildContext context) =>
      getTier(context) == ScreenTier.desktopWeb;

  /// Returns true if the screen is wide enough for multi-pane layouts (fold, tablet, desktop).
  static bool isWide(BuildContext context) {
    final tier = getTier(context);
    return tier == ScreenTier.foldOrTablet || tier == ScreenTier.desktopWeb;
  }
}
