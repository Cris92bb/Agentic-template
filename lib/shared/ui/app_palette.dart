import 'package:flutter/material.dart';
import 'tokens.dart';

/// Color roles for the active brightness and contrast, built from [AppTokens].
///
/// Widgets read colors with `AppPalette.of(context)` instead of branching on
/// `isDark`; the app theme registers the right variant (light, dark or their
/// high-contrast versions) as a [ThemeExtension].
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  final Color canvas;
  final Color surface;
  final Color card;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color actionBg;
  final Color actionFg;

  /// Icons and highlights (brand glyphs, selected items).
  final Color accent;

  /// Selection indicator behind navigation destinations.
  final Color navIndicator;
  final Color deviceBezel;
  final Color successFg;
  final Color warningFg;
  final Color errorFg;
  final Color infoFg;
  final List<BoxShadow> cardShadow;

  const AppPalette({
    required this.canvas,
    required this.surface,
    required this.card,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.actionBg,
    required this.actionFg,
    required this.accent,
    required this.navIndicator,
    required this.deviceBezel,
    required this.successFg,
    required this.warningFg,
    required this.errorFg,
    required this.infoFg,
    required this.cardShadow,
  });

  static final AppPalette light = AppPalette(
    canvas: AppTokens.lightCanvasBg,
    surface: AppTokens.lightSurfaceBg,
    card: AppTokens.lightCardBg,
    border: AppTokens.lightBorder,
    textPrimary: AppTokens.lightTextPrimary,
    textSecondary: AppTokens.lightTextSecondary,
    textMuted: AppTokens.lightTextMuted,
    actionBg: AppTokens.lightActionBg,
    actionFg: AppTokens.lightActionFg,
    accent: AppTokens.primaryLight,
    navIndicator: AppTokens.secondary,
    deviceBezel: AppTokens.lightDeviceBezel,
    successFg: AppTokens.accentSuccess,
    warningFg: AppTokens.lightWarningFg,
    errorFg: AppTokens.accentError,
    infoFg: AppTokens.accentInfo,
    cardShadow: AppTokens.lightCardShadow,
  );

  static final AppPalette dark = AppPalette(
    canvas: AppTokens.darkCanvasBg,
    surface: AppTokens.darkSurfaceBg,
    card: AppTokens.darkCardBg,
    border: AppTokens.darkBorder,
    textPrimary: AppTokens.darkTextPrimary,
    textSecondary: AppTokens.darkTextSecondary,
    textMuted: AppTokens.darkTextMuted,
    actionBg: AppTokens.darkActionBg,
    actionFg: AppTokens.darkActionFg,
    accent: AppTokens.darkAccent,
    navIndicator: AppTokens.darkActionBg,
    deviceBezel: AppTokens.darkDeviceBezel,
    successFg: AppTokens.darkSuccessFg,
    warningFg: AppTokens.darkWarningFg,
    errorFg: AppTokens.darkErrorFg,
    infoFg: AppTokens.darkInfoFg,
    cardShadow: AppTokens.darkCardShadow,
  );

  static final AppPalette highContrastLight = light.copyWith(
    textSecondary: AppTokens.lightHcTextSecondary,
    textMuted: AppTokens.lightTextSecondary,
    border: AppTokens.lightHcBorder,
    accent: AppTokens.primary,
  );

  static final AppPalette highContrastDark = dark.copyWith(
    textSecondary: AppTokens.darkHcTextSecondary,
    textMuted: AppTokens.darkTextSecondary,
    border: AppTokens.darkHcBorder,
    accent: AppTokens.darkHcAccent,
  );

  /// Palette registered on the current theme, or the default light/dark one
  /// when the theme has none (e.g. widget tests with a bare `MaterialApp`).
  static AppPalette of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  @override
  AppPalette copyWith({
    Color? canvas,
    Color? surface,
    Color? card,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? actionBg,
    Color? actionFg,
    Color? accent,
    Color? navIndicator,
    Color? deviceBezel,
    Color? successFg,
    Color? warningFg,
    Color? errorFg,
    Color? infoFg,
    List<BoxShadow>? cardShadow,
  }) {
    return AppPalette(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      actionBg: actionBg ?? this.actionBg,
      actionFg: actionFg ?? this.actionFg,
      accent: accent ?? this.accent,
      navIndicator: navIndicator ?? this.navIndicator,
      deviceBezel: deviceBezel ?? this.deviceBezel,
      successFg: successFg ?? this.successFg,
      warningFg: warningFg ?? this.warningFg,
      errorFg: errorFg ?? this.errorFg,
      infoFg: infoFg ?? this.infoFg,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  AppPalette lerp(covariant ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      actionBg: Color.lerp(actionBg, other.actionBg, t)!,
      actionFg: Color.lerp(actionFg, other.actionFg, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      navIndicator: Color.lerp(navIndicator, other.navIndicator, t)!,
      deviceBezel: Color.lerp(deviceBezel, other.deviceBezel, t)!,
      successFg: Color.lerp(successFg, other.successFg, t)!,
      warningFg: Color.lerp(warningFg, other.warningFg, t)!,
      errorFg: Color.lerp(errorFg, other.errorFg, t)!,
      infoFg: Color.lerp(infoFg, other.infoFg, t)!,
      cardShadow: t < 0.5 ? cardShadow : other.cardShadow,
    );
  }
}
