import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('BreakpointsData', () {
    testWidgets('BreakpointsData wraps child with ResponsiveData widget',
        (WidgetTester tester) async {
      const child = Text('Test');
      const widget = BreakpointsData(child: child);

      await tester.pumpWidget(const MaterialApp(home: widget));

      expect(find.byWidget(child), findsOneWidget);
      expect(find.byType(ResponsiveData<LayoutSize>), findsOneWidget);
    });
    testWidgets(
        'BreakpointsData passes initialHandlers to ResponsiveDataChangeNotifier',
        (WidgetTester tester) async {
      final initialHandlers = {
        'handler1': BreakpointsHandler<String>(
          extraLarge: 'handler1',
        ),
        'handler2': BreakpointsHandler<String>(
          extraLarge: 'handler1',
        ),
      };
      final widget = BreakpointsData(
        handlers: initialHandlers,
        child: const Text('child'),
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      // ignore: omit_local_variable_types
      final ResponsiveData responsiveData =
          tester.widget(find.byType(ResponsiveData<LayoutSize>));
      expect(
        responsiveData.notifier!.handlers,
        equals(initialHandlers),
      );
    });
    testWidgets(
        'BreakpointsData passes breakpoints to ResponsiveDataChangeNotifier',
        (WidgetTester tester) async {
      const widget = BreakpointsData(
        child: Text('child'),
      );

      await tester.pumpWidget(const MaterialApp(home: widget));

      // ignore: omit_local_variable_types
      final ResponsiveData responsiveData =
          tester.widget(find.byType(ResponsiveData<LayoutSize>));
      expect(
        responsiveData.notifier!.breakpoints,
        equals(Breakpoints.defaultBreakpoints),
      );
    });
  });
}
