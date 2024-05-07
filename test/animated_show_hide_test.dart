import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('AnimatedShowHide', () {
    testWidgets('default values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedShowHide(
            child: Container(),
          ),
        ),
      );

      final animatedShowHideFinder = find.byType(AnimatedShowHide);
      final sizeTransitionFinder = find.byType(SizeTransition);
      final containerFinder = find.byType(Container);

      expect(animatedShowHideFinder, findsOneWidget);
      expect(sizeTransitionFinder, findsOneWidget);
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('without animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedShowHide(
            animate: false,
            child: Container(),
          ),
        ),
      );

      final animatedShowHideFinder = find.byType(AnimatedShowHide);
      final sizeTransitionFinder = find.byType(SizeTransition);
      final containerFinder = find.byType(Container);

      expect(animatedShowHideFinder, findsOneWidget);
      expect(sizeTransitionFinder, findsNothing);
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('with custom animation duration', (WidgetTester tester) async {
      const customDuration = Duration(milliseconds: 500);

      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedShowHide(
            duration: customDuration,
            child: Container(),
          ),
        ),
      );

      final animatedShowHideFinder = find.byType(AnimatedShowHide);
      final sizeTransitionFinder = find.byType(SizeTransition);
      final containerFinder = find.byType(Container);

      expect(animatedShowHideFinder, findsOneWidget);
      expect(sizeTransitionFinder, findsOneWidget);
      expect(containerFinder, findsOneWidget);

      await tester.pump(const Duration(milliseconds: 600));
      expect(
        tester
            .widget<AnimatedShowHide>(
              find.byType(AnimatedShowHide),
            )
            .duration,
        customDuration,
      );
    });

    testWidgets('widget animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedShowHide(
            duration: const Duration(milliseconds: 10),
            child: Container(),
          ),
        ),
      );

      final animatedShowHideFinder = find.byType(AnimatedShowHide);
      final sizeTransitionFinder = find.byType(SizeTransition);
      final containerFinder = find.byType(Container);

      expect(animatedShowHideFinder, findsOneWidget);
      expect(sizeTransitionFinder, findsOneWidget);
      expect(containerFinder, findsOneWidget);
      await tester.pumpAndSettle(const Duration(milliseconds: 80));
      final sizeTransition =
          tester.widget<SizeTransition>(sizeTransitionFinder);
      expect(sizeTransition.sizeFactor.value, equals(1.0)); // Fully visible

      await tester.pumpWidget(
        AnimatedShowHide(
          animate: false,
          child: Container(),
        ),
      );

      expect(sizeTransitionFinder, findsNothing); // No longer animating
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('widget disposal', (WidgetTester tester) async {
      final gloabalKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AnimatedShowHide(
                key: gloabalKey,
                // ignore: avoid_redundant_argument_values
                animate: true,
                child: Container(),
              );
            },
          ),
        ),
      );

      final animatedShowHideFinder = find.byType(AnimatedShowHide);
      final sizeTransitionFinder = find.byType(SizeTransition);
      final containerFinder = find.byType(Container);
      final sizedBoxFinder = find.byType(SizedBox);

      expect(animatedShowHideFinder, findsOneWidget);
      expect(sizeTransitionFinder, findsOneWidget);
      expect(containerFinder, findsOneWidget);
      expect(sizedBoxFinder, findsNothing);

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AnimatedShowHide(
                key: gloabalKey,
                duration: const Duration(milliseconds: 10),
                // ignore: avoid_redundant_argument_values
                animate: true,
                // ignore: avoid_redundant_argument_values
                child: null,
              );
            },
          ),
        ),
        const Duration(milliseconds: 10),
      );

      await tester.pumpAndSettle();
      final sizedBoxFinder0 = find.byType(SizedBox);
      final containerFinder0 = find.byType(Container);
      expect(sizedBoxFinder0, findsOneWidget);
      expect(containerFinder0, findsNothing);
    });
  });
}
