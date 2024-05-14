// ignore_for_file: cascade_invocations

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('ResponsiveDataChangeNotifier', () {
    testWidgets('setUseShortestSide updates _useShortestSide field correctly.',
        (tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      final notifier = ResponsiveDataChangeNotifier(
        breakpoints: Breakpoints.defaultBreakpoints,
      );

      notifier.setUseShortestSide(value: true);
      expect(notifier.useShortestSide, true);
    });

    test(
        'updateMetrics updates the screenSize field and currentBreakpoint correctly for LayoutSize.',
        () {
      const breakpoints = Breakpoints.defaultBreakpoints;
      // WidgetsFlutterBinding.ensureInitialized();

      ResponsiveDataChangeNotifier buildNotifier(double width) {
        return ResponsiveDataChangeNotifier(
          breakpoints: breakpoints,
          testView: MockFlutterView(width),
        );
      }

      var notifier = buildNotifier(1200);

      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSize.extraLarge,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSize.extraLarge],
      );

      notifier = buildNotifier(950);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSize.large,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSize.large],
      );

      notifier = buildNotifier(600);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSize.medium,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSize.medium],
      );

      notifier = buildNotifier(300);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSize.small,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSize.small],
      );

      notifier = buildNotifier(299);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSize.extraSmall,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSize.extraSmall],
      );
    });

    test(
        'updateMetrics updates the screenSize field and currentBreakpoint correctly for LayoutSizeGranular.',
        () {
      const breakpoints = BreakpointsGranular.defaultBreakpoints;
      // WidgetsFlutterBinding.ensureInitialized();

      ResponsiveDataChangeNotifier buildNotifier(double width) {
        return ResponsiveDataChangeNotifier(
          breakpoints: breakpoints,
          testView: MockFlutterView(width),
        );
      }

      var notifier = buildNotifier(4096);

      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.jumboExtraLarge,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.jumboExtraLarge],
      );

      notifier = buildNotifier(3840);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.jumboLarge,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.jumboLarge],
      );

      notifier = buildNotifier(2560);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.jumboNormal,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.jumboNormal],
      );

      notifier = buildNotifier(1920);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.jumboSmall,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.jumboSmall],
      );

      notifier = buildNotifier(1280);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.standardExtraLarge,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.standardExtraLarge],
      );

      notifier = buildNotifier(1024);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.standardLarge,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.standardLarge],
      );

      notifier = buildNotifier(768);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.standardNormal,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.standardNormal],
      );
      notifier = buildNotifier(568);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.standardSmall,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.standardSmall],
      );

      notifier = buildNotifier(480);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.compactExtraLarge,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.compactExtraLarge],
      );

      notifier = buildNotifier(430);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.compactLarge,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.compactLarge],
      );

      notifier = buildNotifier(360);
      notifier.updateMetrics();
      expect(
        notifier.screenSize,
        LayoutSizeGranular.compactNormal,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.compactNormal],
      );

      notifier = buildNotifier(300);
      notifier.updateMetrics();

      expect(
        notifier.screenSize,
        LayoutSizeGranular.compactSmall,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.compactSmall],
      );

      notifier = buildNotifier(299);
      notifier.updateMetrics();

      expect(
        notifier.screenSize,
        LayoutSizeGranular.tiny,
      );
      expect(
        notifier.currentBreakpoint,
        breakpoints.values[LayoutSizeGranular.tiny],
      );
    });

    test('getHandler returns the correct handler based on the key provided',
        () {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final handlers = {
        'handler1': BreakpointsHandler<String>(
          breakpoints: breakpoints,
          extraLarge: '',
        ),
        'handler2': BreakpointsHandler<String>(
          breakpoints: breakpoints,
          extraLarge: '',
        ),
      };
      final notifier = ResponsiveDataChangeNotifier(
        breakpoints: breakpoints,
        handlers: handlers,
      );

      final handler1 = notifier.getHandler<String>('handler1');
      final handler2 = notifier.getHandler<String>('handler2');

      expect(handler1, equals(handlers['handler1']));
      expect(handler2, equals(handlers['handler2']));
    });

    test('getHandler throws AsertionError if handler is not found', () {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final handlers = {
        'handler1': BreakpointsHandler<String>(
          breakpoints: breakpoints,
          extraLarge: '',
        ),
        'handler2': BreakpointsHandler<String>(
          breakpoints: breakpoints,
          extraLarge: '',
        ),
      };
      final notifier = ResponsiveDataChangeNotifier(
        breakpoints: breakpoints,
        handlers: handlers,
      );

      expect(() => notifier.getHandler('key'), throwsAssertionError);
    });

    test(
        'ResponsiveDataChangeNotifier initializes with correct initial handlers',
        () {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final handlers = {
        'handler1': BreakpointsHandler<String>(
          breakpoints: breakpoints,
          extraLarge: '',
        ),
        'handler2': BreakpointsHandler<String>(
          breakpoints: breakpoints,
          extraLarge: '',
        ),
      };
      final notifier = ResponsiveDataChangeNotifier(
        breakpoints: breakpoints,
        handlers: handlers,
      );

      expect(notifier.handlers, equals(handlers));
    });
  });
}

class MockFlutterView extends Mock implements FlutterView {
  MockFlutterView(this.width);
  final double width;
  @override
  double get devicePixelRatio => 1;

  @override
  Size get physicalSize => Size(width, width);
}
