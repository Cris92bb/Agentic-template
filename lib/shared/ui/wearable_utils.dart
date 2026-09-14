import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Utilities for detecting and adapting UI to smartwatch / Wear OS form factors.
///
/// Ensures circular watch screens do not clip corner content and that touch targets
/// are appropriately sized for glanceable wear navigation.
class WearableUtils {
  const WearableUtils._();

  /// Maximum logical width or height (shortest side) considered a smartwatch display.
  static const double maxWatchShortestSide = 320.0;

  /// Returns true if the current viewport corresponds to a smartwatch / wearable display.
  static bool isWearable(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.shortestSide <= maxWatchShortestSide && size.shortestSide > 0;
  }

  /// Calculates safe inset padding so content does not clip on circular watch displays.
  ///
  /// For a circular screen with diameter D, the maximum inscribed rectangle requires:
  /// (D - D / sqrt(2)) / 2 approx 0.1464 * D
  static EdgeInsets getSafeCircularPadding(
    BuildContext context, {
    double extra = 8.0,
  }) {
    final size = MediaQuery.sizeOf(context);
    final side = size.shortestSide;
    final inset = (side * 0.146) + extra;

    return EdgeInsets.symmetric(
      horizontal: math.max(16.0, inset),
      vertical: math.max(16.0, inset),
    );
  }

  /// Recommended touch target height for wearable action buttons.
  static const double watchButtonHeight = 44.0;
}
