import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Global scroll behavior enabling fluid scrolling with touch, mouse, trackpad, and stylus.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
