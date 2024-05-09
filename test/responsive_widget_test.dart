import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('ResponsiveWidget', () {
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

    testWidgets(
        //should only render when width is greater than or equal to 1200
        'ResponsiveWidget should only render with extralarge set to true, width >= 1200',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1200,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1199,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should only render with large set to true, width < 1200 and width >= to 950',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            large: true,
            child: const Text('Hello World'),
          ),
          width: 1199,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            large: true,
            child: const Text('Hello World'),
          ),
          width: 950,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            large: true,
            child: const Text('Hello World'),
          ),
          width: 1200,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            large: true,
            child: const Text('Hello World'),
          ),
          width: 949,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should only render with medium set to true, width < 950 and width >= to 600',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            medium: true,
            child: const Text('Hello World'),
          ),
          width: 949,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            medium: true,
            child: const Text('Hello World'),
          ),
          width: 600,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            medium: true,
            child: const Text('Hello World'),
          ),
          width: 950,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            medium: true,
            child: const Text('Hello World'),
          ),
          width: 599,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should only render with small set to true, width < 600 and greater >= 300',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            small: true,
            child: const Text('Hello World'),
          ),
          width: 599,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            small: true,
            child: const Text('Hello World'),
          ),
          width: 300,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            small: true,
            child: const Text('Hello World'),
          ),
          width: 600,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            small: true,
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should only render with extraSmall set to true, width < 300 and greater >= 0',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 0,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 300,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should not render with extraLarge:false, all other properties set to true, and width >= 1200.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: false, // ignore: avoid_redundant_argument_values
            large: true,
            medium: true,
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 1200,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with extraLarge:false, all other properties set to true, and width >= 1200.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: false, // ignore: avoid_redundant_argument_values
            large: true,
            medium: true,
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 1199,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with large:false, all other properties set to true, width < 1200 and width >= 950.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: false, // ignore: avoid_redundant_argument_values
            medium: true,
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 1199,
        ),
      );

      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: false, // ignore: avoid_redundant_argument_values
            medium: true,
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 950,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with large:false, all other properties set to true, width >= 1200 and width < 950.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: false, // ignore: avoid_redundant_argument_values
            medium: true,
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 1200,
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: false, // ignore: avoid_redundant_argument_values
            medium: true,
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 949,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets(
        'ResponsiveWidget should not render with medium:false, all other properties set to true, width < 950 and width >= 600.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: false, // ignore: avoid_redundant_argument_values
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 949,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: false, // ignore: avoid_redundant_argument_values
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 600,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with medium:false, all other properties set to true, width >= 950 and width < 600.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: false, // ignore: avoid_redundant_argument_values
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 950,
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: false, // ignore: avoid_redundant_argument_values
            small: true,
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 599,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with small:false, all other properties set to true, width < 600 and width >= 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: true,
            small: false, // ignore: avoid_redundant_argument_values
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 599,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: true,
            small: false, // ignore: avoid_redundant_argument_values
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 300,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with small:false, all other properties set to true, width >= 600 and width < 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: true,
            small: false, // ignore: avoid_redundant_argument_values
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 600,
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: true,
            small: false, // ignore: avoid_redundant_argument_values
            extraSmall: true,
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets(
        'ResponsiveWidget should not render with extraSmall:false, all other properties set to true, width < 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: true,
            small: true,
            extraSmall: false, // ignore: avoid_redundant_argument_values
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with extraSmall:false, all other properties set to true, width >= 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidget(
            extraLarge: true,
            large: true,
            medium: true,
            small: true,
            extraSmall: false, // ignore: avoid_redundant_argument_values
            child: const Text('Hello World'),
          ),
          width: 300,
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets('Check breakpoints argument is passed to handler',
        (tester) async {
      const customBreakpoints = Breakpoints(
        extraLarge: 1300,
        large: 1000,
        medium: 700,
        small: 400,
        extraSmall: 100,
      );

      final responsiveWidget = ResponsiveWidget(
        breakpoints: customBreakpoints,
        large: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 300,
        ),
      );
      expect(responsiveWidget.handler.breakpoints, customBreakpoints);
    });
    testWidgets(
        'Check shortestSide:true, widget should render with large: true, width: 1300, and height: 960',
        (tester) async {
      final responsiveWidget = ResponsiveWidget(
        useShortestSide: true,
        large: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
          height: 960,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'Check shortestSide: true, widget should not render with extraLarge: true, width: 1300, and height: 960',
        (tester) async {
      final responsiveWidget = ResponsiveWidget(
        useShortestSide: true,
        extraLarge: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
          height: 960,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'Check shortestSide: false, widget should render with extraLarge: true, width: 1300, and height: 960',
        (tester) async {
      final responsiveWidget = ResponsiveWidget(
        useShortestSide: false, // ignore: avoid_redundant_argument_values
        extraLarge: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
          height: 960,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'Check shortestSide: false, widget should not render with extraLarge: true, width: 960, and height: 1300',
        (tester) async {
      final responsiveWidget = ResponsiveWidget(
        useShortestSide: false, // ignore: avoid_redundant_argument_values
        extraLarge: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 960,
          height: 1300,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'Check transitionBuilder, widget should render when transiationBuilder is provided',
        (tester) async {
      final responsiveWidget = ResponsiveWidget(
        extraLarge: true,
        transiationBuilder: (context, animation, child) {
          return Column(
            children: [
              child!,
              const Text(
                'Hello World1',
              ),
            ],
          );
        },
        child: const Text(
          'Hello World',
        ),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
      expect(find.text('Hello World1'), findsOneWidget);
    });

    testWidgets(
        'Check axis argument is passed to nested AnimatedShowHide, widget should render when axis is provided',
        (tester) async {
      const axis = Axis.vertical;
      final responsiveWidget = ResponsiveWidget(
        extraLarge: true,
        axis: axis,
        child: const Text(
          'Hello World',
        ),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
        ),
      );
      final showHide = find.byType(AnimatedShowHide);
      expect(showHide, findsOneWidget);

      final animatedShowHide = tester.widget<AnimatedShowHide>(showHide);
      expect(animatedShowHide.axis, axis);
    });
    testWidgets(
        'Check axisAlignment argument is passed to nested AnimatedShowHide, widget should render when axisAlignment is provided',
        (tester) async {
      const axisAlignment = 1.0;
      final responsiveWidget = ResponsiveWidget(
        extraLarge: true,
        axisAlignment: axisAlignment,
        child: const Text(
          'Hello World',
        ),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
        ),
      );
      final showHide = find.byType(AnimatedShowHide);
      expect(showHide, findsOneWidget);

      final animatedShowHide = tester.widget<AnimatedShowHide>(showHide);
      expect(animatedShowHide.axisAlignment, axisAlignment);
    });
    testWidgets(
        'Check curve argument is passed to nested AnimatedShowHide, widget should render when curve is provided',
        (tester) async {
      const curve = Curves.easeInCirc;
      final responsiveWidget = ResponsiveWidget(
        extraLarge: true,
        curve: curve,
        child: const Text(
          'Hello World',
        ),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
        ),
      );
      final showHide = find.byType(AnimatedShowHide);
      expect(showHide, findsOneWidget);

      final animatedShowHide = tester.widget<AnimatedShowHide>(showHide);
      expect(animatedShowHide.curve, curve);
    });
    testWidgets(
        'Check animate argument is passed to nested AnimatedShowHide, widget should render when animate is provided',
        (tester) async {
      const animate = false;
      final responsiveWidget = ResponsiveWidget(
        extraLarge: true,
        animate: animate,
        child: const Text(
          'Hello World',
        ),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
        ),
      );
      final showHide = find.byType(AnimatedShowHide);
      expect(showHide, findsOneWidget);

      final animatedShowHide = tester.widget<AnimatedShowHide>(showHide);
      expect(animatedShowHide.animate, animate);
    });
  });
}
