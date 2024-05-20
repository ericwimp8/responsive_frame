import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('BaseBreakpointsHandlerGranular', () {
    test(
        'getLayoutSizeValue should return correct value, when all values are supplied.',
        () {
      final handler = BreakpointsHandlerGranular<int>(
        jumboExtraLarge: 10,
        jumboLarge: 9,
        jumboNormal: 8,
        jumboSmall: 7,
        standardExtraLarge: 6,
        standardLarge: 5,
        standardNormal: 4,
        standardSmall: 3,
        compactExtraLarge: 2,
        compactLarge: 1,
        compactNormal: 0,
        compactSmall: -1,
        tiny: -2,
      );

      var value = handler.getLayoutSizeValue(4096);
      expect(value, 10);
      value = handler.getLayoutSizeValue(4095);
      expect(value, 9);
      value = handler.getLayoutSizeValue(3840);
      expect(value, 9);
      value = handler.getLayoutSizeValue(3839);
      expect(value, 8);
      value = handler.getLayoutSizeValue(2560);
      expect(value, 8);
      value = handler.getLayoutSizeValue(2559);
      expect(value, 7);
      value = handler.getLayoutSizeValue(1920);
      expect(value, 7);
      value = handler.getLayoutSizeValue(1919);
      expect(value, 6);
      value = handler.getLayoutSizeValue(1280);
      expect(value, 6);
      value = handler.getLayoutSizeValue(1279);
      expect(value, 5);
      value = handler.getLayoutSizeValue(1024);
      expect(value, 5);
      value = handler.getLayoutSizeValue(1023);
      expect(value, 4);
      value = handler.getLayoutSizeValue(768);
      expect(value, 4);
      value = handler.getLayoutSizeValue(767);
      expect(value, 3);
      value = handler.getLayoutSizeValue(568);
      expect(value, 3);
      value = handler.getLayoutSizeValue(567);
      expect(value, 2);
      value = handler.getLayoutSizeValue(480);
      expect(value, 2);
      value = handler.getLayoutSizeValue(479);
      expect(value, 1);
      value = handler.getLayoutSizeValue(430);
      expect(value, 1);
      value = handler.getLayoutSizeValue(429);
      expect(value, 0);
      value = handler.getLayoutSizeValue(360);
      expect(value, 0);
      value = handler.getLayoutSizeValue(359);
      expect(value, -1);
      value = handler.getLayoutSizeValue(300);
      expect(value, -1);
      value = handler.getLayoutSizeValue(299);
      expect(value, -2);
    });

    test(
        'getLayoutSizeValue should return correct value, when only single values supplied.',
        () {
      var handler = BreakpointsHandlerGranular<int>(
        jumboExtraLarge: 10,
      );
      var value = handler.getLayoutSizeValue(4096);
      expect(value, 10);

      handler = BreakpointsHandlerGranular<int>(
        jumboLarge: 9,
      );
      value = handler.getLayoutSizeValue(3840);
      expect(value, 9);

      handler = BreakpointsHandlerGranular<int>(
        jumboNormal: 8,
      );
      value = handler.getLayoutSizeValue(2560);
      expect(value, 8);

      handler = BreakpointsHandlerGranular<int>(
        jumboSmall: 7,
      );
      value = handler.getLayoutSizeValue(1920);
      expect(value, 7);

      handler = BreakpointsHandlerGranular<int>(
        standardExtraLarge: 6,
      );
      value = handler.getLayoutSizeValue(1280);
      expect(value, 6);

      handler = BreakpointsHandlerGranular<int>(
        standardLarge: 5,
      );
      value = handler.getLayoutSizeValue(1024);
      expect(value, 5);

      handler = BreakpointsHandlerGranular<int>(
        standardNormal: 4,
      );
      value = handler.getLayoutSizeValue(768);
      expect(value, 4);

      handler = BreakpointsHandlerGranular<int>(
        standardSmall: 3,
      );
      value = handler.getLayoutSizeValue(568);
      expect(value, 3);

      handler = BreakpointsHandlerGranular<int>(
        compactExtraLarge: 2,
      );
      value = handler.getLayoutSizeValue(480);
      expect(value, 2);

      handler = BreakpointsHandlerGranular<int>(
        compactLarge: 1,
      );
      value = handler.getLayoutSizeValue(430);
      expect(value, 1);

      handler = BreakpointsHandlerGranular<int>(
        compactNormal: 0,
      );
      value = handler.getLayoutSizeValue(360);
      expect(value, 0);

      handler = BreakpointsHandlerGranular<int>(
        compactSmall: -1,
      );
      value = handler.getLayoutSizeValue(300);
      expect(value, -1);

      handler = BreakpointsHandlerGranular<int>(
        tiny: -2,
      );
      value = handler.getLayoutSizeValue(299);
      expect(value, -2);
    });

    test(
        'getLayoutSizeValue should return the next lowest value when value is not supplied for the current breakpoint.',
        () {
      var handler = BreakpointsHandlerGranular<int>(
        standardExtraLarge: 9,
      );

      var value = handler.getLayoutSizeValue(4096);
      expect(value, 9);

      handler = BreakpointsHandlerGranular<int>(
        tiny: 8,
      );

      value = handler.getLayoutSizeValue(950);
      expect(value, 8);
    });

    test(
        'getLayoutSizeValue should return the next highest value when current value is null and all lower values are null.',
        () {
      final handler = BreakpointsHandlerGranular<int>(
        compactLarge: 9,
      );
      var value = handler.getLayoutSizeValue(300);
      expect(value, 9);
      value = handler.getLayoutSizeValue(360);
      expect(value, 9);
      value = handler.getLayoutSizeValue(299);
      expect(value, 9);
    });

    test('getLayoutSizeValue should throw an assertion error when size < 0.',
        () {
      final handler = BreakpointsHandlerGranular<int>(
        jumboLarge: 9,
      );

      expect(() => handler.getLayoutSizeValue(-1), throwsAssertionError);
    });

    test(
        'BreakpointsHandler should throw assertion error when all values are null.',
        () {
      BreakpointsHandlerGranular<int> createHandler() {
        return BreakpointsHandlerGranular<int>();
      }

      expect(
        createHandler,
        throwsAssertionError,
      );
    });
    test('getScreenSize should return the correct screen size.', () {
      final handler = BreakpointsHandlerGranular<int>(
        jumboLarge: 9,
      );

      expect(handler.getScreenSize(4096), LayoutSizeGranular.jumboExtraLarge);
      expect(handler.getScreenSize(4095), LayoutSizeGranular.jumboLarge);
      expect(handler.getScreenSize(3840), LayoutSizeGranular.jumboLarge);
      expect(handler.getScreenSize(3839), LayoutSizeGranular.jumboNormal);
      expect(handler.getScreenSize(2560), LayoutSizeGranular.jumboNormal);
      expect(handler.getScreenSize(2559), LayoutSizeGranular.jumboSmall);
      expect(
        handler.getScreenSize(1920),
        LayoutSizeGranular.jumboSmall,
      );
      expect(
        handler.getScreenSize(1919),
        LayoutSizeGranular.standardExtraLarge,
      );
      expect(
        handler.getScreenSize(1280),
        LayoutSizeGranular.standardExtraLarge,
      );
      expect(handler.getScreenSize(1279), LayoutSizeGranular.standardLarge);
      expect(handler.getScreenSize(1024), LayoutSizeGranular.standardLarge);
      expect(handler.getScreenSize(1023), LayoutSizeGranular.standardNormal);
      expect(handler.getScreenSize(768), LayoutSizeGranular.standardNormal);
      expect(handler.getScreenSize(676), LayoutSizeGranular.standardSmall);
      expect(handler.getScreenSize(568), LayoutSizeGranular.standardSmall);
      expect(handler.getScreenSize(567), LayoutSizeGranular.compactExtraLarge);
      expect(handler.getScreenSize(480), LayoutSizeGranular.compactExtraLarge);
      expect(handler.getScreenSize(479), LayoutSizeGranular.compactLarge);
      expect(handler.getScreenSize(430), LayoutSizeGranular.compactLarge);
      expect(handler.getScreenSize(429), LayoutSizeGranular.compactNormal);
      expect(handler.getScreenSize(360), LayoutSizeGranular.compactNormal);
      expect(handler.getScreenSize(359), LayoutSizeGranular.compactSmall);
      expect(handler.getScreenSize(300), LayoutSizeGranular.compactSmall);
      expect(handler.getScreenSize(299), LayoutSizeGranular.tiny);
    });

    test('getScreenSize should return smallest screen size when size is -1.',
        () {
      final handler = BreakpointsHandlerGranular<int>(
        jumboExtraLarge: 9,
      );

      expect(handler.getScreenSize(-1), LayoutSizeGranular.tiny);
    });
  });
}
