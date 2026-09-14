import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/sample_action/sample_action.dart';
import '../../../shared/shared.dart';

/// Optimized, glanceable smartwatch interface designed for circular Wear OS displays.
class WearableHomeView extends ConsumerWidget {
  const WearableHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);
    final controller = ref.read(counterProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final circularPadding = WearableUtils.getSafeCircularPadding(context);

    final textPrimary =
        isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary;
    final textSecondary =
        isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary;

    return Scaffold(
      backgroundColor: isDark ? AppTokens.darkCanvasBg : AppTokens.lightCanvasBg,
      body: Center(
        child: Padding(
          padding: circularPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Watch Glanceable Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.watch_rounded,
                    size: 14,
                    color: AppTokens.primaryLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'WATCH VIEW',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Large Glanceable Counter Digit
              Text(
                '${counterState.count}',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: textPrimary,
                  height: 1.0,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Taps recorded',
                style: TextStyle(
                  fontSize: 10,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 10),

              // Watch Quick Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline_rounded),
                    iconSize: 28,
                    color: textSecondary,
                    onPressed: counterState.count > 0 ? controller.decrement : null,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: AppTokens.radiusFull,
                    onTap: controller.increment,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? AppTokens.darkActionBg
                            : AppTokens.lightActionBg,
                        boxShadow: AppTokens.floatingShadow,
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
