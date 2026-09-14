import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../entities/app_settings/app_settings.dart';
import '../../../shared/shared.dart';
import '../model/simulated_device.dart';

/// Compact device form factor selector for rapid testing across all 4 tiers.
class DeviceSimulatorPicker extends ConsumerWidget {
  final bool compact;

  const DeviceSimulatorPicker({
    super.key,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTier = ref.watch(simulatedTierProvider);
    final palette = AppPalette.of(context);

    final currentDevice = SimulatedDevice.values.firstWhere(
      (d) => d.targetTier == activeTier,
      orElse: () => SimulatedDevice.auto,
    );

    if (compact) {
      return PopupMenuButton<SimulatedDevice>(
        tooltip: 'Simulate Device Viewport',
        initialValue: currentDevice,
        icon: Icon(
          currentDevice.icon,
          size: 18,
          color: palette.textPrimary,
        ),
        onSelected: (device) {
          ref
              .read(appSettingsProvider.notifier)
              .setSimulatedTier(device.targetTier);
        },
        itemBuilder: (context) => SimulatedDevice.values.map((device) {
          final isSelected = device == currentDevice;
          return PopupMenuItem<SimulatedDevice>(
            value: device,
            child: Row(
              children: [
                Icon(
                  device.icon,
                  size: 18,
                  color: isSelected ? palette.accent : palette.textSecondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    device.label,
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: SimulatedDevice.values.map((device) {
          final isSelected = device == currentDevice;
          return Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: InkWell(
              borderRadius: AppTokens.radiusFull,
              onTap: () {
                ref
                    .read(appSettingsProvider.notifier)
                    .setSimulatedTier(device.targetTier);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? palette.actionBg : palette.surface,
                  borderRadius: AppTokens.radiusFull,
                  border: Border.all(
                    color: isSelected ? palette.accent : palette.border,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      device.icon,
                      size: 14,
                      color:
                          isSelected ? palette.actionFg : palette.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      device.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color:
                            isSelected ? palette.actionFg : palette.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
