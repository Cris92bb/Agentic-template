import 'package:agentic_template/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpApp(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(const ProviderScope(child: AgenticApp()));
  await tester.pumpAndSettle();
}

/// Taps a device chip in the wide header picker.
Future<void> _tapDeviceChip(WidgetTester tester, String label) async {
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

/// Selects a device from the compact popup picker.
Future<void> _selectFromPopup(WidgetTester tester, String label) async {
  await tester.tap(find.byTooltip('Simulate Device Viewport'));
  await tester.pumpAndSettle();
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
}

void main() {
  group('HomePage smoke tests', () {
    testWidgets('phone layout has no overflow after incrementing the counter',
        (tester) async {
      await _pumpApp(tester, const Size(390, 844));
      await tester.tap(find.text('Increment'));
      await tester.pumpAndSettle();

      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('fold layout has no overflow after incrementing the counter',
        (tester) async {
      await _pumpApp(tester, const Size(720, 900));
      await tester.tap(find.text('Increment'));
      await tester.pumpAndSettle();

      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('watch simulation keeps the device picker reachable',
        (tester) async {
      await _pumpApp(tester, const Size(1280, 800));
      await _tapDeviceChip(tester, 'Watch (Wear OS)');
      expect(find.text('WATCH VIEW'), findsOneWidget);

      await _selectFromPopup(tester, 'Auto Detect');
      expect(find.text('WATCH VIEW'), findsNothing);
    });

    testWidgets('simulation banner is not rendered with the error text style',
        (tester) async {
      await _pumpApp(tester, const Size(1280, 800));
      await _tapDeviceChip(tester, 'Smartphone');

      final bannerContext = tester.element(find.textContaining('Simulating'));
      expect(
        DefaultTextStyle.of(bannerContext).style.decoration,
        isNot(TextDecoration.underline),
      );
    });

    testWidgets('phone simulation reports the inner viewport size of the frame',
        (tester) async {
      await _pumpApp(tester, const Size(1280, 800));
      await _tapDeviceChip(tester, 'Smartphone');

      final viewContext = tester.element(find.text('Smartphone Tier (Compact)'));
      expect(MediaQuery.sizeOf(viewContext), const Size(374, 764));
    });

    testWidgets('desktop simulation in a narrow window has no overflow',
        (tester) async {
      await _pumpApp(tester, const Size(390, 844));
      await _selectFromPopup(tester, 'Desktop / Web');

      expect(find.text('Desktop & Web Workspace (Tier 4)'), findsOneWidget);
    });
  });
}
