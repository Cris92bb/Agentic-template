import 'package:flutter/material.dart';
import '../../shared/shared.dart';

/// Central theme definitions for Agentic Template.
///
/// Every theme registers its [AppPalette] so widgets can read color roles with
/// `AppPalette.of(context)`.
class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme =>
      _build(Brightness.light, AppPalette.light);

  static ThemeData get darkTheme => _build(Brightness.dark, AppPalette.dark);

  static ThemeData get highContrastLightTheme =>
      _build(Brightness.light, AppPalette.highContrastLight);

  static ThemeData get highContrastDarkTheme =>
      _build(Brightness.dark, AppPalette.highContrastDark);

  static ThemeData _build(Brightness brightness, AppPalette palette) {
    final isDark = brightness == Brightness.dark;
    final baseScheme =
        isDark ? const ColorScheme.dark() : const ColorScheme.light();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: palette.canvas,
      colorScheme: baseScheme.copyWith(
        primary: palette.actionBg,
        onPrimary: palette.actionFg,
        // Dark mode previously reused the surface color here, which made
        // secondary-colored components invisible.
        secondary: isDark ? AppTokens.darkSecondary : AppTokens.secondary,
        onSecondary: palette.textPrimary,
        surface: palette.surface,
        onSurface: palette.textPrimary,
        onSurfaceVariant: palette.textSecondary,
        outline: palette.border,
        error: AppTokens.accentError,
        onError: Colors.white,
      ),
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: palette.surface,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: palette.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppTokens.radiusLg,
          side: BorderSide(color: palette.border, width: 1.0),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: palette.border,
        thickness: 1.0,
        space: 1.0,
      ),
    );
  }
}
