import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Indicators for screen size
enum ScreenSize { watch, mobile, tablet, desktop }

/// Get the current [ScreenSize] based on [deviceWidth]
///
/// [breakpoints] have default values defined in [Breakpoints]
ScreenSize getDeviceType({
  required double deviceWidth,
  Breakpoints breakpoints = Breakpoints.defaultBreakPoints,
}) {
  if (deviceWidth > breakpoints.desktop) return ScreenSize.desktop;
  if (deviceWidth > breakpoints.tablet) return ScreenSize.tablet;
  if (deviceWidth > breakpoints.mobile) return ScreenSize.mobile;
  return ScreenSize.watch;
}

/// Each field represents the values greater than the given argument and below the next highest
/// argument
///
/// By default [desktop] >950, [tablet] <=950 and >600, [mobile] <=600 >300, watch <=300 not
/// needed in the arguments
class Breakpoints {
  const Breakpoints({
    this.desktop = 950,
    this.tablet = 600,
    this.mobile = 300,
  });

  final double desktop;
  final double tablet;
  final double mobile;

  static const defaultBreakPoints = Breakpoints();
}

/// Widget with builders to return widgets based on [ScreenSize]
class ScreenSizeLayout extends StatelessWidget {
  const ScreenSizeLayout({
    required this.mobile,
    this.desktop,
    this.tablet,
    this.watch,
    this.breakpoints = Breakpoints.defaultBreakPoints,
    super.key,
  });
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;
  final Widget Function(BuildContext context)? watch;
  final Breakpoints breakpoints;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final deviceWidth = MediaQuery.sizeOf(context).width;

        final screensize =
            getDeviceType(deviceWidth: deviceWidth, breakpoints: breakpoints);

        /// return different builders based on screen size defaults to
        /// mobile builder if there is no supplied builder for the case
        return switch (screensize) {
          ScreenSize.watch => watch?.call(context) ?? mobile(context),
          ScreenSize.mobile => mobile(context),
          ScreenSize.tablet => tablet?.call(context) ?? mobile(context),
          ScreenSize.desktop =>
            desktop?.call(context) ?? tablet?.call(context) ?? mobile(context),
        };
      },
    );
  }
}
