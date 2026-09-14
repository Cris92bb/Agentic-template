import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-wide [LocalStorageAdapter], overridden in `main.dart` with a
/// [SharedPrefsStorageAdapter]. Defaults to `null` (no persistence) so tests
/// and previews work without platform storage.
final localStorageProvider = Provider<LocalStorageAdapter?>((ref) => null);

/// Abstract storage interface for persistent key-value configuration and data.
abstract class LocalStorageAdapter {
  Future<String?> getString(String key);
  Future<bool> setString(String key, String value);
  Future<int?> getInt(String key);
  Future<bool> setInt(String key, int value);
  Future<bool?> getBool(String key);
  Future<bool> setBool(String key, bool value);
  Future<bool> remove(String key);
}

/// SharedPreferences implementation of [LocalStorageAdapter].
class SharedPrefsStorageAdapter implements LocalStorageAdapter {
  final SharedPreferences _prefs;

  SharedPrefsStorageAdapter(this._prefs);

  static Future<SharedPrefsStorageAdapter> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsStorageAdapter(prefs);
  }

  @override
  Future<String?> getString(String key) async => _prefs.getString(key);

  @override
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  @override
  Future<int?> getInt(String key) async => _prefs.getInt(key);

  @override
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<bool?> getBool(String key) async => _prefs.getBool(key);

  @override
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  Future<bool> remove(String key) => _prefs.remove(key);
}
