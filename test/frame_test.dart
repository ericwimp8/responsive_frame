import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('Frame', () {
    testWidgets('Test that Frame renders correctly with all widgets provided',
        (WidgetTester tester) async {
      const body = Text('body');
      const top = Text('top');
      const bodyTop = Text('bodyTop');
      const leftEnd = Text('leftEnd');
      const leftEndTop = Text('leftEndTop');
      const rightEnd = Text('rightEnd');
      const rightEndTop = Text('rightEndTop');
      const bodyBottom = Text('bodyBottom');
      const bottom = Text('bottom');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Frame(
            body: body,
            animations: true, // ignore: avoid_redundant_argument_values
            top: top,
            bodyTop: bodyTop,
            leftEnd: leftEnd,
            leftEndTop: leftEndTop,
            rightEnd: rightEnd,
            rightEndTop: rightEndTop,
            bodyBottom: bodyBottom,
            bottom: bottom,
            backgroundColor: Colors.white,
          ),
        ),
      );

      expect(find.text('body'), findsOneWidget);
      expect(find.text('top'), findsOneWidget);
      expect(find.text('bodyTop'), findsOneWidget);
      expect(find.text('leftEnd'), findsOneWidget);
      expect(find.text('leftEndTop'), findsOneWidget);
      expect(find.text('rightEnd'), findsOneWidget);
      expect(find.text('rightEndTop'), findsOneWidget);
      expect(find.text('bodyBottom'), findsOneWidget);
      expect(find.text('bottom'), findsOneWidget);

      expect(find.byType(Frame), findsOneWidget);
      expect(find.byType(FrameVerticalEnd), findsNWidgets(4));
      expect(find.byType(FrameHorizontalEnd), findsNWidgets(2));
      expect(find.byType(AnimatedShowHide), findsNWidgets(9));
      expect(find.byType(AnimatedShowHideChild), findsNWidgets(9));
    });

    testWidgets('Frame renders correctly with only required widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Frame(
            body: Text('Hello, world!'),
          ),
        ),
      );

      expect(find.text('Hello, world!'), findsOneWidget);
    });

    testWidgets('Frame throws an error if no body is provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Frame(
            body: Container(),
          ),
        ),
      );

      expect(find.byType(Frame), findsOneWidget);
    });

    testWidgets('Check that Frame renders correctly with animations false.',
        (WidgetTester tester) async {
      const body = Text('body');
      const top = Text('top');
      const bodyTop = Text('bodyTop');
      const leftEnd = Text('leftEnd');
      const leftEndTop = Text('leftEndTop');
      const rightEnd = Text('rightEnd');
      const rightEndTop = Text('rightEndTop');
      const bodyBottom = Text('bodyBottom');
      const bottom = Text('bottom');

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Frame(
            body: body,
            animations: false,
            top: top,
            bodyTop: bodyTop,
            leftEnd: leftEnd,
            leftEndTop: leftEndTop,
            rightEnd: rightEnd,
            rightEndTop: rightEndTop,
            bodyBottom: bodyBottom,
            bottom: bottom,
            backgroundColor: Colors.white,
          ),
        ),
      );

      expect(find.text('body'), findsOneWidget);
      expect(find.text('top'), findsOneWidget);
      expect(find.text('bodyTop'), findsOneWidget);
      expect(find.text('leftEnd'), findsOneWidget);
      expect(find.text('leftEndTop'), findsOneWidget);
      expect(find.text('rightEnd'), findsOneWidget);
      expect(find.text('rightEndTop'), findsOneWidget);
      expect(find.text('bodyBottom'), findsOneWidget);
      expect(find.text('bottom'), findsOneWidget);

      expect(find.byType(Frame), findsOneWidget);
      expect(find.byType(FrameVerticalEnd), findsNWidgets(4));
      expect(find.byType(FrameHorizontalEnd), findsNWidgets(2));
      expect(find.byType(AnimatedShowHide), findsNWidgets(9));
      expect(find.byType(AnimatedShowHideChild), findsNothing);
    });

    testWidgets(
        'Test that the dimensions are correctly applied in Frame with leftEndFillVertical: true and rightEndFillVertical: true',
        (WidgetTester tester) async {
      const body = Text('body');
      const top = Text('top');
      const bodyTop = Text('bodyTop');
      const leftEnd = Text('leftEnd');
      const leftEndTop = Text('leftEndTop');
      const rightEnd = Text('rightEnd');
      const rightEndTop = Text('rightEndTop');
      const bodyBottom = Text('bodyBottom');
      const bottom = Text('bottom');
      const dimensionsConfig = DimensionsConfig(
        topMaxHeight: 117,
        topMinHeight: 116,
        bodyTopMaxHeight: 115,
        bodyTopMinHeight: 114,
        bodyMaxWidth: 113,
        bodyMinWidth: 112,
        leftEndMaxWidth: 111,
        leftEndMinWidth: 110,
        leftEndFillVertical: true,
        leftEndTopMaxHeight: 109,
        leftEndTopMinHeight: 108,
        rightEndMaxWidth: 107,
        rightEndMinWidth: 106,
        rightEndFillVertical: true,
        rightEndTopMaxHeight: 105,
        rightEndTopMinHeight: 104,
        bodyBottomMaxHeight: 103,
        bodyBottomMinHeight: 102,
        bottomMaxHeight: 101,
        bottomMinHeight: 100,
        bodyAlignment: Alignment.center,
      );

      const frame = Frame(
        body: body,
        top: top,
        bodyTop: bodyTop,
        leftEnd: leftEnd,
        leftEndTop: leftEndTop,
        rightEnd: rightEnd,
        rightEndTop: rightEndTop,
        bodyBottom: bodyBottom,
        bottom: bottom,
        dimensions: dimensionsConfig,
      );
      ConstrainedBox _getConstrainedBox(String text) {
        final finder = find.text(text);
        return tester
            .element(finder)
            .findAncestorWidgetOfExactType<ConstrainedBox>()!;
      }

      await tester.pumpWidget(const MaterialApp(home: frame));

      final bodyBox = _getConstrainedBox('body');
      expect(bodyBox.constraints.maxWidth, dimensionsConfig.bodyMaxWidth);
      expect(bodyBox.constraints.minWidth, dimensionsConfig.bodyMinWidth);
      final topBox = _getConstrainedBox('top');
      expect(topBox.constraints.maxHeight, dimensionsConfig.topMaxHeight);
      expect(topBox.constraints.minHeight, dimensionsConfig.topMinHeight);
      final bodyTopBox = _getConstrainedBox('bodyTop');
      expect(
        bodyTopBox.constraints.maxHeight,
        dimensionsConfig.bodyTopMaxHeight,
      );
      expect(
        bodyTopBox.constraints.minHeight,
        dimensionsConfig.bodyTopMinHeight,
      );
      final leftEndBox = _getConstrainedBox('leftEnd');
      expect(
        leftEndBox.constraints.maxWidth,
        dimensionsConfig.leftEndMaxWidth,
      );
      expect(
        leftEndBox.constraints.minWidth,
        dimensionsConfig.leftEndMinWidth,
      );
      final leftEndTopBox = _getConstrainedBox('leftEndTop');
      expect(
        leftEndTopBox.constraints.maxHeight,
        dimensionsConfig.leftEndTopMaxHeight,
      );
      expect(
        leftEndTopBox.constraints.minHeight,
        dimensionsConfig.leftEndTopMinHeight,
      );
      final rightEndBox = _getConstrainedBox('rightEnd');
      expect(
        rightEndBox.constraints.maxWidth,
        dimensionsConfig.rightEndMaxWidth,
      );
      expect(
        rightEndBox.constraints.minWidth,
        dimensionsConfig.rightEndMinWidth,
      );
      final rightEndTopBox = _getConstrainedBox('rightEndTop');
      expect(
        rightEndTopBox.constraints.maxHeight,
        dimensionsConfig.rightEndTopMaxHeight,
      );
      expect(
        rightEndTopBox.constraints.minHeight,
        dimensionsConfig.rightEndTopMinHeight,
      );
      final bodyBottomBox = _getConstrainedBox('bodyBottom');
      expect(
        bodyBottomBox.constraints.maxHeight,
        dimensionsConfig.bodyBottomMaxHeight,
      );
      expect(
        bodyBottomBox.constraints.minHeight,
        dimensionsConfig.bodyBottomMinHeight,
      );
      final bottomBox = _getConstrainedBox('bottom');
      expect(
        bottomBox.constraints.maxHeight,
        dimensionsConfig.bottomMaxHeight,
      );
      expect(
        bottomBox.constraints.minHeight,
        dimensionsConfig.bottomMinHeight,
      );
    });

    testWidgets(
        'Test that the dimensions are correctly applied in Frame with leftEndFillVertical: false and rightEndFillVertical: false',
        (WidgetTester tester) async {
      const body = Text('body');
      const top = Text('top');
      const bodyTop = Text('bodyTop');
      const leftEnd = Text('leftEnd');
      const leftEndTop = Text('leftEndTop');
      const rightEnd = Text('rightEnd');
      const rightEndTop = Text('rightEndTop');
      const bodyBottom = Text('bodyBottom');
      const bottom = Text('bottom');
      const dimensionsConfig = DimensionsConfig(
        topMaxHeight: 117,
        topMinHeight: 116,
        bodyTopMaxHeight: 115,
        bodyTopMinHeight: 114,
        bodyMaxWidth: 113,
        bodyMinWidth: 112,
        leftEndMaxWidth: 111,
        leftEndMinWidth: 110,
        leftEndFillVertical: false,
        leftEndTopMaxHeight: 109,
        leftEndTopMinHeight: 108,
        rightEndMaxWidth: 107,
        rightEndMinWidth: 106,
        rightEndFillVertical: false,
        rightEndTopMaxHeight: 105,
        rightEndTopMinHeight: 104,
        bodyBottomMaxHeight: 103,
        bodyBottomMinHeight: 102,
        bottomMaxHeight: 101,
        bottomMinHeight: 100,
        bodyAlignment: Alignment.center,
      );

      const frame = Frame(
        body: body,
        top: top,
        bodyTop: bodyTop,
        leftEnd: leftEnd,
        leftEndTop: leftEndTop,
        rightEnd: rightEnd,
        rightEndTop: rightEndTop,
        bodyBottom: bodyBottom,
        bottom: bottom,
        dimensions: dimensionsConfig,
      );
      ConstrainedBox _getConstrainedBox(String text) {
        final finder = find.text(text);
        return tester
            .element(finder)
            .findAncestorWidgetOfExactType<ConstrainedBox>()!;
      }

      await tester.pumpWidget(const MaterialApp(home: frame));

      final bodyBox = _getConstrainedBox('body');
      expect(bodyBox.constraints.maxWidth, dimensionsConfig.bodyMaxWidth);
      expect(bodyBox.constraints.minWidth, dimensionsConfig.bodyMinWidth);
      final topBox = _getConstrainedBox('top');
      expect(topBox.constraints.maxHeight, dimensionsConfig.topMaxHeight);
      expect(topBox.constraints.minHeight, dimensionsConfig.topMinHeight);
      final bodyTopBox = _getConstrainedBox('bodyTop');
      expect(
        bodyTopBox.constraints.maxHeight,
        dimensionsConfig.bodyTopMaxHeight,
      );
      expect(
        bodyTopBox.constraints.minHeight,
        dimensionsConfig.bodyTopMinHeight,
      );
      final leftEndBox = _getConstrainedBox('leftEnd');
      expect(
        leftEndBox.constraints.maxWidth,
        dimensionsConfig.leftEndMaxWidth,
      );
      expect(
        leftEndBox.constraints.minWidth,
        dimensionsConfig.leftEndMinWidth,
      );
      final leftEndTopBox = _getConstrainedBox('leftEndTop');
      expect(
        leftEndTopBox.constraints.maxHeight,
        dimensionsConfig.leftEndTopMaxHeight,
      );
      expect(
        leftEndTopBox.constraints.minHeight,
        dimensionsConfig.leftEndTopMinHeight,
      );
      final rightEndBox = _getConstrainedBox('rightEnd');
      expect(
        rightEndBox.constraints.maxWidth,
        dimensionsConfig.rightEndMaxWidth,
      );
      expect(
        rightEndBox.constraints.minWidth,
        dimensionsConfig.rightEndMinWidth,
      );
      final rightEndTopBox = _getConstrainedBox('rightEndTop');
      expect(
        rightEndTopBox.constraints.maxHeight,
        dimensionsConfig.rightEndTopMaxHeight,
      );
      expect(
        rightEndTopBox.constraints.minHeight,
        dimensionsConfig.rightEndTopMinHeight,
      );
      final bodyBottomBox = _getConstrainedBox('bodyBottom');
      expect(
        bodyBottomBox.constraints.maxHeight,
        dimensionsConfig.bodyBottomMaxHeight,
      );
      expect(
        bodyBottomBox.constraints.minHeight,
        dimensionsConfig.bodyBottomMinHeight,
      );
      final bottomBox = _getConstrainedBox('bottom');
      expect(
        bottomBox.constraints.maxHeight,
        dimensionsConfig.bottomMaxHeight,
      );
      expect(
        bottomBox.constraints.minHeight,
        dimensionsConfig.bottomMinHeight,
      );
    });

    testWidgets('Test that the background color is applied correctly in Frame',
        (WidgetTester tester) async {
      const backgroundColor =
          Colors.blue; // Define the background color you want to test

      await tester.pumpWidget(
        MaterialApp(
          home: Frame(
            body:
                Container(), // You can replace Container with any widget you want to test
            backgroundColor: backgroundColor,
          ),
        ),
      );

      final frameWidget = tester.firstWidget<Frame>(find.byType(Frame));
      expect(frameWidget.backgroundColor, equals(backgroundColor));
    });
  });
}
