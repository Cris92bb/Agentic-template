import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Utilities for detecting and adapting UI to smartwatch / Wear OS form factors.
///
/// Ensures circular watch screens do not clip corner content and that touch targets
/// are appropriately sized for glanceable wear navigation.
class WearableUtils {
  const WearableUtils._();

  /// Maximum logical size of both display sides for a smartwatch display.
  static const double maxWatchSide = 320.0;

  @Deprecated('Use maxWatchSide: both display sides must now fit within it.')
  static const double maxWatchShortestSide = maxWatchSide;

  /// Returns true if the current viewport corresponds to a smartwatch / wearable display.
  ///
  /// Both sides must be small: a short but wide desktop or browser window is
  /// not a watch.
  static bool isWearable(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.longestSide <= maxWatchSide && size.shortestSide > 0;
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
