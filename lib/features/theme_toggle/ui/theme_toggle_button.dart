import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../entities/app_settings/app_settings.dart';
import '../../../shared/shared.dart';

/// Interactive button to toggle or select theme mode.
class ThemeToggleButton extends ConsumerWidget {
  final bool showMenu;

  const ThemeToggleButton({
    super.key,
    this.showMenu = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (showMenu) {
      return PopupMenuButton<ThemeMode>(
        tooltip: 'Select Theme',
        initialValue: themeMode,
        icon: Icon(
          isDark ? Icons.nightlight_round : Icons.wb_sunny_outlined,
          size: 18,
          color: isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary,
        ),
        onSelected: (mode) {
          ref.read(appSettingsProvider.notifier).setThemeMode(mode);
        },
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: ThemeMode.system,
            child: Row(
              children: [
                Icon(Icons.brightness_auto_rounded, size: 18),
                SizedBox(width: 8),
                Text('System Default'),
              ],
            ),
          ),
          PopupMenuItem(
            value: ThemeMode.light,
            child: Row(
              children: [
                Icon(Icons.wb_sunny_outlined, size: 18),
                SizedBox(width: 8),
                Text('Light Mode'),
              ],
            ),
          ),
          PopupMenuItem(
            value: ThemeMode.dark,
            child: Row(
              children: [
                Icon(Icons.nightlight_round, size: 18),
                SizedBox(width: 8),
                Text('Dark Mode'),
              ],
            ),
          ),
        ],
      );
    }

    return Semantics(
      button: true,
      label: 'Toggle theme mode',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTokens.radiusFull,
          onTap: () {
            final next = isDark ? ThemeMode.light : ThemeMode.dark;
            ref.read(appSettingsProvider.notifier).setThemeMode(next);
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppTokens.darkSurfaceBg : AppTokens.lightSurfaceBg,
              border: Border.all(
                color: isDark ? AppTokens.darkBorder : AppTokens.lightBorder,
                width: 1.0,
              ),
            ),
            child: Icon(
              isDark ? Icons.nightlight_round : Icons.wb_sunny_outlined,
              size: 16,
              color: isDark ? AppTokens.darkTextPrimary : AppTokens.lightTextPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
