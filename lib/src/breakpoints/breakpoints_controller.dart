import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsController<T> {
  BreakpointsController({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.desktopLarge,
    this.watch,
    this.breakpoints = Breakpoints.defaultBreakpoints,
  });

  final T Function(BuildContext context, BoxConstraints contraints)? watch;
  final T Function(BuildContext context, BoxConstraints contraints) mobile;
  final T Function(BuildContext context, BoxConstraints contraints)? tablet;
  final T Function(BuildContext context, BoxConstraints contraints)? desktop;
  final T Function(BuildContext context, BoxConstraints contraints)?
      desktopLarge;
  final Breakpoints breakpoints;

  ScreenSize? screenSize;
  T Function(BuildContext context, BoxConstraints constraints)? currentvalue;
  late final avalableCallbacks = {
    ScreenSize.desktopLarge: desktopLarge,
    ScreenSize.desktop: desktop,
    ScreenSize.tablet: tablet,
    ScreenSize.mobile: mobile,
    ScreenSize.watch: watch,
  };

  /// Map that maps [ScreenSize] to it's [Breakpoints] value

  T Function(BuildContext context, BoxConstraints constraints)
      breakpointCallback({
    required double deviceWidth,
    required BuildContext context,
  }) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _screenSize = breakpoints.getScreenSize(deviceWidth: deviceWidth);

    if (screenSize == _screenSize && currentvalue != null) return currentvalue!;

    screenSize = _screenSize;
    final callback = avalableCallbacks[screenSize];
    if (callback != null) {
      currentvalue = callback;
      return callback;
    }
    final index = ScreenSize.values.indexOf(screenSize!);
    final validBuilders = ScreenSize.values.sublist(index);
    for (final e in validBuilders) {
      final callback = avalableCallbacks[e];
      if (callback != null) {
        currentvalue = callback;
        return currentvalue!;
      }
    }

    currentvalue = avalableCallbacks[ScreenSize.mobile];
    return currentvalue!;
  }

  /// Returns the breakpoint value given a device width
  double getBreakpointFromWidth(double deviceWidth) {
    return breakpoints.getBreakpointFromWidth(
      deviceWidth,
      screenSize: screenSize,
    );
  }

  /// Returns the [ScreenSize] given a [deviceWidth]
  ScreenSize getScreenSize({required double deviceWidth}) {
    return breakpoints.getScreenSize(deviceWidth: deviceWidth);
  }

  /// Returns the breakpoint value for a given [ScreenSize]
  double getBreakPointFromScreenSize(ScreenSize screenSize) {
    return breakpoints.getBreakPointFromScreenSize(screenSize);
  }
}
