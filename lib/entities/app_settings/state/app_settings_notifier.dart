import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/shared.dart';
import '../model/app_settings.dart';

/// Notifier managing persistent application preferences.
class AppSettingsNotifier extends Notifier<AppSettings> {
  final LocalStorageAdapter? _configuredStorage;
  LocalStorageAdapter? _storage;
  AppSettings? _standaloneState;

  // Set when the user changes a setting before the initial load completes,
  // so the persisted (older) value does not overwrite the new choice.
  bool _themeModeChanged = false;
  bool _highContrastChanged = false;

  AppSettingsNotifier([this._configuredStorage]);

  static const _themeKey = 'app_theme_mode';
  static const _highContrastKey = 'app_high_contrast';

  @override
  AppSettings build() {
    LocalStorageAdapter? watchedStorage;
    try {
      watchedStorage = ref.watch(localStorageProvider);
    } catch (_) {}
    _storage = _configuredStorage ?? watchedStorage;
    const initial = AppSettings();
    _standaloneState = initial;
    Future.microtask(_loadFromStorage);
    return initial;
  }

  @override
  AppSettings get state {
    try {
      return super.state;
    } catch (_) {
      return _standaloneState ??= const AppSettings();
    }
  }

  @override
  set state(AppSettings value) {
    try {
      super.state = value;
    } catch (_) {
      _standaloneState = value;
    }
  }

  Future<void> _loadFromStorage() async {
    final storage = _storage;
    if (storage == null) return;
    try {
      final themeStr = await storage.getString(_themeKey);
      final highContrast = await storage.getBool(_highContrastKey) ?? false;

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
    NotifierProvider<AppSettingsNotifier, AppSettings>(AppSettingsNotifier.new);

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
