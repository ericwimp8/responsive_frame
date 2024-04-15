import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsController<T> {
  BreakpointsController({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.watch,
    this.breakpoints = Breakpoints.defaultBreakpoints,
  });

  final T Function(BuildContext context)? watch;
  final T Function(BuildContext context) mobile;
  final T Function(BuildContext context)? tablet;
  final T Function(BuildContext context)? desktop;
  final Breakpoints breakpoints;

  ScreenSize? _screenSize;
  late T currentvalue;
  late final avalableCallbacks = {
    ScreenSize.desktop: desktop,
    ScreenSize.tablet: tablet,
    ScreenSize.mobile: mobile,
    ScreenSize.watch: watch,
  };

  T breakpointCallback({
    required double deviceWidth,
    required BuildContext context,
  }) {
    final screenSize = breakpoints.screenSize(deviceWidth: deviceWidth);

    if (_screenSize == screenSize) return currentvalue;
    final callback = avalableCallbacks[screenSize];
    if (callback != null) {
      return callback(context);
    }
    final index = ScreenSize.values.indexOf(screenSize);
    final validBuilders = ScreenSize.values.sublist(index);
    for (final e in validBuilders) {
      final callback = avalableCallbacks[e];
      if (callback != null) {
        return callback(context);
      }
    }

    throw Exception(
      'BreakpointController.breakpointCallback: callback not found',
    );
  }
}
