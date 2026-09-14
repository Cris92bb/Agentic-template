import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/shared.dart';
import '../state/counter_controller.dart';

/// Clean feature card showcasing atomic interaction and state dispatch.
class ActionTriggerCard extends ConsumerWidget {
  final bool compact;

  const ActionTriggerCard({
    super.key,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);
    final controller = ref.read(counterProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textPrimary =
        isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary;
    final textSecondary =
        isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary;

    if (compact) {
      return AppCard(
        padding: const EdgeInsets.all(AppTokens.spaceSm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${counterState.count}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline_rounded),
                  iconSize: 24,
                  onPressed: controller.decrement,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  iconSize: 24,
                  color: AppTokens.primaryLight,
                  onPressed: controller.increment,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sample Action Slice',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              StatusBadge(
                label: 'Count: ${counterState.count}',
                tone: counterState.count > 0
                    ? BadgeTone.success
                    : BadgeTone.neutral,
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spaceSm),
          Text(
            'This feature demonstrates a clean, encapsulated action slice with local riverpod state. Updated ${DateHelpers.timeAgo(counterState.lastUpdated)}.',
            style: TextStyle(
              fontSize: 13,
              color: textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppTokens.spaceMd),
          Row(
            children: [
              AppButton(
                label: 'Increment',
                icon: Icons.add_rounded,
                onPressed: controller.increment,
              ),
              const SizedBox(width: AppTokens.spaceSm),
              AppButton.secondary(
                label: 'Decrement',
                icon: Icons.remove_rounded,
                onPressed: counterState.count > 0 ? controller.decrement : null,
              ),
              const Spacer(),
              if (counterState.count > 0)
                AppButton.ghost(
                  label: 'Reset',
                  icon: Icons.refresh_rounded,
                  onPressed: controller.reset,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
