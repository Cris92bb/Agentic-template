import 'package:flutter/material.dart';

/// Semantic design tokens for Agentic Template.
///
/// AI agents and developers should strictly reference these tokens rather than
/// hardcoding hex codes, dimensions, or magic radius numbers.
class AppTokens {
  const AppTokens._();

  // ---------------------------------------------------------------------------
  // Color Palette - Light Mode (Soft, Focused Sage & Forest Palette)
  // ---------------------------------------------------------------------------
  static const Color lightCanvasBg = Color(0xFFF4F6F0);
  static const Color lightSurfaceBg = Color(0xFFE9EFE4);
  static const Color lightCardBg = Color(0xFFF9FAF7);
  static const Color lightBorder = Color(0xFFD6DFD0);

  static const Color lightTextPrimary = Color(0xFF19241D);
  static const Color lightTextSecondary = Color(0xFF5A695F);
  static const Color lightTextMuted = Color(0xFF8A998F);

  static const Color lightActionBg = Color(0xFF2A3C31);
  static const Color lightActionFg = Colors.white;

  // ---------------------------------------------------------------------------
  // Color Palette - Dark Mode (Deep Slate & Muted Sage Accents)
  // ---------------------------------------------------------------------------
  static const Color darkCanvasBg = Color(0xFF111713);
  static const Color darkSurfaceBg = Color(0xFF19221C);
  static const Color darkCardBg = Color(0xFF202C24);
  static const Color darkBorder = Color(0xFF2E3E33);

  static const Color darkTextPrimary = Color(0xFFEEF3EC);
  static const Color darkTextSecondary = Color(0xFFA2B3A7);
  static const Color darkTextMuted = Color(0xFF6E8073);

  static const Color darkActionBg = Color(0xFF43604E);
  static const Color darkActionFg = Colors.white;

  // ---------------------------------------------------------------------------
  // Functional Accent Colors
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF2A3C31);
  static const Color primaryLight = Color(0xFF4A6553);
  static const Color secondary = Color(0xFFDDE6D7);

  /// Secondary container for dark mode, distinct from the dark surfaces.
  static const Color darkSecondary = Color(0xFF34473B);

  /// Sage accent for icons and highlights on dark surfaces (≥ 4.5:1 contrast).
  static const Color darkAccent = Color(0xFF8DB09A);

  static const Color accentSuccess = Color(0xFF2E7D32);
  static const Color accentWarning = Color(0xFFD97706);
  static const Color accentError = Color(0xFFDC2626);
  static const Color accentInfo = Color(0xFF2563EB);

  // ---------------------------------------------------------------------------
  // Status Foregrounds (badge text & icons readable on tinted fills)
  // ---------------------------------------------------------------------------
  static const Color lightWarningFg = Color(0xFFB45309);
  static const Color darkSuccessFg = Color(0xFF81C784);
  static const Color darkWarningFg = Color(0xFFFFB74D);
  static const Color darkErrorFg = Color(0xFFE57373);
  static const Color darkInfoFg = Color(0xFF64B5F6);

  // ---------------------------------------------------------------------------
  // High Contrast Overrides
  // ---------------------------------------------------------------------------
  static const Color lightHcTextSecondary = Color(0xFF2F3B33);
  static const Color lightHcBorder = Color(0xFF5A695F);
  static const Color darkHcTextSecondary = Color(0xFFD5E0D8);
  static const Color darkHcBorder = Color(0xFFA2B3A7);
  static const Color darkHcAccent = Color(0xFFB5D3BF);

  // ---------------------------------------------------------------------------
  // Device Simulator
  // ---------------------------------------------------------------------------
  static const Color lightDeviceBezel = Color(0xFF1E293B);
  static const Color darkDeviceBezel = Color(0xFF334155);

  // ---------------------------------------------------------------------------
  // Spacing Scale
  // ---------------------------------------------------------------------------
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double spaceXxl = 48.0;

  // ---------------------------------------------------------------------------
  // Border Radii
  // ---------------------------------------------------------------------------
  static const Radius radiusSmVal = Radius.circular(8.0);
  static const Radius radiusMdVal = Radius.circular(16.0);
  static const Radius radiusLgVal = Radius.circular(24.0);

  static final BorderRadius radiusSm = BorderRadius.circular(8.0);
  static final BorderRadius radiusMd = BorderRadius.circular(16.0);
  static final BorderRadius radiusLg = BorderRadius.circular(24.0);
  static final BorderRadius radiusXl = BorderRadius.circular(32.0);
  static final BorderRadius radiusFull = BorderRadius.circular(999.0);

  // ---------------------------------------------------------------------------
  // Shadows & Elevation
  // ---------------------------------------------------------------------------
  static final List<BoxShadow> lightCardShadow = [
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
      blurRadius: 8.0,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.02),
      blurRadius: 24.0,
      offset: const Offset(0, 8),
    ),
  ];

  static final List<BoxShadow> darkCardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.35),
      blurRadius: 12.0,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> floatingShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.18),
      blurRadius: 20.0,
      offset: const Offset(0, 8),
    ),
  ];
}
