import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Window edges accepted by [WindowControlService.startResize].
enum WindowEdge { north, south, east, west }

/// Dart API for the Linux GTK runner's `app/window` channel, for building
/// custom title bars (drag, resize, close). A no-op on other platforms.
///
/// Drag and resize use GTK pointer grabs: they work on X11, while most Wayland
/// compositors ignore them without a real input event.
class WindowControlService {
  const WindowControlService._();

  static const MethodChannel _channel = MethodChannel('app/window');

  /// Starts moving the window with the pointer (call from a pointer-down).
  static Future<void> startDrag() => _invoke('drag');

  /// Starts resizing the window from [edge] (call from a pointer-down).
  static Future<void> startResize(WindowEdge edge) =>
      _invoke('resize', {'edge': edge.name});

  /// Closes the window.
  static Future<void> close() => _invoke('close');

  static Future<void> _invoke(String method, [Map<String, Object?>? args]) async {
    if (kIsWeb) return;
    if (defaultTargetPlatform != TargetPlatform.linux) return;

    try {
      await _channel.invokeMethod<void>(method, args);
    } catch (_) {
      // Gracefully ignore if the host window channel is unhandled or unavailable
    }
  }
}
