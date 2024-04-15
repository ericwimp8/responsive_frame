import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/breakpoints/breakpoints_granular.dart';
import 'package:responsive_frame/src/breakpoints/breakpoints_granular_controller.dart';

/// Widget with builders to return layout widgets based on
/// device width
class ScreenSizeLayoutGranular extends StatefulWidget {
  const ScreenSizeLayoutGranular({
    required this.mobileNormal,
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
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

  final BreakpointsGranular breakpoints;

  @override
  State<ScreenSizeLayoutGranular> createState() =>
      _ScreenSizeLayoutGranularState();
}

class _ScreenSizeLayoutGranularState extends State<ScreenSizeLayoutGranular> {
  late final controller = BreakpointsGranularController<Widget>(
    desktopExtraLarge: widget.desktopExtraLarge,
    desktopLarge: widget.desktopLarge,
    desktopNormal: widget.desktopNormal,
    desktopSmall: widget.desktopSmall,
    tabletExtraLarge: widget.tabletExtraLarge,
    tabletLarge: widget.tabletLarge,
    tabletNormal: widget.tabletNormal,
    tabletSmall: widget.tabletSmall,
    mobileExtraLarge: widget.mobileExtraLarge,
    mobileLarge: widget.mobileLarge,
    mobileNormal: widget.mobileNormal,
    mobileSmall: widget.mobileSmall,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final deviceWidth = MediaQuery.sizeOf(context).width;

        return controller.breakpointCallback(
          deviceWidth: deviceWidth,
          context: context,
        );
      },
    );
  }
}
