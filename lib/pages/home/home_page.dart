import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entities/app_settings/app_settings.dart';
import '../../shared/shared.dart';
import '../../widgets/adaptive_scaffold/adaptive_scaffold.dart';
import '../../widgets/form_factor_preview/form_factor_preview.dart';
import 'views/desktop_home_view.dart';
import 'views/fold_home_view.dart';
import 'views/phone_home_view.dart';
import 'views/settings_view.dart';
import 'views/slices_view.dart';
import 'views/wearable_home_view.dart';

/// The central adaptive Home orchestrator.
///
/// Dispatches rendering across Wearable, Smartphone, Foldable, and Desktop/Web
/// tiers based on current viewport constraints or simulated device profile,
/// and hosts the Overview, Slices and Settings destinations.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _destinations = [
    NavigationDestinationItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
      label: 'Overview',
    ),
    NavigationDestinationItem(
      icon: Icons.layers_outlined,
      selectedIcon: Icons.layers_rounded,
      label: 'Slices',
    ),
    NavigationDestinationItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      label: 'Settings',
    ),
  ];

  /// Ctrl/⌘ + digit selects the destination at the same position.
  static const _destinationKeys = [
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
  ];

  int _currentNavIndex = 0;

  void _selectDestination(int index) {
    if (index == _currentNavIndex) return;
    setState(() => _currentNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final simulatedTier = ref.watch(simulatedTierProvider);
    final tier = simulatedTier ?? Breakpoints.getTier(context);

    final Widget overview = switch (tier) {
      ScreenTier.wearable => const WearableHomeView(),
      ScreenTier.compact => const PhoneHomeView(),
      ScreenTier.foldOrTablet => const FoldHomeView(),
      ScreenTier.desktopWeb => const DesktopHomeView(),
    };

    // The glanceable watch view has no navigation chrome, so the frame hosts
    // the device picker.
    if (tier == ScreenTier.wearable) {
      return FormFactorPreviewFrame(
        showDevicePicker: true,
        child: overview,
      );
    }

    final scaffold = AdaptiveScaffold(
      title: 'Agentic Template',
      selectedIndex: _currentNavIndex,
      onDestinationSelected: _selectDestination,
      destinations: _destinations,
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          overview,
          const SlicesView(),
          const SettingsView(),
        ],
      ),
    );

    return FormFactorPreviewFrame(
      child: CallbackShortcuts(
        bindings: {
          for (var i = 0; i < _destinationKeys.length; i++) ...{
            SingleActivator(_destinationKeys[i], control: true): () =>
                _selectDestination(i),
            SingleActivator(_destinationKeys[i], meta: true): () =>
                _selectDestination(i),
          },
        },
        child: Focus(
          autofocus: true,
          child: scaffold,
        ),
      ),
    );
  }
}
