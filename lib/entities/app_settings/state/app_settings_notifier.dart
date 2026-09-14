import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/shared.dart';
import '../model/app_settings.dart';

/// StateNotifier managing persistent application preferences.
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  final LocalStorageAdapter? _storage;

  // Set when the user changes a setting before the initial load completes,
  // so the persisted (older) value does not overwrite the new choice.
  bool _themeModeChanged = false;
  bool _highContrastChanged = false;

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
      if (!mounted) return;

      ThemeMode mode = ThemeMode.system;
      if (themeStr == 'dark') mode = ThemeMode.dark;
      if (themeStr == 'light') mode = ThemeMode.light;

      state = state.copyWith(
        themeMode: _themeModeChanged ? null : mode,
        isHighContrast: _highContrastChanged ? null : highContrast,
      );
    } catch (_) {}
  }

  void setThemeMode(ThemeMode mode) {
    _themeModeChanged = true;
    state = state.copyWith(themeMode: mode);
    _storage?.setString(_themeKey, mode.name);
  }

  void setSimulatedTier(ScreenTier? tier) {
    state = state.copyWith(simulatedTier: () => tier);
  }

  void toggleHighContrast() {
    _highContrastChanged = true;
    final next = !state.isHighContrast;
    state = state.copyWith(isHighContrast: next);
    _storage?.setBool(_highContrastKey, next);
  }
}

/// Provider exposing global application settings.
final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier(ref.watch(localStorageProvider));
});

/// Convenience provider for current ThemeMode.
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(appSettingsProvider).themeMode;
});

/// Convenience provider for the high-contrast preference.
final highContrastProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsProvider).isHighContrast;
});

/// Convenience provider for active simulated screen tier (null if auto-detect).
final simulatedTierProvider = Provider<ScreenTier?>((ref) {
  return ref.watch(appSettingsProvider).simulatedTier;
});
