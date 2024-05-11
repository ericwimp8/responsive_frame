import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('ResponsiveWidgetGranular', () {
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
        'ResponsiveWidget should only render with jumboExtraLarge set to true, width >= 4096',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 4096,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 4095,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should only render with jumboLarge set to true, width < 4096 and width >= to 3840',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboLarge: true,
            child: const Text('Hello World'),
          ),
          width: 4095,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboLarge: true,
            child: const Text('Hello World'),
          ),
          width: 3840,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboLarge: true,
            child: const Text('Hello World'),
          ),
          width: 4096,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboLarge: true,
            child: const Text('Hello World'),
          ),
          width: 3839,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should only render with jumboNormal set to true, width < 3840 and width >= to 2560',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboNormal: true,
            child: const Text('Hello World'),
          ),
          width: 3839,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboNormal: true,
            child: const Text('Hello World'),
          ),
          width: 2560,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboNormal: true,
            child: const Text('Hello World'),
          ),
          width: 3840,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboNormal: true,
            child: const Text('Hello World'),
          ),
          width: 2559,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should only render with jumboSmall set to true, width < 2560 and greater >= 1920',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboSmall: true,
            child: const Text('Hello World'),
          ),
          width: 2559,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboSmall: true,
            child: const Text('Hello World'),
          ),
          width: 1920,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboSmall: true,
            child: const Text('Hello World'),
          ),
          width: 2560,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboSmall: true,
            child: const Text('Hello World'),
          ),
          width: 1919,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with standardExtraLarge set to true, width < 1920 and greater >= 1280',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1919,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1280,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1920,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1279,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with standardLarge set to true, width < 1280 and greater >= 1024',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1279,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1024,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1280,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardLarge: true,
            child: const Text('Hello World'),
          ),
          width: 1023,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with standardNormal set to true, width < 1024 and greater >= 768',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardNormal: true,
            child: const Text('Hello World'),
          ),
          width: 1023,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardNormal: true,
            child: const Text('Hello World'),
          ),
          width: 768,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardNormal: true,
            child: const Text('Hello World'),
          ),
          width: 1024,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardNormal: true,
            child: const Text('Hello World'),
          ),
          width: 767,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with standardSmall set to true, width < 768 and greater >= 568',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardSmall: true,
            child: const Text('Hello World'),
          ),
          width: 767,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardSmall: true,
            child: const Text('Hello World'),
          ),
          width: 568,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardSmall: true,
            child: const Text('Hello World'),
          ),
          width: 768,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            standardSmall: true,
            child: const Text('Hello World'),
          ),
          width: 567,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with compactExtraLarge set to true, width < 568 and greater >= 480',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 567,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 480,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 568,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactExtraLarge: true,
            child: const Text('Hello World'),
          ),
          width: 479,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with compactLarge set to true, width < 480 and greater >= 430',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactLarge: true,
            child: const Text('Hello World'),
          ),
          width: 479,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactLarge: true,
            child: const Text('Hello World'),
          ),
          width: 430,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactLarge: true,
            child: const Text('Hello World'),
          ),
          width: 480,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactLarge: true,
            child: const Text('Hello World'),
          ),
          width: 429,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with compactNormal set to true, width < 430 and greater >= 360',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactNormal: true,
            child: const Text('Hello World'),
          ),
          width: 429,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactNormal: true,
            child: const Text('Hello World'),
          ),
          width: 360, // ignore: avoid_redundant_argument_values
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactNormal: true,
            child: const Text('Hello World'),
          ),
          width: 430,
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactNormal: true,
            child: const Text('Hello World'),
          ),
          width: 359,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with compactSmall set to true, width < 360 and greater >= 300',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactSmall: true,
            child: const Text('Hello World'),
          ),
          width: 359,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactSmall: true,
            child: const Text('Hello World'),
          ),
          width: 300, // ignore: avoid_redundant_argument_values
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactSmall: true,
            child: const Text('Hello World'),
          ),
          width: 360, // ignore: avoid_redundant_argument_values
        ),
      );
      expect(find.text('Hello World'), findsNothing);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactSmall: true,
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should only render with compactSmall set to true, width < 300.',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactSmall: true,
            child: const Text('Hello World'),
          ),
          width: 300,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            compactSmall: true,
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });

    testWidgets(
        'ResponsiveWidget should not render with jumboExtraLarge:false, all other properties set to true, and width >= 4096.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: false, // ignore: avoid_redundant_argument_values
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 4096,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with jumboExtraLarge:false, all other properties set to true, and width <= 4096.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: false, // ignore: avoid_redundant_argument_values
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 4095,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets(
        'ResponsiveWidget should not render with jumboLarge:false, all other properties set to true, width >= 3840 and width < 4096.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: false, // ignore: avoid_redundant_argument_values
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 4095,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: false, // ignore: avoid_redundant_argument_values
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 3840,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with jumboLarge:false, all other properties set to true, and width < 3840 and width >= 4096.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: false, // ignore: avoid_redundant_argument_values
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 3839,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: false, // ignore: avoid_redundant_argument_values
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 4096,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with jumboNormal:false, all other properties set to true, width >= 2560 and width < 3840.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: false, // ignore: avoid_redundant_argument_values
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 2560,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: false, // ignore: avoid_redundant_argument_values
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 3839,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with jumboNormal:false, all other properties set to true, and width >= 3840 and width < 2560.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: false, // ignore: avoid_redundant_argument_values
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 3840,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: false, // ignore: avoid_redundant_argument_values
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 2559,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with jumboSmall:false, all other properties set to true, width < 2560 and width >= 1920.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: false, // ignore: avoid_redundant_argument_values
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 2559,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: false, // ignore: avoid_redundant_argument_values
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1920,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with jumboSmall:false, all other properties set to true, and width >= 2560 and width < 1920.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: false, // ignore: avoid_redundant_argument_values
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 2560,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: false, // ignore: avoid_redundant_argument_values
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1919,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with standardExtraLarge:false, all other properties set to true, width < 1920 and width >= 1280.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge:
                false, // ignore: avoid_redundant_argument_values
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1919,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge:
                false, // ignore: avoid_redundant_argument_values
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1280,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with standardExtraLarge:false, all other properties set to true, and width >= 1920 and width < 1280.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge:
                false, // ignore: avoid_redundant_argument_values
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1920,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge:
                false, // ignore: avoid_redundant_argument_values
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1279,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with standardLarge:false, all other properties set to true, width < 1280 and width >= 1024.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: false, // ignore: avoid_redundant_argument_values
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1279,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: false, // ignore: avoid_redundant_argument_values
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1024,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with standardLarge:false, all other properties set to true, and width >= 1280 and width < 1024.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: false, // ignore: avoid_redundant_argument_values
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1280,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: false, // ignore: avoid_redundant_argument_values
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1023,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with standardNormal:false, all other properties set to true, width < 1024 and width >= 768.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: false, // ignore: avoid_redundant_argument_values
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1023,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: false, // ignore: avoid_redundant_argument_values
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 768,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with standardNormal:false, all other properties set to true, and width >= 1024 and width < 768.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: false, // ignore: avoid_redundant_argument_values
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 1024,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: false, // ignore: avoid_redundant_argument_values
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 767,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with standardSmall:false, all other properties set to true, width < 768 and width >= 568.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: false, // ignore: avoid_redundant_argument_values
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 767,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: false, // ignore: avoid_redundant_argument_values
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 568,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with standardSmall:false, all other properties set to true, and width >= 768 and width < 568.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: false, // ignore: avoid_redundant_argument_values
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 768,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: false, // ignore: avoid_redundant_argument_values
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 567,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with compactExtraLarge:false, all other properties set to true, width < 568 and width >= 480.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: false, // ignore: avoid_redundant_argument_values
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 567,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: false, // ignore: avoid_redundant_argument_values
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 480,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with compactExtraLarge:false, all other properties set to true, and width >= 568 and width < 480.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: false, // ignore: avoid_redundant_argument_values
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 568,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: false, // ignore: avoid_redundant_argument_values
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 479,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with compactLarge:false, all other properties set to true, width < 480 and width >= 430.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: false, // ignore: avoid_redundant_argument_values
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 479,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: false, // ignore: avoid_redundant_argument_values
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 430,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with compactLarge:false, all other properties set to true, and width >= 480 and width < 430.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: false, // ignore: avoid_redundant_argument_values
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 480,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: false, // ignore: avoid_redundant_argument_values
            compactNormal: true,
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 429,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with compactNormal:false, all other properties set to true, width < 430 and width >= 360.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: false, // ignore: avoid_redundant_argument_values
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 429,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: false, // ignore: avoid_redundant_argument_values
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 360, // ignore: avoid_redundant_argument_values
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with compactNormal:false, all other properties set to true, and width >= 430 and width < 360.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: false, // ignore: avoid_redundant_argument_values
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 430,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: false, // ignore: avoid_redundant_argument_values
            compactSmall: true,
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 359,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with compactSmall:false, all other properties set to true, width < 360 and width >= 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: false, // ignore: avoid_redundant_argument_values
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 359,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: false, // ignore: avoid_redundant_argument_values
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 300, // ignore: avoid_redundant_argument_values
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with compactSmall:false, all other properties set to true, and width >= 360 and width < 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: false, // ignore: avoid_redundant_argument_values
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 360, // ignore: avoid_redundant_argument_values
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: false, // ignore: avoid_redundant_argument_values
            tiny: true,
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'ResponsiveWidget should not render with tiny:false, all other properties set to true, width < 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: false, // ignore: avoid_redundant_argument_values
            child: const Text('Hello World'),
          ),
          width: 299,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'ResponsiveWidget should render with tiny:false, all other properties set to true, and width >= 300.',
        (tester) async {
      await tester.pumpWidget(
        _createAppWrapper(
          child: ResponsiveWidgetGranular(
            jumboExtraLarge: true,
            jumboLarge: true,
            jumboNormal: true,
            jumboSmall: true,
            standardExtraLarge: true,
            standardLarge: true,
            standardNormal: true,
            standardSmall: true,
            compactExtraLarge: true,
            compactLarge: true,
            compactNormal: true,
            compactSmall: true,
            tiny: false, // ignore: avoid_redundant_argument_values
            child: const Text('Hello World'),
          ),
          width: 300, // ignore: avoid_redundant_argument_values
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('Check breakpoints argument is passed to handler',
        (tester) async {
      const customBreakpoints = BreakpointsGranular(
        jumboExtraLarge: 5000,
        jumboLarge: 4000,
        jumboNormal: 3500,
        jumboSmall: 3000,
        standardExtraLarge: 2500,
        standardLarge: 2000,
        standardNormal: 1500,
        standardSmall: 1000,
        compactExtraLarge: 800,
        compactLarge: 700,
        compactNormal: 600,
        compactSmall: 500,
      );

      final responsiveWidget = ResponsiveWidgetGranular(
        breakpoints: customBreakpoints,
        jumboExtraLarge: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
        ),
      );
      expect(responsiveWidget.handler.breakpoints, customBreakpoints);
    });
    testWidgets(
        'Check shortestSide:true, widget should render with standardNormal: true, width: 1300, and height: 768',
        (tester) async {
      final responsiveWidget = ResponsiveWidgetGranular(
        useShortestSide: true,
        standardNormal: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
          height: 768,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'Check shortestSide: true, widget should not render with standardNormal: true, width: 1300, and height: 960',
        (tester) async {
      final responsiveWidget = ResponsiveWidgetGranular(
        useShortestSide: true,
        standardNormal: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1300,
          height: 1024,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'Check shortestSide: false, widget should render with standardLarge: true, width: 1300, and height: 960',
        (tester) async {
      final responsiveWidget = ResponsiveWidgetGranular(
        useShortestSide: false, // ignore: avoid_redundant_argument_values
        standardLarge: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 1024,
          height: 960,
        ),
      );
      expect(find.text('Hello World'), findsOneWidget);
    });
    testWidgets(
        'Check shortestSide: false, widget should not render with standardLarge: true, width: 960, and height: 1300',
        (tester) async {
      final responsiveWidget = ResponsiveWidgetGranular(
        useShortestSide: false, // ignore: avoid_redundant_argument_values
        standardLarge: true,
        child: const Text('Hello World'),
      );
      await tester.pumpWidget(
        _createAppWrapper(
          child: responsiveWidget,
          width: 768,
          height: 1300,
        ),
      );
      expect(find.text('Hello World'), findsNothing);
    });
    testWidgets(
        'Check transitionBuilder, widget should render when transiationBuilder is provided',
        (tester) async {
      final responsiveWidget = ResponsiveWidgetGranular(
        standardExtraLarge: true,
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
      final responsiveWidget = ResponsiveWidgetGranular(
        standardExtraLarge: true,
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
      final responsiveWidget = ResponsiveWidgetGranular(
        standardExtraLarge: true,
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
      final responsiveWidget = ResponsiveWidgetGranular(
        standardExtraLarge: true,
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
      final responsiveWidget = ResponsiveWidgetGranular(
        standardExtraLarge: true,
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
