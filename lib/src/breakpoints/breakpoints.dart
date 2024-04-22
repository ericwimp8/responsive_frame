import 'package:flutter/material.dart';

class Breakpoints<T> {
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
  const Breakpoints._({
    required this.values,
    this.useShortestSide = false,
  });
  final bool useShortestSide;
  final Map<T, double> values;

  static const defaultBreakpoints =
      Breakpoints<ScreenSize>._(values: defaultValues);

  static const defaultValues = {
    ScreenSize.desktopLarge: 1200.0,
    ScreenSize.desktop: 950.0,
    ScreenSize.tablet: 600.0,
    ScreenSize.mobile: 300.0,
    ScreenSize.watch: 0.0,
  };

  static const defaultBreakpointsGranular =
      Breakpoints<ScreenSizeGranular>._(values: defaultValuesGranular);

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

  double getBreakpoint() {
    return values[getScreenSize()]!;
  }

  T getScreenSize() {
    for (final entry in values.entries) {
      if (deviceWidth() >= entry.value) {
        return entry.key;
      }
    }

    return values
        .entries.last.key; // Default to the smallest size if none match
  }

  double deviceWidth() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    if (useShortestSide) {
      return view.physicalSize.shortestSide / pixelRatio;
    }
    return size.width / pixelRatio;
  }

  @override
  String toString() =>
      'BaseBreakpoints(useShortestSide: $useShortestSide, values: $values)';
}

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

enum ScreenSize {
  desktopLarge,
  desktop,
  tablet,
  mobile,
  watch,
}
