import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsGranularController<T> {
  BreakpointsGranularController({
    required this.mobileNormal,
    this.desktopExtraLarge,
    this.desktopLarge,
    this.desktopNormal,
    this.desktopSmall,
    this.tabletExtraLarge,
    this.tabletLarge,
    this.tabletNormal,
    this.tabletSmall,
    this.mobileExtraLarge,
    this.mobileLarge,
    this.mobileSmall,
    this.watch,
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
  });
  final T Function(BuildContext context)? desktopExtraLarge;
  final T Function(BuildContext context)? desktopLarge;
  final T Function(BuildContext context)? desktopNormal;
  final T Function(BuildContext context)? desktopSmall;
  final T Function(BuildContext context)? tabletExtraLarge;
  final T Function(BuildContext context)? tabletLarge;
  final T Function(BuildContext context)? tabletNormal;
  final T Function(BuildContext context)? tabletSmall;
  final T Function(BuildContext context)? mobileExtraLarge;
  final T Function(BuildContext context)? mobileLarge;
  final T Function(BuildContext context) mobileNormal;
  final T Function(BuildContext context)? mobileSmall;
  final T Function(BuildContext context)? watch;
  final BreakpointsGranular breakpoints;

  ScreenSizeGranular? _screenSize;
  late T currentvalue;
  late final avalableCallbacks = {
    ScreenSizeGranular.desktopExtraLarge: desktopExtraLarge,
    ScreenSizeGranular.desktopLarge: desktopLarge,
    ScreenSizeGranular.desktopNormal: desktopNormal,
    ScreenSizeGranular.desktopSmall: desktopSmall,
    ScreenSizeGranular.tabletExtraLarge: tabletExtraLarge,
    ScreenSizeGranular.tabletLarge: tabletLarge,
    ScreenSizeGranular.tabletNormal: tabletNormal,
    ScreenSizeGranular.tabletSmall: tabletSmall,
    ScreenSizeGranular.mobileExtraLarge: mobileExtraLarge,
    ScreenSizeGranular.mobileLarge: mobileLarge,
    ScreenSizeGranular.mobileNormal: mobileNormal,
    ScreenSizeGranular.mobileSmall: mobileSmall,
    ScreenSizeGranular.watch: watch,
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
    final index = ScreenSizeGranular.values.indexOf(screenSize);
    final validBuilders = ScreenSizeGranular.values.sublist(index);
    for (final e in validBuilders) {
      final callback = avalableCallbacks[e];
      if (callback != null) {
        return callback(context);
      }
    }
    return avalableCallbacks[ScreenSizeGranular.mobileNormal]!(context);
  }
}
