import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../features/sample_action/sample_action.dart';
import '../../../shared/shared.dart';

/// Multi-column desktop and web workspace view.
class DesktopHomeView extends StatelessWidget {
  const DesktopHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textPrimary =
        isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary;
    final textSecondary =
        isDark ? AppTokens.darkTextSecondary : AppTokens.lightTextSecondary;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.desktopMaxWidth,
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppTokens.spaceXl),
          children: [
            // Welcome Hero Card
            AppCard(
              backgroundColor: isDark
                  ? AppTokens.darkSurfaceBg
                  : AppTokens.lightSurfaceBg,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTokens.primaryLight.withValues(alpha: 0.2),
                      borderRadius: AppTokens.radiusMd,
                    ),
                    child: const Icon(
                      Icons.desktop_windows_rounded,
                      color: AppTokens.primaryLight,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: AppTokens.spaceMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Desktop & Web Workspace (Tier 4)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: textPrimary,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Expanded multi-column layout for Linux GTK desktop and Web browsers (>= 1024px). Equipped with navigation rail and device simulator.',
                          style: TextStyle(
                            fontSize: 13,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppTokens.spaceMd),
                  const StatusBadge(
                    label: 'Linux + Web Ready',
                    tone: BadgeTone.info,
                    icon: Icons.check_circle_outline,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTokens.spaceLg),

            // Two-column dashboard content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Interactive Action Slice
                const Expanded(
                  flex: 6,
                  child: ActionTriggerCard(),
                ),

                const SizedBox(width: AppTokens.spaceLg),

                // Right Column: Platform & Agent Features
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // Desktop integration card
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.terminal_rounded,
                                  size: 18,
                                  color: AppTokens.accentSuccess,
                                ),
                                const SizedBox(width: AppTokens.spaceSm),
                                Expanded(
                                  child: Text(
                                    'Linux Platform Integration',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppTokens.spaceSm),
                            Text(
                              'Native GTK runner wired with MethodChannel("app/theme") for live desktop theme sync and MethodChannel("app/window") for dragging and resizing.',
                              style: TextStyle(
                                fontSize: 13,
                                color: textSecondary,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: AppTokens.spaceSm),
                            const StatusBadge(
                              label: kIsWeb ? 'Running on Web' : 'Native Platform',
                              tone: BadgeTone.neutral,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppTokens.spaceMd),

                      // Agentic paired programming card
                      AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.smart_toy_outlined,
                                  size: 18,
                                  color: AppTokens.primaryLight,
                                ),
                                const SizedBox(width: AppTokens.spaceSm),
                                Expanded(
                                  child: Text(
                                    'Optimized for Agentic Development',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppTokens.spaceSm),
                            Text(
                              'Equipped with AGENTS.md, GEMINI.md, .agents/rules, and the verify_fsd.dart import scanner so autonomous coding agents never break architectural boundaries.',
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
