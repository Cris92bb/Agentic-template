import 'package:agentic_template/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppButton Primitive', () {
    testWidgets('fires onPressed callback when tapped', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Submit Action',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Submit Action'), findsOneWidget);
      await tester.tap(find.text('Submit Action'));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('is not tappable when onPressed is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Disabled Button',
              onPressed: null,
            ),
          ),
        ),
      );

      final inkWell = tester.widget<InkWell>(
        find.descendant(
          of: find.byType(AppButton),
          matching: find.byType(InkWell),
        ),
      );
      expect(inkWell.onTap, isNull);
    });

    testWidgets('does not fire onPressed while loading', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Loading Button',
              isLoading: true,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Loading Button'));
      await tester.pump();

      expect(pressed, isFalse);
    });
  });
}
