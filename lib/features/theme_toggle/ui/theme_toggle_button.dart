import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../entities/app_settings/app_settings.dart';
import '../../../shared/shared.dart';

/// Interactive button to cycle or select the theme mode.
///
/// The round button cycles System → Light → Dark; with [showMenu] it opens a
/// menu listing the three modes instead.
class ThemeToggleButton extends ConsumerWidget {
  final bool showMenu;

  const ThemeToggleButton({
    super.key,
    this.showMenu = false,
  });

  /// Mode selected by the next tap on the round button.
  static ThemeMode nextMode(ThemeMode mode) => switch (mode) {
        ThemeMode.system => ThemeMode.light,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
      };

  static IconData _iconFor(ThemeMode mode) => switch (mode) {
        ThemeMode.system => Icons.brightness_auto_rounded,
        ThemeMode.light => Icons.wb_sunny_outlined,
        ThemeMode.dark => Icons.nightlight_round,
      };

  static String _labelFor(ThemeMode mode) => switch (mode) {
        ThemeMode.system => 'System Default',
        ThemeMode.light => 'Light Mode',
        ThemeMode.dark => 'Dark Mode',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final palette = AppPalette.of(context);

    if (showMenu) {
      return PopupMenuButton<ThemeMode>(
        tooltip: 'Select Theme',
        initialValue: themeMode,
        icon: Icon(
          _iconFor(themeMode),
          size: 18,
          color: palette.textPrimary,
        ),
        onSelected: (mode) {
          ref.read(appSettingsProvider.notifier).setThemeMode(mode);
        },
        itemBuilder: (context) => [
          for (final mode in ThemeMode.values)
            PopupMenuItem(
              value: mode,
              child: Row(
                children: [
                  Icon(_iconFor(mode), size: 18),
                  const SizedBox(width: 8),
                  Text(_labelFor(mode)),
                ],
              ),
            ),
        ],
      );
    }

    final next = nextMode(themeMode);

    return Tooltip(
      message: 'Theme: ${_labelFor(themeMode)}',
      child: Semantics(
        button: true,
        label:
            'Theme: ${_labelFor(themeMode)}. Activate to switch to ${_labelFor(next)}.',
        excludeSemantics: true,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              ref.read(appSettingsProvider.notifier).setThemeMode(next);
            },
            // 44×44 minimum touch target.
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: palette.surface,
                border: Border.all(color: palette.border, width: 1.0),
              ),
              child: Icon(
                _iconFor(themeMode),
                size: 18,
                color: palette.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
