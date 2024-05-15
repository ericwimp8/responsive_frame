import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('ScreenSizeLayoutGranular', () {
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

    const jumboExtraLarge = Text('jumboExtraLarge');
    const jumboLarge = Text('jumboLarge');
    const jumboNormal = Text('jumboNormal');
    const jumboSmall = Text('jumboSmall');
    const standardExtraLarge = Text('standardExtraLarge');
    const standardLarge = Text('standardLarge');
    const standardNormal = Text('standardNormal');
    const standardSmall = Text('standardSmall');
    const compactExtraLarge = Text('compactExtraLarge');
    const compactLarge = Text('compactLarge');
    const compactNormal = Text('compactNormal');
    const compactSmall = Text('compactSmall');
    const tiny = Text('tiny');
    testWidgets(
        'Test that ScreenSizeLayoutGranular returns the correct layout for the given constraints',
        (WidgetTester tester) async {
      final widget = ScreenSizeLayoutGranular(
        jumboExtraLarge: (context) => jumboExtraLarge,
        jumboLarge: (context) => jumboLarge,
        jumboNormal: (context) => jumboNormal,
        jumboSmall: (context) => jumboSmall,
        standardExtraLarge: (context) => standardExtraLarge,
        standardLarge: (context) => standardLarge,
        standardNormal: (context) => standardNormal,
        standardSmall: (context) => standardSmall,
        compactExtraLarge: (context) => compactExtraLarge,
        compactLarge: (context) => compactLarge,
        compactNormal: (context) => compactNormal,
        compactSmall: (context) => compactSmall,
        tiny: (context) => tiny,
      );

      await tester.pumpWidget(
        _createAppWrapper(
          width: 4096,
          child: widget,
        ),
      );
      var childFinder = find.text('jumboExtraLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 3840,
          child: widget,
        ),
      );
      childFinder = find.text('jumboLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 2560,
          child: widget,
        ),
      );
      childFinder = find.text('jumboNormal');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 1920,
          child: widget,
        ),
      );
      childFinder = find.text('jumboSmall');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 1280,
          child: widget,
        ),
      );
      childFinder = find.text('standardExtraLarge');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1024,
          child: widget,
        ),
      );
      childFinder = find.text('standardLarge');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 768,
          child: widget,
        ),
      );
      childFinder = find.text('standardNormal');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 568,
          child: widget,
        ),
      );
      childFinder = find.text('standardSmall');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 480,
          child: widget,
        ),
      );
      childFinder = find.text('compactExtraLarge');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 430,
          child: widget,
        ),
      );
      childFinder = find.text('compactLarge');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          // ignore: avoid_redundant_argument_values
          width: 360,
          child: widget,
        ),
      );
      childFinder = find.text('compactNormal');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 300,
          child: widget,
        ),
      );
      childFinder = find.text('compactSmall');
      expect(childFinder, findsOneWidget);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 299,
          child: widget,
        ),
      );
      childFinder = find.text('tiny');
      expect(childFinder, findsOneWidget);
    });
    testWidgets(
        'Test that ScreenSizeLayoutGranular returns the correct layout for the given constraints and useShortestSide:true',
        (WidgetTester tester) async {
      final widget = ScreenSizeLayoutGranular(
        useShortestSide: true,
        jumboExtraLarge: (context) => jumboExtraLarge,
        jumboLarge: (context) => jumboLarge,
        jumboNormal: (context) => jumboNormal,
        jumboSmall: (context) => jumboSmall,
        standardExtraLarge: (context) => standardExtraLarge,
        standardLarge: (context) => standardLarge,
        standardNormal: (context) => standardNormal,
        standardSmall: (context) => standardSmall,
        compactExtraLarge: (context) => compactExtraLarge,
        compactLarge: (context) => compactLarge,
        compactNormal: (context) => compactNormal,
        compactSmall: (context) => compactSmall,
        tiny: (context) => tiny,
      );

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 4096,
          child: widget,
        ),
      );
      var childFinder = find.text('jumboExtraLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 3840,
          child: widget,
        ),
      );
      childFinder = find.text('jumboLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 2560,
          child: widget,
        ),
      );
      childFinder = find.text('jumboNormal');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 1920,
          child: widget,
        ),
      );
      childFinder = find.text('jumboSmall');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 1280,
          child: widget,
        ),
      );
      childFinder = find.text('standardExtraLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 1024,
          child: widget,
        ),
      );
      childFinder = find.text('standardLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 768,
          child: widget,
        ),
      );

      childFinder = find.text('standardNormal');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 568,
          child: widget,
        ),
      );

      childFinder = find.text('standardSmall');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 480,
          child: widget,
        ),
      );

      childFinder = find.text('compactExtraLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 430,
          child: widget,
        ),
      );

      childFinder = find.text('compactLarge');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 360,
          child: widget,
        ),
      );

      childFinder = find.text('compactNormal');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 300,
          child: widget,
        ),
      );

      childFinder = find.text('compactSmall');
      expect(childFinder, findsOneWidget);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 6000,
          height: 299,
          child: widget,
        ),
      );

      childFinder = find.text('tiny');
      expect(childFinder, findsOneWidget);
    });

    testWidgets(
        'Test that ScreenSizeLayoutGranular returns the correct layout for the given constraints with useLocalSizeConstraints:true',
        (WidgetTester tester) async {
      final widget = ScreenSizeLayoutGranular(
        useLocalSizeConstraints: true,
        jumboExtraLarge: (context) => jumboExtraLarge,
        jumboLarge: (context) => jumboLarge,
        jumboNormal: (context) => jumboNormal,
        jumboSmall: (context) => jumboSmall,
        standardExtraLarge: (context) => standardExtraLarge,
        standardLarge: (context) => standardLarge,
        standardNormal: (context) => standardNormal,
        standardSmall: (context) => standardSmall,
        compactExtraLarge: (context) => compactExtraLarge,
        compactLarge: (context) => compactLarge,
        compactNormal: (context) => compactNormal,
        compactSmall: (context) => compactSmall,
        tiny: (context) => tiny,
      );

      //sets the BoxConstraints in nested LayoutBuilder
      tester.view.physicalSize = const Size(4096, 1200);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 4096,
          child: widget,
        ),
      );
      var childFinder = find.text('jumboExtraLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(3840, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 3840,
          child: widget,
        ),
      );
      childFinder = find.text('jumboLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(2560, 1200);

      await tester.pumpWidget(
        _createAppWrapper(
          width: 2560,
          child: widget,
        ),
      );
      childFinder = find.text('jumboNormal');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(1920, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1920,
          child: widget,
        ),
      );
      childFinder = find.text('jumboSmall');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(1280, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1280,
          child: widget,
        ),
      );
      childFinder = find.text('standardExtraLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(1024, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1024,
          child: widget,
        ),
      );
      childFinder = find.text('standardLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(768, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 768,
          child: widget,
        ),
      );
      childFinder = find.text('standardNormal');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(568, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 568,
          child: widget,
        ),
      );
      childFinder = find.text('standardSmall');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(480, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 480,
          child: widget,
        ),
      );

      childFinder = find.text('compactExtraLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(430, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 430,
          child: widget,
        ),
      );
      childFinder = find.text('compactLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(360, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          // ignore: avoid_redundant_argument_values
          width: 360,
          child: widget,
        ),
      );
      childFinder = find.text('compactNormal');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(300, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 300,
          child: widget,
        ),
      );
      childFinder = find.text('compactSmall');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(299, 1200);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 299,
          child: widget,
        ),
      );
      childFinder = find.text('compactExtraSmall');
    });

    testWidgets(
        'Test that ScreenSizeLayoutGranular returns the correct layout for the given constraints with useLocalSizeConstraints:true and userShortestSide:true',
        (WidgetTester tester) async {
      final widget = ScreenSizeLayoutGranular(
        useShortestSide: true,
        useLocalSizeConstraints: true,
        jumboExtraLarge: (context) => jumboExtraLarge,
        jumboLarge: (context) => jumboLarge,
        jumboNormal: (context) => jumboNormal,
        jumboSmall: (context) => jumboSmall,
        standardExtraLarge: (context) => standardExtraLarge,
        standardLarge: (context) => standardLarge,
        standardNormal: (context) => standardNormal,
        standardSmall: (context) => standardSmall,
        compactExtraLarge: (context) => compactExtraLarge,
        compactLarge: (context) => compactLarge,
        compactNormal: (context) => compactNormal,
        compactSmall: (context) => compactSmall,
        tiny: (context) => tiny,
      );

      //sets the BoxConstraints in nested LayoutBuilder
      tester.view.physicalSize = const Size(6000, 4096);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        _createAppWrapper(
          width: 4096,
          child: widget,
        ),
      );
      var childFinder = find.text('jumboExtraLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 3840);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 3840,
          child: widget,
        ),
      );
      childFinder = find.text('jumboLarge');
      expect(childFinder, findsOneWidget);
      tester.view.physicalSize = const Size(6000, 2560);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 2560,
          child: widget,
        ),
      );
      childFinder = find.text('jumboNormal');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 1920);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1920,
          child: widget,
        ),
      );
      childFinder = find.text('jumboSmall');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 1280);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1280,
          child: widget,
        ),
      );
      childFinder = find.text('standardExtraLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 1024);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 1024,
          child: widget,
        ),
      );
      childFinder = find.text('standardLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 768);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 768,
          child: widget,
        ),
      );
      childFinder = find.text('standardNormal');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 568);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 568,
          child: widget,
        ),
      );
      childFinder = find.text('standardSmall');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 480);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 480,
          child: widget,
        ),
      );
      childFinder = find.text('compactExtraLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 430);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 430,
          child: widget,
        ),
      );
      childFinder = find.text('compactLarge');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 360);
      await tester.pumpWidget(
        _createAppWrapper(
          // ignore: avoid_redundant_argument_values
          width: 360,
          child: widget,
        ),
      );
      childFinder = find.text('compactNormal');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 300);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 300,
          child: widget,
        ),
      );
      childFinder = find.text('compactSmall');
      expect(childFinder, findsOneWidget);

      tester.view.physicalSize = const Size(6000, 299);
      await tester.pumpWidget(
        _createAppWrapper(
          width: 299,
          child: widget,
        ),
      );
      childFinder = find.text('tiny');
      expect(childFinder, findsOneWidget);
    });
  });
}
