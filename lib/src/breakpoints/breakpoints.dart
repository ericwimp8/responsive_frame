import 'package:flutter/foundation.dart';

@immutable
class Breakpoints<T extends Enum> {
  factory Breakpoints.create({
    required Map<T, double> values,
  }) {
    assert(isDescendingOrder<T>(values), 'Values must be in descending order.');
    return Breakpoints._(
      values: values,
    );
  }

  const Breakpoints._({
    required this.values,
  });

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

  @override
  String toString() => 'Breakpoints(values: $values)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breakpoints<T> && mapEquals(other.values, values);
  }

  @override
  int get hashCode => values.hashCode;
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
