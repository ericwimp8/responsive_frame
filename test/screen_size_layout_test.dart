import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('ScreenSizeLayout', () {
    MaterialApp _createAppWrapper({
      required Widget child,
      double width = 360,
      double height = 640,
    }) {
      return MaterialApp(
        key: UniqueKey(),
        home: MediaQuery(
          data: MediaQueryData(
            size: Size(width, height),
          ),
          child: child,
        ),
      );
    }

    const extraLarge = Text('extraLarge');
    const large = Text('large');
    const medium = Text('medium');
    const small = Text('small');
    const extraSmall = Text('extraSmall');
    testWidgets(
        'Test that ScreenSizeLayout returns the correct layout for the given constraints',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1200,
          child: ScreenSizeLayout(
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      var childFinder = find.text('extraLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 950,
          child: ScreenSizeLayout(
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('large');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 600,
          child: ScreenSizeLayout(
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('medium');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 300,
          child: ScreenSizeLayout(
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('small');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 299,
          child: ScreenSizeLayout(
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('extraSmall');
      expect(childFinder, findsOneWidget);
    });
    testWidgets(
        'Test that ScreenSizeLayout returns the correct layout for the given constraints and useShortestSide:true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          width: 2000,
          height: 1200,
          child: ScreenSizeLayout(
            useShortestSide: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      var childFinder = find.text('extraLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 2000,
          height: 950,
          child: ScreenSizeLayout(
            useShortestSide: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('large');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 2000,
          height: 600,
          child: ScreenSizeLayout(
            useShortestSide: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('medium');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 2000,
          height: 300,
          child: ScreenSizeLayout(
            useShortestSide: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('small');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 2000,
          height: 299,
          child: ScreenSizeLayout(
            useShortestSide: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('extraSmall');
      expect(childFinder, findsOneWidget);
    });

    testWidgets(
        'Test that ScreenSizeLayout returns the correct layout for the given constraints with useLocalSizeConstraints:true',
        (WidgetTester tester) async {
      //sets the BoxConstraints in nested LayoutBuilder
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1200,
          child: ScreenSizeLayout(
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      var childFinder = find.text('extraLarge');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(950, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 950,
          child: ScreenSizeLayout(
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('large');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 600,
          child: ScreenSizeLayout(
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('medium');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(300, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 300,
          child: ScreenSizeLayout(
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('small');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(299, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 299,
          child: ScreenSizeLayout(
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('extraSmall');
      expect(childFinder, findsOneWidget);
    });

    testWidgets(
        'Test that ScreenSizeLayout returns the correct layout for the given constraints with useLocalSizeConstraints:true and userShortestSide:true',
        (WidgetTester tester) async {
      //sets the BoxConstraints in nested LayoutBuilder
      tester.view.physicalSize = const Size(2000, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1200,
          child: ScreenSizeLayout(
            useShortestSide: true,
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      var childFinder = find.text('extraLarge');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(2000, 950);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 950,
          child: ScreenSizeLayout(
            useShortestSide: true,
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('large');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(2000, 600);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 600,
          child: ScreenSizeLayout(
            useShortestSide: true,
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('medium');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(2000, 300);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 300,
          child: ScreenSizeLayout(
            useShortestSide: true,
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('small');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(2000, 299);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 299,
          child: ScreenSizeLayout(
            useShortestSide: true,
            useLocalSizeConstraints: true,
            extraLarge: (context) => extraLarge,
            large: (context) => large,
            medium: (context) => medium,
            small: (context) => small,
            extraSmall: (context) => extraSmall,
          ),
        ),
      );
      childFinder = find.text('extraSmall');
      expect(childFinder, findsOneWidget);
    });
  });
}
