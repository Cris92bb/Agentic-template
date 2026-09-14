import 'dart:async';

import 'package:agentic_template/entities/app_settings/app_settings.dart';
import 'package:agentic_template/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// In-memory [LocalStorageAdapter]. Reads come from the initial snapshot and
/// wait for [readGate] when provided; writes are recorded in [written].
class _FakeStorage implements LocalStorageAdapter {
  final Map<String, Object> _persisted;
  final Completer<void>? readGate;
  final Map<String, Object> written = {};

  _FakeStorage([Map<String, Object> persisted = const {}, this.readGate])
      : _persisted = Map.of(persisted);

  Future<T?> _read<T>(String key) async {
    await readGate?.future;
    return _persisted[key] as T?;
  }

  Future<bool> _write(String key, Object value) async {
    written[key] = value;
    return true;
  }

  @override
  Future<String?> getString(String key) => _read<String>(key);

  @override
  Future<bool> setString(String key, String value) => _write(key, value);

  @override
  Future<int?> getInt(String key) => _read<int>(key);

  @override
  Future<bool> setInt(String key, int value) => _write(key, value);

  @override
  Future<bool?> getBool(String key) => _read<bool>(key);

  @override
  Future<bool> setBool(String key, bool value) => _write(key, value);

  @override
  Future<bool> remove(String key) async => written.remove(key) != null;
}

ProviderContainer _containerWith(LocalStorageAdapter storage) {
  final container = ProviderContainer(
    overrides: [localStorageProvider.overrideWithValue(storage)],
  );
  addTearDown(container.dispose);
  return container;
}

/// Lets pending storage futures complete.
Future<void> _flush() => Future<void>.delayed(Duration.zero);

void main() {
  group('AppSettingsNotifier persistence', () {
    test('loads the persisted theme mode and high contrast flag', () async {
      final container = _containerWith(
        _FakeStorage({'app_theme_mode': 'dark', 'app_high_contrast': true}),
      );

      container.read(appSettingsProvider);
      await _flush();

      final settings = container.read(appSettingsProvider);
      expect(settings.themeMode, ThemeMode.dark);
      expect(settings.isHighContrast, isTrue);
    });

    test('persists theme mode changes', () async {
      final storage = _FakeStorage();
      final container = _containerWith(storage);

      container
          .read(appSettingsProvider.notifier)
          .setThemeMode(ThemeMode.light);
      await _flush();

      expect(storage.written['app_theme_mode'], 'light');
      expect(container.read(themeModeProvider), ThemeMode.light);
    });

    test('a slow initial load does not overwrite a newer user choice',
        () async {
      final readGate = Completer<void>();
      final container = _containerWith(
        _FakeStorage({'app_theme_mode': 'dark'}, readGate),
      );

      container
          .read(appSettingsProvider.notifier)
          .setThemeMode(ThemeMode.light);
      readGate.complete();
      await _flush();

      expect(container.read(themeModeProvider), ThemeMode.light);
    });
  });
}
