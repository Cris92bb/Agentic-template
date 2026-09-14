import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/shared.dart';
import '../model/app_settings.dart';

/// StateNotifier managing persistent application preferences.
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  final LocalStorageAdapter? _storage;

  AppSettingsNotifier([this._storage]) : super(const AppSettings()) {
    _loadFromStorage();
  }

  static const _themeKey = 'app_theme_mode';
  static const _highContrastKey = 'app_high_contrast';

  Future<void> _loadFromStorage() async {
    if (_storage == null) return;
    try {
      final themeStr = await _storage.getString(_themeKey);
      final highContrast = await _storage.getBool(_highContrastKey) ?? false;

      ThemeMode mode = ThemeMode.system;
      if (themeStr == 'dark') mode = ThemeMode.dark;
      if (themeStr == 'light') mode = ThemeMode.light;

      state = state.copyWith(
        themeMode: mode,
        isHighContrast: highContrast,
      );
    } catch (_) {}
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    _storage?.setString(_themeKey, mode.name);
  }

  void setSimulatedTier(ScreenTier? tier) {
    state = state.copyWith(simulatedTier: () => tier);
  }

  void toggleHighContrast() {
    final next = !state.isHighContrast;
    state = state.copyWith(isHighContrast: next);
    _storage?.setBool(_highContrastKey, next);
  }
}

/// Provider exposing global application settings.
final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier();
});

/// Convenience provider for current ThemeMode.
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(appSettingsProvider).themeMode;
});

/// Convenience provider for active simulated screen tier (null if auto-detect).
final simulatedTierProvider = Provider<ScreenTier?>((ref) {
  return ref.watch(appSettingsProvider).simulatedTier;
});
