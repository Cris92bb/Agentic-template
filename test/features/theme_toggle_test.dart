import 'package:agentic_template/entities/app_settings/app_settings.dart';
import 'package:agentic_template/features/theme_toggle/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<ProviderContainer> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: Center(child: child)),
      ),
    ),
  );
  return ProviderScope.containerOf(tester.element(find.byWidget(child)));
}

void main() {
  group('ThemeToggleButton', () {
    test('cycles System -> Light -> Dark -> System', () {
      expect(ThemeToggleButton.nextMode(ThemeMode.system), ThemeMode.light);
      expect(ThemeToggleButton.nextMode(ThemeMode.light), ThemeMode.dark);
      expect(ThemeToggleButton.nextMode(ThemeMode.dark), ThemeMode.system);
    });

    testWidgets('round button can return to the system theme', (tester) async {
      final container = await _pump(tester, const ThemeToggleButton());

      for (final expected in [
        ThemeMode.light,
        ThemeMode.dark,
        ThemeMode.system,
      ]) {
        await tester.tap(find.byType(ThemeToggleButton));
        await tester.pump();
        expect(container.read(themeModeProvider), expected);
      }
    });

    testWidgets('round button has a 44x44 touch target', (tester) async {
      await _pump(tester, const ThemeToggleButton());

      expect(tester.getSize(find.byType(ThemeToggleButton)), const Size(44, 44));
    });
  });

  group('HighContrastSwitch', () {
    testWidgets('toggles the high contrast preference', (tester) async {
      final container = await _pump(tester, const HighContrastSwitch());
      expect(container.read(highContrastProvider), isFalse);

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(container.read(highContrastProvider), isTrue);
    });
  });
}
