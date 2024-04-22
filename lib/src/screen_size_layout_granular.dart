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
  late final controller = BreakpointsController<Widget, ScreenSizeGranular>(
    callbacks: {
      ScreenSizeGranular.desktopExtraLarge: widget.desktopExtraLarge,
      ScreenSizeGranular.desktopLarge: widget.desktopLarge,
      ScreenSizeGranular.desktopNormal: widget.desktopNormal,
      ScreenSizeGranular.desktopSmall: widget.desktopSmall,
      ScreenSizeGranular.tabletExtraLarge: widget.tabletExtraLarge,
      ScreenSizeGranular.tabletLarge: widget.tabletLarge,
      ScreenSizeGranular.tabletNormal: widget.tabletNormal,
      ScreenSizeGranular.tabletSmall: widget.tabletSmall,
      ScreenSizeGranular.mobileExtraLarge: widget.mobileExtraLarge,
      ScreenSizeGranular.mobileLarge: widget.mobileLarge,
      ScreenSizeGranular.mobileNormal: widget.mobileNormal,
      ScreenSizeGranular.mobileSmall: widget.mobileSmall,
      ScreenSizeGranular.watch: widget.watch,
    },
    defaultValue: ScreenSizeGranular.mobileNormal,
    breakpoints: Breakpoints.defaultBreakpointsGranular,
  );
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return controller.breakpointCallback(context);
      },
    );
  }
}
