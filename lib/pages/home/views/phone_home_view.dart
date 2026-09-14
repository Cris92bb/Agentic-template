import 'package:flutter/material.dart';
import '../../../features/sample_action/sample_action.dart';
import '../../../shared/shared.dart';

/// Single-column mobile layout optimized for smartphones and folded devices.
class PhoneHomeView extends StatelessWidget {
  const PhoneHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textPrimary =
        isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary;
    final textSecondary =
        isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary;

    return ListView(
      padding: const EdgeInsets.all(AppTokens.spaceMd),
      children: [
        // Form factor introduction banner
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
                    Icons.phone_android_rounded,
                    color: AppTokens.primaryLight,
                    size: 20,
                  ),
                  const SizedBox(width: AppTokens.spaceSm),
                  Expanded(
                    child: Text(
                      'Smartphone Tier (Compact)',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.spaceSm),
              Text(
                'This single-column view adapts automatically to standard phone screens and folded foldables (< 600px). Navigation is hosted via bottom navigation bar.',
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

        // Action feature card
        const ActionTriggerCard(),

        const SizedBox(height: AppTokens.spaceMd),

        // Architecture info card
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Feature-Sliced Design',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTokens.spaceSm),
                  const StatusBadge(
                    label: 'FSD v2.1',
                    tone: BadgeTone.primary,
                  ),
                ],
              ),
              const SizedBox(height: AppTokens.spaceSm),
              Text(
                'Layers: app ≻ pages ≻ widgets ≻ features ≻ entities ≻ shared. Zero upward inversions, cross-slice couplings and deep imports, enforced by tool/verify_fsd.dart.',
                style: TextStyle(
                  fontSize: 13,
                  color: textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
