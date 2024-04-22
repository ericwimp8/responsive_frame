import 'package:flutter/widgets.dart';

/// A utility class for managing screen breakpoints and determining appropriate layouts based on screen size.
/// /// Example usage of the [Breakpoints] class with default breakpoint values.
///
/// This example demonstrates how to create an instance of [Breakpoints] using the default breakpoint values
/// defined in [Breakpoints.defaultValues]. It calculates the current breakpoint and screen size based on
/// the device's characteristics.
///
/// ```dart
/// final breakpoints = Breakpoints.create(
///   values: {
///     ScreenSize.desktopLarge: 1200.0,
///     ScreenSize.desktop: 950.0,
///     ScreenSize.tablet: 600.0,
///     ScreenSize.mobile: 300.0,
///     ScreenSize.watch: 0.0,
///   },
///   useShortestSide: true,
/// );
///
/// final currentBreakpoint = breakpoints.getBreakpoint();
/// final currentScreenSize = breakpoints.getScreenSize();
/// ```
///
/// In this example:
/// - The `breakpoints` variable is initialized with default breakpoint values and the `useShortestSide` flag set to `true`.
/// - `currentBreakpoint` retrieves the current breakpoint value based on the device's screen size.
/// - `currentScreenSize` retrieves the screen size type based on the device's screen width.
///
///
class Breakpoints<T> {
  /// Creates an instance of [Breakpoints].
  ///
  /// [values] is a map that associates screen size types (`T`) with their corresponding breakpoint values (`double`).
  /// [useShortestSide] is an optional parameter indicating whether to use the shortest side of the screen for calculations.
  ///
  /// Throws an [AssertionError] if the breakpoint values are not in descending order.
  factory Breakpoints.create({
    required Map<T, double> values,
    bool useShortestSide = false,
  }) {
    assert(isDescendingOrder<T>(values), 'Values must be in descending order.');
    return Breakpoints._(
      values: values,
      useShortestSide: useShortestSide,
    );
  }

  /// Private constructor for [Breakpoints].
  const Breakpoints._({
    required this.values,
    this.useShortestSide = false,
  });

  /// Indicates whether to use the shortest side of the screen for calculations.
  final bool useShortestSide;

  /// A map that associates screen size types (`T`) with their corresponding breakpoint values (`double`).
  final Map<T, double> values;

  /// Default instance of [Breakpoints] for standard screen size breakpoints.
  static const defaultBreakpoints = Breakpoints._(values: defaultValues);

  /// Default breakpoint values for standard screen sizes.
  static const defaultValues = {
    ScreenSize.desktopLarge: 1200.0,
    ScreenSize.desktop: 950.0,
    ScreenSize.tablet: 600.0,
    ScreenSize.mobile: 300.0,
    ScreenSize.watch: 0.0,
  };

  /// Default instance of [Breakpoints] for more granular screen size breakpoints.
  static const defaultBreakpointsGranular =
      Breakpoints._(values: defaultValuesGranular);

  /// Default breakpoint values for granular screen sizes.
  static const defaultValuesGranular = {
    ScreenSizeGranular.desktopExtraLarge: 4096.0,
    ScreenSizeGranular.desktopLarge: 3840.0,
    ScreenSizeGranular.desktopNormal: 2560.0,
    ScreenSizeGranular.desktopSmall: 1920.0,
    ScreenSizeGranular.tabletExtraLarge: 1280.0,
    ScreenSizeGranular.tabletLarge: 1024.0,
    ScreenSizeGranular.tabletNormal: 768.0,
    ScreenSizeGranular.tabletSmall: 568.0,
    ScreenSizeGranular.mobileExtraLarge: 480.0,
    ScreenSizeGranular.mobileLarge: 420.0,
    ScreenSizeGranular.mobileNormal: 306.0,
    ScreenSizeGranular.mobileSmall: 300.0,
    ScreenSizeGranular.watch: 0.0,
  };

  /// Checks if the breakpoint values are in descending order.
  static bool isDescendingOrder<T>(Map<T, double> values) {
    double? previousValue;
    for (final value in values.values) {
      if (previousValue != null && value >= previousValue) {
        return false;
      }
      previousValue = value;
    }
    return true;
  }

  /// Gets the current breakpoint value based on the device's screen size.
  double getBreakpoint() {
    return values[getScreenSize()]!;
  }

  /// Gets the screen size type (`T`) based on the device's screen width.
  T getScreenSize() {
    for (final entry in values.entries) {
      if (deviceWidth() >= entry.value) {
        return entry.key;
      }
    }
    return values
        .entries.last.key; // Default to the smallest size if none match
  }

  /// Gets the device's screen width in logical pixels, considering the `useShortestSide` flag if set.
  double deviceWidth() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    if (useShortestSide) {
      return size.shortestSide / pixelRatio;
    }
    return size.width / pixelRatio;
  }

  /// Returns a string representation of the [Breakpoints] instance.
  @override
  String toString() =>
      'Breakpoints(useShortestSide: $useShortestSide, values: $values)';
}

/// Enumerates granular screen size types for more detailed breakpoint handling.
enum ScreenSizeGranular {
  desktopExtraLarge,
  desktopLarge,
  desktopNormal,
  desktopSmall,
  tabletExtraLarge,
  tabletLarge,
  tabletNormal,
  tabletSmall,
  mobileExtraLarge,
  mobileLarge,
  mobileNormal,
  mobileSmall,
  watch,
}

/// Enumerates standard screen size types for basic breakpoint handling.
enum ScreenSize {
  desktopLarge,
  desktop,
  tablet,
  mobile,
  watch,
}
