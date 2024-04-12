import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Widget with builders to return widgets based on [ScreenSize]
class ScreenSizeLayout extends StatelessWidget {
  const ScreenSizeLayout({
    required this.mobile,
    this.desktop,
    this.tablet,
    this.watch,
    this.breakpoints = Breakpoints.defaultBreakpoints,
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

        final screensize = breakpoints.screenSize(deviceWidth: deviceWidth);

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
