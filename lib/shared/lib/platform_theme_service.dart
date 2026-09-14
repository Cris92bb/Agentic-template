import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Synchronizes Flutter's theme mode with native Linux GTK or host window environments.
class PlatformThemeService {
  const PlatformThemeService._();

  static const MethodChannel _channel = MethodChannel('app/theme');

  /// Notify native window host of theme changes (e.g. GTK dark/light prefer hint).
  static Future<void> syncTheme({required bool isDark}) async {
    if (kIsWeb) return;
    if (defaultTargetPlatform != TargetPlatform.linux) return;

    try {
      await _channel.invokeMethod('setTheme', {'isDark': isDark});
    } catch (_) {
      // Gracefully ignore if the host window channel is unhandled or unavailable
    }
  }
}
