import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../entities/app_settings/app_settings.dart';
import '../../../features/device_simulator/device_simulator.dart';
import '../../../shared/shared.dart';

/// Viewport used when Desktop / Web is simulated in a window narrower than the
/// desktop breakpoint, so the desktop layout never renders in a phone-sized box.
const Size _desktopFallbackPreviewSize = Size(1280, 800);

/// Renders a simulated hardware frame (circular watch, phone frame, fold bezel)
/// when an in-app simulated device profile is active.
class FormFactorPreviewFrame extends ConsumerWidget {
  final Widget child;

  /// Shows the device picker next to the preview banner, for children that do
  /// not host their own picker (e.g. the watch view).
  final bool showDevicePicker;

  const FormFactorPreviewFrame({
    super.key,
    required this.child,
    this.showDevicePicker = false,
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

    final isNarrowWindow =
        MediaQuery.sizeOf(context).width < Breakpoints.foldOrTabletMax;
    final size = device.previewSize ??
        (device == SimulatedDevice.desktop && isNarrowWindow
            ? _desktopFallbackPreviewSize
            : null);

    if (size == null) {
      return child;
    }

    final isWatch = device == SimulatedDevice.watchRound;
    final bezelWidth = isWatch ? 12.0 : 8.0;
    // The bezel is drawn inside the frame, so the child only gets the inner area.
    final viewportSize = Size(
      size.width - bezelWidth * 2,
      size.height - bezelWidth * 2,
    );

    return Material(
      color: isDark ? AppTokens.darkCanvasBg : AppTokens.lightCanvasBg,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.spaceLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Preview header banner
              Padding(
                padding: const EdgeInsets.only(bottom: AppTokens.spaceSm),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppTokens.darkSurfaceBg
                              : AppTokens.lightSurfaceBg,
                          borderRadius: AppTokens.radiusFull,
                          border: Border.all(
                            color: isDark
                                ? AppTokens.darkBorder
                                : AppTokens.lightBorder,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              device.icon,
                              size: 14,
                              color: AppTokens.primaryLight,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'Simulating ${device.label} (${size.width.toInt()}×${size.height.toInt()})',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppTokens.darkTextSecondary
                                      : AppTokens.lightTextSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (showDevicePicker) ...[
                      const SizedBox(width: AppTokens.spaceXs),
                      const DeviceSimulatorPicker(compact: true),
                    ],
                  ],
                ),
              ),

              // Frame container, scaled down when the window is smaller than it
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  width: size.width,
                  height: size.height,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTokens.darkCanvasBg
                        : AppTokens.lightCanvasBg,
                    shape: isWatch ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: isWatch ? null : AppTokens.radiusXl,
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFF1E293B),
                      width: bezelWidth,
                    ),
                    boxShadow: AppTokens.floatingShadow,
                  ),
                  child: ClipRRect(
                    borderRadius: isWatch
                        ? BorderRadius.circular(viewportSize.width / 2)
                        : BorderRadius.circular(24.0),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        size: viewportSize,
                        padding: EdgeInsets.zero,
                        viewPadding: EdgeInsets.zero,
                        viewInsets: EdgeInsets.zero,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
