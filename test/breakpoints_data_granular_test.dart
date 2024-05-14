import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('BreakpointsDataGranular', () {
    testWidgets(
        'BreakpointsDataGranular wraps child with ResponsiveData widget',
        (WidgetTester tester) async {
      const child = Text('Test');
      const widget = BreakpointsDataGranular(child: child);

      await tester.pumpWidget(const MaterialApp(home: widget));

      expect(find.byWidget(child), findsOneWidget);
      expect(find.byType(ResponsiveData<LayoutSizeGranular>), findsOneWidget);
    });
    testWidgets(
        'BreakpointsDataGranular passes initialHandlers to ResponsiveDataChangeNotifier',
        (WidgetTester tester) async {
      final initialHandlers = {
        'handler1': BreakpointsHandlerGranular<String>(
          breakpoints: BreakpointsGranular.defaultBreakpoints,
          jumboExtraLarge: 'handler1',
        ),
        'handler2': BreakpointsHandlerGranular<String>(
          breakpoints: BreakpointsGranular.defaultBreakpoints,
          jumboExtraLarge: 'handler1',
        ),
      };
      final widget = BreakpointsDataGranular(
        handlers: initialHandlers,
        child: const Text('child'),
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      // ignore: omit_local_variable_types
      final ResponsiveData responsiveData =
          tester.widget(find.byType(ResponsiveData<LayoutSizeGranular>));
      expect(
        responsiveData.notifier!.handlers,
        equals(initialHandlers),
      );
    });
    testWidgets(
        'BreakpointsDataGranular passes breakpoints to ResponsiveDataChangeNotifier',
        (WidgetTester tester) async {
      const widget = BreakpointsDataGranular(
        child: Text('child'),
      );

      await tester.pumpWidget(const MaterialApp(home: widget));

      // ignore: omit_local_variable_types
      final ResponsiveData responsiveData =
          tester.widget(find.byType(ResponsiveData<LayoutSizeGranular>));
      expect(
        responsiveData.notifier!.breakpoints,
        equals(BreakpointsGranular.defaultBreakpoints),
      );
    });
  });
}
