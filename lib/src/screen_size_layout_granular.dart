import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Widget with builders to return layout widgets based on
/// device width
class ScreenSizeLayoutGranular extends StatefulWidget {
  const ScreenSizeLayoutGranular({
    required this.mobileNormal,
    this.breakpoints = Breakpoints.defaultBreakpointsGranular,
    super.key,
    this.mobileExtraLarge,
    this.mobileLarge,
    this.mobileSmall,
    this.tabletExtraLarge,
    this.tabletLarge,
    this.tabletNormal,
    this.tabletSmall,
    this.desktopExtraLarge,
    this.desktopLarge,
    this.desktopNormal,
    this.desktopSmall,
    this.watch,
  });
  final Widget Function(BuildContext context)? desktopExtraLarge;
  final Widget Function(BuildContext context)? desktopLarge;
  final Widget Function(BuildContext context)? desktopNormal;
  final Widget Function(BuildContext context)? desktopSmall;
  final Widget Function(BuildContext context)? tabletExtraLarge;
  final Widget Function(BuildContext context)? tabletLarge;
  final Widget Function(BuildContext context)? tabletNormal;
  final Widget Function(BuildContext context)? tabletSmall;
  final Widget Function(BuildContext context)? mobileExtraLarge;
  final Widget Function(BuildContext context)? mobileLarge;
  final Widget Function(BuildContext context) mobileNormal;
  final Widget Function(BuildContext context)? mobileSmall;
  final Widget Function(BuildContext context)? watch;

  final Breakpoints<ScreenSizeGranular> breakpoints;

  @override
  State<ScreenSizeLayoutGranular> createState() =>
      _ScreenSizeLayoutGranularState();
}

class _ScreenSizeLayoutGranularState extends State<ScreenSizeLayoutGranular> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     return controller.breakpointCallback(context);
    //   },
    // );
  }
}
