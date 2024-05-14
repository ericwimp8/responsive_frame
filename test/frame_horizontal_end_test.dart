import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('FrameHorizontalEnd', () {
    testWidgets('FrameHorizontalEnd renders child widget',
        (WidgetTester tester) async {
      const childWidget = Text('Hello, world!');
      const frameHorizontalEnd = FrameHorizontalEnd(child: childWidget);
      await tester.pumpWidget(const MaterialApp(home: frameHorizontalEnd));
      expect(find.byWidget(childWidget), findsOneWidget);
    });

    testWidgets('FrameHorizontalEnd renders top widget if not null',
        (WidgetTester tester) async {
      const topWidget = Text('Top widget');
      const childWidget = Text('Child widget');
      const frameHorizontalEnd = FrameHorizontalEnd(
        top: topWidget,
        child: childWidget,
      );

      await tester.pumpWidget(const MaterialApp(home: frameHorizontalEnd));

      expect(find.byWidget(topWidget), findsOneWidget);
      expect(find.byWidget(childWidget), findsOneWidget);
    });

    testWidgets(
        'FrameHorizontalEnd sets maxWidth of ConstrainedBox if not null',
        (WidgetTester tester) async {
      const childWidget = Align();
      const maxWidth = 300.0;
      const frameHorizontalEnd = FrameHorizontalEnd(
        maxWidth: maxWidth,
        child: childWidget,
      );

      await tester.pumpWidget(frameHorizontalEnd);

      final constraints = tester
          .widget<ConstrainedBox>(find.byType(ConstrainedBox).last)
          .constraints;
      final d = find.byType(ConstrainedBox);
      expect(d, findsOneWidget);
      expect(constraints.maxWidth, equals(maxWidth));
    });

    testWidgets(
        'FrameHorizontalEnd sets minWidth of ConstrainedBox if not null',
        (WidgetTester tester) async {
      const childWidget = Align();
      const minWidth = 200.0;
      const frameHorizontalEnd = FrameHorizontalEnd(
        child: childWidget,
      );

      await tester.pumpWidget(frameHorizontalEnd);

      final constraints = tester
          .widget<ConstrainedBox>(find.byType(ConstrainedBox))
          .constraints;
      expect(constraints.minWidth, equals(minWidth));
    });

    testWidgets(
        'FrameHorizontalEnd sets maximum height of ConstrainedBox if topMaxHeight is not null',
        (WidgetTester tester) async {
      const topWidget = Align();
      const topMaxHeight = 150.0;
      const frameHorizontalEnd = FrameHorizontalEnd(
        top: topWidget,
        topMaxHeight: topMaxHeight,
        child: Align(),
      );

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: frameHorizontalEnd,
        ),
      );

      final constraints = tester
          .widget<ConstrainedBox>(find.byType(ConstrainedBox).last)
          .constraints;

      expect(constraints.maxHeight, equals(topMaxHeight));
    });

    testWidgets(
        'FrameHorizontalEnd sets minimum height of ConstrainedBox if topMinHeight is not null',
        (WidgetTester tester) async {
      const topWidget = Align();
      const topMinHeight = 50.0;
      const frameHorizontalEnd = FrameHorizontalEnd(
        top: topWidget,
        topMinHeight: topMinHeight,
        child: Align(),
      );

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: frameHorizontalEnd,
        ),
      );

      final constraints = tester
          .widget<ConstrainedBox>(find.byType(ConstrainedBox).last)
          .constraints;

      expect(constraints.minHeight, equals(topMinHeight));
    });

    testWidgets('FrameHorizontalEnd passes the top to AnimatedShowHide',
        (WidgetTester tester) async {
      const topWidget = SizedBox();
      const topMinHeight = 50.0;
      const frameHorizontalEnd = FrameHorizontalEnd(
        top: topWidget,
        topMinHeight: topMinHeight,
        child: Align(),
      );

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: frameHorizontalEnd,
        ),
      );

      final top = tester.widget<SizedBox>(find.byType(SizedBox));

      expect(top, equals(topWidget));
    });

    testWidgets('FrameHorizontalEnd passes the child to Expanded',
        (WidgetTester tester) async {
      const widgetChild = Align();
      const frameHorizontalEnd = FrameHorizontalEnd(
        child: widgetChild,
      );

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: frameHorizontalEnd,
        ),
      );

      final child = tester.widget<Expanded>(find.byType(Expanded)).child;

      expect(child, equals(widgetChild));
    });
  });
}
