import 'package:flutter/material.dart';
import '../../../features/sample_action/sample_action.dart';
import '../../../shared/shared.dart';

/// Dual-pane master-detail layout optimized for unfolded foldable devices and tablets.
class FoldHomeView extends StatelessWidget {
  const FoldHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textPrimary =
        isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary;
    final textSecondary =
        isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary;
    final borderCol =
        isDark ? AppTokens.darkBorder : AppTokens.lightBorder;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Master / Navigation Side Pane (Flex 5)
        Expanded(
          flex: 5,
          child: ListView(
            padding: const EdgeInsets.all(AppTokens.spaceLg),
            children: [
              AppCard(
                backgroundColor: isDark
                    ? AppTokens.darkSurfaceBg
                    : AppTokens.lightSurfaceBg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.laptop_chromebook_rounded,
                          color: AppTokens.primaryLight,
                          size: 20,
                        ),
                        const SizedBox(width: AppTokens.spaceSm),
                        Text(
                          'Foldable Tier (Dual Pane)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTokens.spaceSm),
                    Text(
                      'Optimized for foldable devices when unfolded (600px - 1023px). The screen gracefully partitions into master and detail work surfaces.',
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppTokens.spaceMd),

              // Architectural overview
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Architecture',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTokens.spaceSm),
                    const StatusBadge(
                      label: 'Zero Coupling Across Slices',
                      tone: BadgeTone.success,
                      icon: Icons.check_circle_rounded,
                    ),
                    const SizedBox(height: AppTokens.spaceSm),
                    Text(
                      'Feature slices communicate strictly through entity models or page/widget composition.',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Subtle Hinge / Fold Divider Line
        VerticalDivider(
          width: 1.0,
          thickness: 1.0,
          color: borderCol,
        ),

        // Detail / Action Pane (Flex 6)
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(AppTokens.spaceLg),
            children: const [
              ActionTriggerCard(),
            ],
          ),
        ),
      ],
    );
  }
}
