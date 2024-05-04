import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ScreenSizeLayoutBuilder extends StatefulWidget {
  const ScreenSizeLayoutBuilder({
    this.extraLarge,
    this.large,
    this.medium,
    this.small,
    this.extraSmall,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    super.key,
  });
  final Widget Function(BuildContext context)? extraLarge;
  final Widget Function(BuildContext context)? large;
  final Widget Function(BuildContext context)? medium;
  final Widget Function(BuildContext context)? small;
  final Widget Function(BuildContext context)? extraSmall;
  final Breakpoints breakpoints;

  @override
  State<ScreenSizeLayoutBuilder> createState() =>
      _ScreenSizeLayoutBuilderState();
}

class _ScreenSizeLayoutBuilderState extends State<ScreenSizeLayoutBuilder> {
  // late final contoller = BreakpointsController<Widget, ScreenSize>(
  //   callbacks: {
  //     ScreenSize.desktopLarge: widget.desktopLarge,
  //     ScreenSize.desktop: widget.desktop,
  //     ScreenSize.tablet: widget.tablet,
  //     ScreenSize.mobile: widget.mobile,
  //     ScreenSize.watch: widget.watch,
  //   },
  //   defaultValue: ScreenSize.mobile,
  //   breakpoints: Breakpoints.defaultBreakpoints,
  // );

  @override
  Widget build(BuildContext context) {
    return Container();
    // return LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     return contoller.breakpointCallback(context);
    //   },
    // );
  }
}
