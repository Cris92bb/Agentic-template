import 'package:flutter/material.dart';
import '../../shared/shared.dart';

/// Central theme definitions for Agentic Template.
class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppTokens.lightCanvasBg,
      colorScheme: const ColorScheme.light(
        primary: AppTokens.primary,
        secondary: AppTokens.secondary,
        surface: AppTokens.lightSurfaceBg,
        error: AppTokens.accentError,
        onPrimary: AppTokens.lightActionFg,
        onSecondary: AppTokens.lightTextPrimary,
        onSurface: AppTokens.lightTextPrimary,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppTokens.lightSurfaceBg,
        foregroundColor: AppTokens.lightTextPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppTokens.lightCardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppTokens.radiusLg,
          side: const BorderSide(color: AppTokens.lightBorder, width: 1.0),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppTokens.lightBorder,
        thickness: 1.0,
        space: 1.0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppTokens.darkCanvasBg,
      colorScheme: const ColorScheme.dark(
        primary: AppTokens.darkActionBg,
        secondary: AppTokens.darkSurfaceBg,
        surface: AppTokens.darkSurfaceBg,
        error: AppTokens.accentError,
        onPrimary: AppTokens.darkActionFg,
        onSecondary: AppTokens.darkTextPrimary,
        onSurface: AppTokens.darkTextPrimary,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppTokens.darkSurfaceBg,
        foregroundColor: AppTokens.darkTextPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppTokens.darkCardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppTokens.radiusLg,
          side: const BorderSide(color: AppTokens.darkBorder, width: 1.0),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppTokens.darkBorder,
        thickness: 1.0,
        space: 1.0,
      ),
    );
  }
}
