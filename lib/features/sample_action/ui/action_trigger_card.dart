import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/shared.dart';
import '../state/counter_controller.dart';

/// Clean feature card showcasing atomic interaction and state dispatch.
class ActionTriggerCard extends ConsumerStatefulWidget {
  final bool compact;

  const ActionTriggerCard({
    super.key,
    this.compact = false,
  });

  @override
  ConsumerState<ActionTriggerCard> createState() => _ActionTriggerCardState();
}

class _ActionTriggerCardState extends ConsumerState<ActionTriggerCard> {
  // Rebuilds periodically so the relative "Updated ..." label stays accurate
  // even when the counter does not change.
  late final Timer _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterState = ref.watch(counterProvider);
    final controller = ref.read(counterProvider.notifier);
    final palette = AppPalette.of(context);
    final canDecrement = counterState.count > 0;

    if (widget.compact) {
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
                color: palette.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline_rounded),
                  iconSize: 24,
                  onPressed: canDecrement ? controller.decrement : null,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  iconSize: 24,
                  color: palette.accent,
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
            children: [
              Expanded(
                child: Text(
                  'Sample Action Slice',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: palette.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const SizedBox(width: AppTokens.spaceSm),
              StatusBadge(
                label: 'Count: ${counterState.count}',
                tone: canDecrement ? BadgeTone.success : BadgeTone.neutral,
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spaceSm),
          Text(
            'This feature demonstrates a clean, encapsulated action slice with local riverpod state. Updated ${DateHelpers.timeAgo(counterState.lastUpdated)}.',
            style: TextStyle(
              fontSize: 13,
              color: palette.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppTokens.spaceMd),
          // Wrap instead of Row so the buttons flow onto a new line on narrow
          // cards (phone, fold detail pane) instead of overflowing.
          Wrap(
            spacing: AppTokens.spaceSm,
            runSpacing: AppTokens.spaceSm,
            children: [
              AppButton(
                label: 'Increment',
                icon: Icons.add_rounded,
                onPressed: controller.increment,
              ),
              AppButton.secondary(
                label: 'Decrement',
                icon: Icons.remove_rounded,
                onPressed: canDecrement ? controller.decrement : null,
              ),
              if (canDecrement)
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
