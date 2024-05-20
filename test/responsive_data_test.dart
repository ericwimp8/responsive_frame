import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('ResponsiveData', () {
    testWidgets('ResponsiveData renders child widget correctly',
        (WidgetTester tester) async {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final handlers = {
        'handler1': BreakpointsHandler<String>(
          extraLarge: 'handler1',
        ),
      };

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveData(
            notifier: ResponsiveDataChangeNotifier(
              breakpoints: breakpoints,
              handlers: handlers,
            ),
            child: const Text('Child Widget'),
          ),
        ),
      );

      expect(find.text('Child Widget'), findsOneWidget);
    });

    testWidgets(
        'ResponsiveData.of returns correct ResponsiveDataChangeNotifier instance',
        (WidgetTester tester) async {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final handlers = {
        'handler1': BreakpointsHandler<String>(
          extraLarge: 'handler1',
        ),
      };

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveData(
            notifier: ResponsiveDataChangeNotifier(
              breakpoints: breakpoints,
              handlers: handlers,
            ),
            child: const NestedOf(),
          ),
        ),
      );

      final notifier = ResponsiveData.of<LayoutSize>(
        tester.element(find.byType(NestedOf)),
      );

      expect(notifier, isA<ResponsiveDataChangeNotifier<LayoutSize>>());
      expect(notifier.handlers, equals(handlers));
    });

    test('updateShouldNotify returns true', () {
      final oldWidget = ResponsiveData(
        notifier: ResponsiveDataChangeNotifier(
          breakpoints: Breakpoints.defaultBreakpoints,
        ),
        child: Container(),
      );
      final widget = ResponsiveData(
        notifier: ResponsiveDataChangeNotifier(
          breakpoints: Breakpoints.defaultBreakpoints,
        ),
        child: Container(),
      );

      final result = widget.updateShouldNotify(oldWidget);

      expect(result, true);
    });

    testWidgets(
        'handlerOf throws assertion error when ResponsiveData is not in the widget tree',
        (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(
                () => ResponsiveData.handlerOf<String, LayoutSize>(
                  context,
                  'handler1',
                  1200,
                ),
                throwsAssertionError,
              );
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets(
        'of throws assertion error when ResponsiveData is not in the widget tree',
        (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(
                () => ResponsiveData.of<LayoutSize>(context),
                throwsAssertionError,
              );
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('child widget updates when notifier changes', (tester) async {
      final child1 = Container(color: Colors.red);
      final child2 = Container(color: Colors.blue);

      final notifier = ResponsiveDataChangeNotifier(
        breakpoints: Breakpoints.defaultBreakpoints,
      );
      final key = GlobalKey();

      await tester.pumpWidget(
        ResponsiveData(
          key: key,
          notifier: notifier,
          child: child1,
        ),
      );

      expect(find.byWidget(child1), findsOneWidget);
      expect(find.byWidget(child2), findsNothing);

      await tester.pumpWidget(
        ResponsiveData(
          key: key,
          notifier: notifier,
          child: child2,
        ),
      );

      expect(find.byWidget(child1), findsNothing);
      expect(find.byWidget(child2), findsOneWidget);
    });

    testWidgets('handlerOf returns the correct value', (widgetTester) async {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final handlers = {
        'handler1': BreakpointsHandler<String>(
          extraLarge: 'handler1',
        ),
        'handler2': BreakpointsHandler<String>(
          extraLarge: 'handler2',
        ),
      };

      await widgetTester.pumpWidget(
        MaterialApp(
          home: ResponsiveData(
            notifier: ResponsiveDataChangeNotifier(
              breakpoints: breakpoints,
              handlers: handlers,
            ),
            child: const NestedHandlerOf(),
          ),
        ),
      );

      expect(find.text('handler1'), findsOneWidget);
    });

    testWidgets('of returns the correct value', (widgetTester) async {
      const breakpoints = Breakpoints.defaultBreakpoints;

      await widgetTester.pumpWidget(
        MaterialApp(
          home: ResponsiveData(
            notifier: ResponsiveDataChangeNotifier(
              breakpoints: breakpoints,
            ),
            child: const NestedOf(),
          ),
        ),
      );

      expect(
        find.text(
          'ResponsiveDataChangeNotifier(useShortestSide: false, screenSize: LayoutSize.medium, currentBreakpoint: 600.0)',
        ),
        findsOneWidget,
      );
    });
  });
}

class NestedHandlerOf extends StatelessWidget {
  const NestedHandlerOf({super.key});

  @override
  Widget build(BuildContext context) {
    final handler = ResponsiveData.handlerOf<String, LayoutSize>(
      context,
      'handler1',
      1200,
    );
    return Text(handler);
  }
}

class NestedOf extends StatelessWidget {
  const NestedOf({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ResponsiveData.of<LayoutSize>(context);

    return Text(data.toString());
  }
}
