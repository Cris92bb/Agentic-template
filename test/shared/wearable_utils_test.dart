import 'package:agentic_template/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WearableUtils', () {
    testWidgets('identifies wearable viewport correctly', (tester) async {
      tester.view.physicalSize = const Size(200, 200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(WearableUtils.isWearable(context), isTrue);
              final padding = WearableUtils.getSafeCircularPadding(context);
              expect(padding.horizontal, greaterThan(0));
              expect(padding.vertical, greaterThan(0));
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('identifies non-wearable viewport correctly', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(WearableUtils.isWearable(context), isFalse);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
