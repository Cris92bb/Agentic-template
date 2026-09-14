import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

/// Slices destination: a map of the FSD layers and what each one contains.
class SlicesView extends StatelessWidget {
  const SlicesView({super.key});

  // Keep in sync with the folders under lib/.
  static const _layers = <({String name, String role, List<String> units})>[
    (
      name: 'app',
      role: 'Root widget, themes and scroll behavior.',
      units: ['theme'],
    ),
    (
      name: 'pages',
      role: 'Full-screen route targets.',
      units: ['home'],
    ),
    (
      name: 'widgets',
      role: 'Composite blocks orchestrating features and entities.',
      units: ['adaptive_scaffold', 'form_factor_preview'],
    ),
    (
      name: 'features',
      role: 'Discrete user actions.',
      units: ['device_simulator', 'sample_action', 'theme_toggle'],
    ),
    (
      name: 'entities',
      role: 'Domain models and state.',
      units: ['app_settings'],
    ),
    (
      name: 'shared',
      role: 'Tokens, primitives, breakpoints, storage and platform services.',
      units: ['api', 'lib', 'ui'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(AppTokens.spaceLg),
          children: [
            Text(
              'Slices',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: palette.textPrimary,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Each layer may only import from the layers below it, and slices only through their public barrel.',
              style: TextStyle(
                fontSize: 13,
                color: palette.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppTokens.spaceMd),
            for (final layer in _layers) ...[
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            layer.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: palette.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppTokens.spaceSm),
                        StatusBadge(
                          label: layer.name == 'app' || layer.name == 'shared'
                              ? '${layer.units.length} segments'
                              : '${layer.units.length} slices',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      layer.role,
                      style: TextStyle(
                        fontSize: 13,
                        color: palette.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppTokens.spaceSm),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final unit in layer.units)
                          StatusBadge(label: unit, tone: BadgeTone.primary),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTokens.spaceSm),
            ],
          ],
        ),
      ),
    );
  }
}
