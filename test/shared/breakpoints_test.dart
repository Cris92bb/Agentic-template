import 'package:agentic_template/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breakpoints & ScreenTier Resolution', () {
    testWidgets('resolves wearable tier for small displays <= 320px', (tester) async {
      tester.view.physicalSize = const Size(280, 280);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final tier = Breakpoints.getTier(context);
              expect(tier, equals(ScreenTier.wearable));
              expect(Breakpoints.isWearable(context), isTrue);
              expect(Breakpoints.isCompact(context), isFalse);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('resolves compact tier for smartphone widths (321px - 599px)', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final tier = Breakpoints.getTier(context);
              expect(tier, equals(ScreenTier.compact));
              expect(Breakpoints.isCompact(context), isTrue);
              expect(Breakpoints.isWearable(context), isFalse);
              expect(Breakpoints.isWide(context), isFalse);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('resolves foldOrTablet tier for widths (600px - 1023px)', (tester) async {
      tester.view.physicalSize = const Size(760, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final tier = Breakpoints.getTier(context);
              expect(tier, equals(ScreenTier.foldOrTablet));
              expect(Breakpoints.isFoldOrTablet(context), isTrue);
              expect(Breakpoints.isWide(context), isTrue);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('resolves desktopWeb tier for wide displays >= 1024px', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final tier = Breakpoints.getTier(context);
              expect(tier, equals(ScreenTier.desktopWeb));
              expect(Breakpoints.isDesktopWeb(context), isTrue);
              expect(Breakpoints.isWide(context), isTrue);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
