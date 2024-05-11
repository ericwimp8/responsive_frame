import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('Breakpoints', () {
    test('defaultBreakpoints has expected values', () {
      const breakpoints = Breakpoints.defaultBreakpoints;
      expect(breakpoints.extraLarge, equals(1200.0));
      expect(breakpoints.large, equals(950.0));
      expect(breakpoints.medium, equals(600.0));
      expect(breakpoints.small, equals(300.0));
    });

    test('Breakpoints constructor sets values correctly', () {
      const breakpoints = Breakpoints(
        extraLarge: 1000,
        large: 800,
        medium: 500,
        small: 280,
      );
      expect(breakpoints.extraLarge, equals(1000.0));
      expect(breakpoints.large, equals(800.0));
      expect(breakpoints.medium, equals(500.0));
      expect(breakpoints.small, equals(280.0));

      expect(
        breakpoints,
        const Breakpoints(
          extraLarge: 1000,
          large: 800,
          medium: 500,
          small: 280,
        ),
      );
    });

    test(
        'Breakpoints constructor throws an error if values are not in descending order',
        () {
      expect(
        () => Breakpoints(
          extraLarge: 800,
        ),
        throwsAssertionError,
      );
    });

    test('Breakpoints toString returns expected string', () {
      const breakpoints = Breakpoints(
        extraLarge: 1000,
        large: 800,
        medium: 500,
      );
      expect(
        breakpoints.toString(),
        equals(
          'Breakpoints(extraLarge: 1000.0, large: 800.0, medium: 500.0, small: 300.0)',
        ),
      );
    });

    test('Breakpoints operator == returns true for equivalent instances', () {
      const breakpoints1 = Breakpoints(
        extraLarge: 1000,
        large: 800,
        medium: 500,
      );
      const breakpoints2 = Breakpoints(
        extraLarge: 1000,
        large: 800,
        medium: 500,
      );
      expect(breakpoints1 == breakpoints2, isTrue);
    });

    test(
        'Breakpoints hashCode returns different values for different instances',
        () {
      const breakpoints1 = Breakpoints(
        extraLarge: 1000,
        large: 800,
        medium: 500,
      );
      const breakpoints2 = Breakpoints.defaultBreakpoints;
      expect(breakpoints1.hashCode == breakpoints2.hashCode, isFalse);
    });

    test('copyWith method creates a new instance with updated values', () {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final updatedBreakpoints = breakpoints.copyWith(
        extraLarge: 10000,
        large: 9000,
        medium: 8000,
        small: 7000,
      );

      expect(
        updatedBreakpoints,
        const Breakpoints(
          extraLarge: 10000,
          large: 9000,
          medium: 8000,
          small: 7000,
        ),
      );
    });

    test('copyWith method does not mutate the original instance', () {
      const breakpoints = Breakpoints.defaultBreakpoints;
      final updatedBreakpoints = breakpoints.copyWith(
        extraLarge: 10000,
      );

      expect(updatedBreakpoints == breakpoints, isFalse);
      expect(breakpoints == Breakpoints.defaultBreakpoints, isTrue);
    });
  });
}
