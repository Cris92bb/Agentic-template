import 'package:agentic_template/widgets/adaptive_scaffold/adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdaptiveScaffold', () {
    testWidgets('renders navigation destinations and title in compact mode', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      int selected = 0;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AdaptiveScaffold(
              title: 'Test App',
              selectedIndex: selected,
              onDestinationSelected: (i) => selected = i,
              destinations: const [
                NavigationDestinationItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Home',
                ),
                NavigationDestinationItem(
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  label: 'Settings',
                ),
              ],
              body: const Text('Body Content'),
            ),
          ),
        ),
      );

      expect(find.text('Test App'), findsOneWidget);
      expect(find.text('Body Content'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('renders NavigationRail in desktop mode', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AdaptiveScaffold(
              title: 'Desktop App',
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const [
                NavigationDestinationItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Home',
                ),
                NavigationDestinationItem(
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  label: 'Settings',
                ),
              ],
              body: const Text('Desktop Workspace'),
            ),
          ),
        ),
      );

      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.text('Desktop Workspace'), findsOneWidget);
    });
  });
}
