import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

/// Immutable domain model representing application preferences and settings.
class AppSettings {
  final ThemeMode themeMode;
  final ScreenTier? simulatedTier;
  final bool isHighContrast;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.simulatedTier,
    this.isHighContrast = false,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    ScreenTier? Function()? simulatedTier,
    bool? isHighContrast,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      simulatedTier:
          simulatedTier != null ? simulatedTier() : this.simulatedTier,
      isHighContrast: isHighContrast ?? this.isHighContrast,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          themeMode == other.themeMode &&
          simulatedTier == other.simulatedTier &&
          isHighContrast == other.isHighContrast;

  @override
  int get hashCode =>
      themeMode.hashCode ^ simulatedTier.hashCode ^ isHighContrast.hashCode;
}
