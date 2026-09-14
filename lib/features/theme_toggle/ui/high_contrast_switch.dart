import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../entities/app_settings/app_settings.dart';

/// Switch bound to the persisted high-contrast preference.
class HighContrastSwitch extends ConsumerWidget {
  const HighContrastSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(highContrastProvider);

    return Switch(
      value: enabled,
      onChanged: (value) {
        if (value != enabled) {
          ref.read(appSettingsProvider.notifier).toggleHighContrast();
        }
      },
    );
  }
}
