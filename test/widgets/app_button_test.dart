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

    testWidgets('does not fire onPressed when disabled', (tester) async {
      bool pressed = false;

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

      await tester.tap(find.text('Disabled Button'));
      await tester.pump();

      expect(pressed, isFalse);
    });
  });
}
