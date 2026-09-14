import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../entities/app_settings/app_settings.dart';
import '../../../features/device_simulator/device_simulator.dart';
import '../../../shared/shared.dart';

/// Renders a simulated hardware frame (circular watch, phone frame, fold bezel)
/// when an in-app simulated device profile is active.
class FormFactorPreviewFrame extends ConsumerWidget {
  final Widget child;

  const FormFactorPreviewFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTier = ref.watch(simulatedTierProvider);

    if (activeTier == null) {
      // Natural responsive layout
      return child;
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final device = SimulatedDevice.values.firstWhere(
      (d) => d.targetTier == activeTier,
      orElse: () => SimulatedDevice.auto,
    );

    if (device.previewSize == null) {
      return child;
    }

    final size = device.previewSize!;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.spaceLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Preview header banner
            Container(
              margin: const EdgeInsets.only(bottom: AppTokens.spaceSm),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? AppTokens.darkSurfaceBg : AppTokens.lightSurfaceBg,
                borderRadius: AppTokens.radiusFull,
                border: Border.all(
                  color: isDark ? AppTokens.darkBorder : AppTokens.lightBorder,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(device.icon, size: 14, color: AppTokens.primaryLight),
                  const SizedBox(width: 6),
                  Text(
                    'Simulating ${device.label} (${size.width.toInt()}×${size.height.toInt()})',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppTokens.darkTextSecondary
                          : AppTokens.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Frame container
            Container(
              width: size.width,
              height: size.height,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: isDark ? AppTokens.darkCanvasBg : AppTokens.lightCanvasBg,
                shape: device == SimulatedDevice.watchRound
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius: device == SimulatedDevice.watchRound
                    ? null
                    : AppTokens.radiusXl,
                border: Border.all(
                  color: isDark ? const Color(0xFF334155) : const Color(0xFF1E293B),
                  width: device == SimulatedDevice.watchRound ? 12.0 : 8.0,
                ),
                boxShadow: AppTokens.floatingShadow,
              ),
              child: ClipRRect(
                borderRadius: device == SimulatedDevice.watchRound
                    ? BorderRadius.circular(size.width / 2)
                    : BorderRadius.circular(24.0),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    size: size,
                  ),
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
