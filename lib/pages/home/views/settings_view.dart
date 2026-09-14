import 'package:flutter/material.dart';
import '../../../features/device_simulator/device_simulator.dart';
import '../../../features/theme_toggle/theme_toggle.dart';
import '../../../shared/shared.dart';

/// Settings destination: appearance preferences and the device simulator.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: palette.textPrimary,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: AppTokens.spaceMd),
            AppCard(
              child: Column(
                children: [
                  const _SettingRow(
                    title: 'Theme',
                    subtitle: 'Follow the system or force light or dark mode.',
                    control: ThemeToggleButton(showMenu: true),
                  ),
                  Divider(height: AppTokens.spaceLg, color: palette.border),
                  const _SettingRow(
                    title: 'High contrast',
                    subtitle: 'Stronger text, border and accent colors.',
                    control: HighContrastSwitch(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTokens.spaceMd),
            const AppCard(
              child: _SettingRow(
                title: 'Device simulator',
                subtitle:
                    'Preview the watch, phone, foldable and desktop layouts.',
                control: DeviceSimulatorPicker(compact: true),
              ),
            ),
            const SizedBox(height: AppTokens.spaceMd),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keyboard shortcuts',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: palette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Ctrl + 1, 2, 3 (⌘ on macOS) switch between Overview, Slices and Settings.',
                    style: TextStyle(
                      fontSize: 13,
                      color: palette.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget control;

  const _SettingRow({
    required this.title,
    required this.subtitle,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: palette.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: palette.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.spaceMd),
        control,
      ],
    );
  }
}
