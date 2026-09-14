import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entities/app_settings/app_settings.dart';
import '../../shared/shared.dart';
import '../../widgets/adaptive_scaffold/adaptive_scaffold.dart';
import '../../widgets/form_factor_preview/form_factor_preview.dart';
import 'views/desktop_home_view.dart';
import 'views/fold_home_view.dart';
import 'views/phone_home_view.dart';
import 'views/wearable_home_view.dart';

/// The central adaptive Home orchestrator.
///
/// Dispatches rendering across Wearable, Smartphone, Foldable, and Desktop/Web
/// tiers based on current viewport constraints or simulated device profile.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final simulatedTier = ref.watch(simulatedTierProvider);
    final tier = simulatedTier ?? Breakpoints.getTier(context);

    // If active tier is Wearable, display the watch-optimized glanceable view
    if (tier == ScreenTier.wearable) {
      // The watch view has no app bar, so the frame hosts the device picker.
      return const FormFactorPreviewFrame(
        showDevicePicker: true,
        child: WearableHomeView(),
      );
    }

    // Determine main view based on form factor tier
    Widget tierView;
    switch (tier) {
      case ScreenTier.compact:
        tierView = const PhoneHomeView();
        break;
      case ScreenTier.foldOrTablet:
        tierView = const FoldHomeView();
        break;
      case ScreenTier.desktopWeb:
      default:
        tierView = const DesktopHomeView();
        break;
    }

    final scaffold = AdaptiveScaffold(
      title: 'Agentic Template',
      selectedIndex: _currentNavIndex,
      onDestinationSelected: (index) {
        setState(() => _currentNavIndex = index);
      },
      destinations: const [
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
      ],
      body: tierView,
    );

    return FormFactorPreviewFrame(
      child: scaffold,
    );
  }
}
