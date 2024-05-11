import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('BreakpointsGranular', () {
    test('defaultBreakpoints has expected values', () {
      const breakpoints = BreakpointsGranular.defaultBreakpoints;
      expect(breakpoints.jumboExtraLarge, equals(4096.0));
      expect(breakpoints.jumboLarge, equals(3840.0));
      expect(breakpoints.jumboNormal, equals(2560.0));
      expect(breakpoints.jumboSmall, equals(1920.0));
      expect(breakpoints.standardExtraLarge, equals(1280.0));
      expect(breakpoints.standardLarge, equals(1024.0));
      expect(breakpoints.standardNormal, equals(768.0));
      expect(breakpoints.standardSmall, equals(568.0));
      expect(breakpoints.compactExtraLarge, equals(480.0));
      expect(breakpoints.compactLarge, equals(430.0));
      expect(breakpoints.compactNormal, equals(360.0));
      expect(breakpoints.compactSmall, equals(300.0));
    });

    test('BreakpointsGranular constructor sets values correctly', () {
      const breakpoints = BreakpointsGranular(
        jumboExtraLarge: 10000,
        jumboLarge: 9000,
        jumboNormal: 8000,
        jumboSmall: 7000,
        standardExtraLarge: 6000,
        standardLarge: 5000,
        standardNormal: 4000,
        standardSmall: 3500,
        compactExtraLarge: 3000,
        compactLarge: 2500,
        compactNormal: 2000,
        compactSmall: 1500,
      );

      expect(breakpoints.jumboExtraLarge, equals(10000));
      expect(breakpoints.jumboLarge, equals(9000));
      expect(breakpoints.jumboNormal, equals(8000));
      expect(breakpoints.jumboSmall, equals(7000));
      expect(breakpoints.standardExtraLarge, equals(6000));
      expect(breakpoints.standardLarge, equals(5000));
      expect(breakpoints.standardNormal, equals(4000));
      expect(breakpoints.standardSmall, equals(3500));
      expect(breakpoints.compactExtraLarge, equals(3000));
      expect(breakpoints.compactLarge, equals(2500));
      expect(breakpoints.compactNormal, equals(2000));
      expect(breakpoints.compactSmall, equals(1500));
      expect(
        breakpoints,
        const BreakpointsGranular(
          jumboExtraLarge: 10000,
          jumboLarge: 9000,
          jumboNormal: 8000,
          jumboSmall: 7000,
          standardExtraLarge: 6000,
          standardLarge: 5000,
          standardNormal: 4000,
          standardSmall: 3500,
          compactExtraLarge: 3000,
          compactLarge: 2500,
          compactNormal: 2000,
          compactSmall: 1500,
        ),
      );
    });

    test(
        'BreakpointsGranular constructor throws an error if values are not in descending order',
        () {
      expect(
        () => Breakpoints(
          extraLarge: 800,
        ),
        throwsAssertionError,
      );
    });

    test('BreakpointsGranular toString returns expected string', () {
      const breakpoints = BreakpointsGranular.defaultBreakpoints;

      const expectedString =
          'BreakpointsGranular(jumboExtraLarge: 4096.0, jumboLarge: 3840.0, jumboNormal: 2560.0, jumboSmall: 1920.0, standardExtraLarge: 1280.0, standardLarge: 1024.0, standardNormal: 768.0, standardSmall: 568.0, compactExtraLarge: 480.0, compactLarge: 430.0, compactNormal: 360.0, compactSmall: 300.0)';

      expect(breakpoints.toString(), equals(expectedString));
    });

    test('Breakpoints operator == returns true for equivalent instances', () {
      const breakpoints1 = BreakpointsGranular(
        jumboExtraLarge: 10000,
        jumboLarge: 9000,
        jumboNormal: 8000,
        jumboSmall: 7000,
        standardExtraLarge: 6000,
        standardLarge: 5000,
        standardNormal: 4000,
        standardSmall: 3500,
        compactExtraLarge: 3000,
        compactLarge: 2500,
        compactNormal: 2000,
        compactSmall: 1500,
      );
      const breakpoints2 = BreakpointsGranular(
        jumboExtraLarge: 10000,
        jumboLarge: 9000,
        jumboNormal: 8000,
        jumboSmall: 7000,
        standardExtraLarge: 6000,
        standardLarge: 5000,
        standardNormal: 4000,
        standardSmall: 3500,
        compactExtraLarge: 3000,
        compactLarge: 2500,
        compactNormal: 2000,
        compactSmall: 1500,
      );
      expect(breakpoints1 == breakpoints2, isTrue);
    });

    test(
        'Breakpoints hashCode returns different values for different instances',
        () {
      const breakpoints1 = BreakpointsGranular(
        jumboExtraLarge: 10000,
        jumboLarge: 9000,
        jumboNormal: 8000,
        jumboSmall: 7000,
        standardExtraLarge: 6000,
        standardLarge: 5000,
        standardNormal: 4000,
        standardSmall: 3500,
        compactExtraLarge: 3000,
        compactLarge: 2500,
        compactNormal: 2000,
        compactSmall: 1500,
      );
      const breakpoints2 = BreakpointsGranular.defaultBreakpoints;
      expect(breakpoints1.hashCode == breakpoints2.hashCode, isFalse);
    });

    test('copyWith method creates a new instance with updated values', () {
      const breakpoints = BreakpointsGranular.defaultBreakpoints;
      final updatedBreakpoints = breakpoints.copyWith(
        jumboExtraLarge: 10000,
        jumboLarge: 9000,
        jumboNormal: 8000,
        jumboSmall: 7000,
        standardExtraLarge: 6000,
        standardLarge: 5000,
        standardNormal: 4500,
        standardSmall: 4000,
        compactExtraLarge: 3500,
        compactLarge: 3000,
        compactNormal: 2500,
        compactSmall: 2000,
      );
      expect(
        updatedBreakpoints,
        const BreakpointsGranular(
          jumboExtraLarge: 10000,
          jumboLarge: 9000,
          jumboNormal: 8000,
          jumboSmall: 7000,
          standardExtraLarge: 6000,
          standardLarge: 5000,
          standardNormal: 4500,
          standardSmall: 4000,
          compactExtraLarge: 3500,
          compactLarge: 3000,
          compactNormal: 2500,
          compactSmall: 2000,
        ),
      );
    });

    test('copyWith method does not mutate the original instance', () {
      const breakpoints = BreakpointsGranular.defaultBreakpoints;
      final updatedBreakpoints = breakpoints.copyWith(
        jumboExtraLarge: 10000,
        jumboLarge: 9000,
        jumboNormal: 8000,
        jumboSmall: 7000,
        standardExtraLarge: 6000,
        standardLarge: 5000,
        standardNormal: 4500,
        standardSmall: 4000,
        compactExtraLarge: 3500,
        compactLarge: 3000,
        compactNormal: 2500,
        compactSmall: 2000,
      );

      expect(
        updatedBreakpoints,
        const BreakpointsGranular(
          jumboExtraLarge: 10000,
          jumboLarge: 9000,
          jumboNormal: 8000,
          jumboSmall: 7000,
          standardExtraLarge: 6000,
          standardLarge: 5000,
          standardNormal: 4500,
          standardSmall: 4000,
          compactExtraLarge: 3500,
          compactLarge: 3000,
          compactNormal: 2500,
          compactSmall: 2000,
        ),
      );
      expect(updatedBreakpoints == breakpoints, isFalse);
      expect(breakpoints == BreakpointsGranular.defaultBreakpoints, isTrue);
    });
  });
}
