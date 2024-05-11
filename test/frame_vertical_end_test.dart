import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('FrameVerticalEnd', () {
    testWidgets('FrameVerticalEnd renders child widget',
        (WidgetTester tester) async {
      const childWidget = Text('Hello, world!');
      const frameVerticalEnd = FrameVerticalEnd(child: childWidget);
      await tester.pumpWidget(const MaterialApp(home: frameVerticalEnd));

      expect(find.byWidget(childWidget), findsOneWidget);
    });

    testWidgets('FrameVerticalEnd sets maxHeight correctly',
        (WidgetTester tester) async {
      const maxHeight = 300.0;
      const childWidget = Text('Hello, world!');
      const frameVerticalEnd = FrameVerticalEnd(
        maxHeight: maxHeight,
        child: childWidget,
      );

      await tester.pumpWidget(const MaterialApp(home: frameVerticalEnd));

      final animatedConstrainedBox = tester.firstWidget<AnimatedConstrainedBox>(
        find.byType(AnimatedConstrainedBox),
      );
      expect(animatedConstrainedBox.constraints.maxHeight, equals(maxHeight));
    });

    testWidgets('FrameVerticalEnd sets minHeight correctly',
        (WidgetTester tester) async {
      const minHeight = 200.0;
      const childWidget = Text('Hello, world!');
      const frameVerticalEnd = FrameVerticalEnd(
        minHeight: minHeight,
        child: childWidget,
      );

      await tester.pumpWidget(const MaterialApp(home: frameVerticalEnd));

      final animatedConstrainedBox = tester.firstWidget<AnimatedConstrainedBox>(
        find.byType(AnimatedConstrainedBox),
      );
      expect(animatedConstrainedBox.constraints.minHeight, equals(minHeight));
    });

    testWidgets('FrameVerticalEnd passes the child to AnimatedConstrainedBox',
        (WidgetTester tester) async {
      const childWidget = Text('Hello, world!');
      const frameVerticalEnd = FrameVerticalEnd(
        child: childWidget,
      );

      await tester.pumpWidget(const MaterialApp(home: frameVerticalEnd));

      final animatedConstrainedBoxChild = tester
          .firstWidget<AnimatedConstrainedBox>(
            find.byType(AnimatedConstrainedBox),
          )
          .child;
      expect(animatedConstrainedBoxChild, equals(childWidget));
    });
  });
}
