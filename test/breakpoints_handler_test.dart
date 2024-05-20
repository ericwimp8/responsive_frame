import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  group('BaseBreakpointsHandler', () {
    test(
        'getLayoutSizeValue should return correct value, when all values are supplied.',
        () {
      final handler = BreakpointsHandler<int>(
        extraLarge: 10,
        large: 9,
        medium: 8,
        small: 7,
        extraSmall: 6,
      );

      var value = handler.getLayoutSizeValue(1200);
      expect(value, 10);
      value = handler.getLayoutSizeValue(1199);
      expect(value, 9);
      value = handler.getLayoutSizeValue(950);
      expect(value, 9);
      value = handler.getLayoutSizeValue(949);
      expect(value, 8);
      value = handler.getLayoutSizeValue(600);
      expect(value, 8);
      value = handler.getLayoutSizeValue(599);
      expect(value, 7);
      value = handler.getLayoutSizeValue(300);
      expect(value, 7);
      value = handler.getLayoutSizeValue(299);
      expect(value, 6);
    });

    test(
        'getLayoutSizeValue should return correct value, when only single values supplied.',
        () {
      var handler = BreakpointsHandler<int>(
        extraLarge: 10,
      );

      var value = handler.getLayoutSizeValue(1200);
      expect(value, 10);

      handler = BreakpointsHandler<int>(
        large: 9,
      );

      value = handler.getLayoutSizeValue(950);
      expect(value, 9);

      handler = BreakpointsHandler<int>(
        large: 8,
      );

      value = handler.getLayoutSizeValue(600);
      expect(value, 8);

      handler = BreakpointsHandler<int>(
        medium: 7,
      );

      value = handler.getLayoutSizeValue(300);
      expect(value, 7);

      handler = BreakpointsHandler<int>(
        medium: 6,
      );

      value = handler.getLayoutSizeValue(299);
      expect(value, 6);
    });

    test(
        'getLayoutSizeValue should return the next lowest value when value is not supplied for the current breakpoint.',
        () {
      var handler = BreakpointsHandler<int>(
        large: 9,
      );

      var value = handler.getLayoutSizeValue(1200);
      expect(value, 9);

      handler = BreakpointsHandler<int>(
        medium: 8,
      );

      value = handler.getLayoutSizeValue(950);
      expect(value, 8);

      handler = BreakpointsHandler<int>(
        extraSmall: 7,
      );

      value = handler.getLayoutSizeValue(1200);
      expect(value, 7);
    });

    test(
        'getLayoutSizeValue should return the next highest value when current value is null and all lower values are null.',
        () {
      final handler = BreakpointsHandler<int>(
        large: 9,
      );

      var value = handler.getLayoutSizeValue(600);
      expect(value, 9);
      value = handler.getLayoutSizeValue(300);
      expect(value, 9);
      value = handler.getLayoutSizeValue(299);
      expect(value, 9);
    });

    test('getLayoutSizeValue should throw an assertion error when size < 0.',
        () {
      final handler = BreakpointsHandler<int>(
        large: 9,
      );

      expect(() => handler.getLayoutSizeValue(-1), throwsAssertionError);
    });

    test(
        'BreakpointsHandler should throw assertion error when all values are null.',
        () {
      BreakpointsHandler<int> createHandler() {
        return BreakpointsHandler<int>();
      }

      expect(
        createHandler,
        throwsAssertionError,
      );
    });
    test('getScreenSize should return the correct screen size.', () {
      final handler = BreakpointsHandler<int>(
        large: 9,
      );

      expect(handler.getScreenSize(1200), LayoutSize.extraLarge);
      expect(handler.getScreenSize(1199), LayoutSize.large);
      expect(handler.getScreenSize(950), LayoutSize.large);
      expect(handler.getScreenSize(949), LayoutSize.medium);
      expect(handler.getScreenSize(600), LayoutSize.medium);
      expect(handler.getScreenSize(599), LayoutSize.small);
      expect(handler.getScreenSize(300), LayoutSize.small);
      expect(handler.getScreenSize(299), LayoutSize.extraSmall);
      expect(handler.getScreenSize(0), LayoutSize.extraSmall);
    });

    test('getScreenSize should return smallest screen size when size is -1.',
        () {
      final handler = BreakpointsHandler<int>(
        large: 9,
      );

      expect(handler.getScreenSize(-1), LayoutSize.extraSmall);
    });
  });
}
