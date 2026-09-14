import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

/// Supported simulated device profiles for in-app multi-device previewing.
enum SimulatedDevice {
  auto(
    label: 'Auto Detect',
    icon: Icons.devices_rounded,
    targetTier: null,
    previewSize: null,
  ),
  watchRound(
    label: 'Watch (Wear OS)',
    icon: Icons.watch_rounded,
    targetTier: ScreenTier.wearable,
    previewSize: Size(220, 220),
  ),
  phonePortrait(
    label: 'Smartphone',
    icon: Icons.phone_android_rounded,
    targetTier: ScreenTier.compact,
    previewSize: Size(390, 780),
  ),
  foldUnfolded(
    label: 'Foldable (Unfolded)',
    icon: Icons.laptop_chromebook_rounded,
    targetTier: ScreenTier.foldOrTablet,
    previewSize: Size(720, 760),
  ),
  desktop(
    label: 'Desktop / Web',
    icon: Icons.desktop_windows_rounded,
    targetTier: ScreenTier.desktopWeb,
    previewSize: null,
  );

  final String label;
  final IconData icon;
  final ScreenTier? targetTier;
  final Size? previewSize;

  const SimulatedDevice({
    required this.label,
    required this.icon,
    required this.targetTier,
    required this.previewSize,
  });
}
