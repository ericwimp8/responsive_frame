import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Widget with builders to return widgets based on [ScreenSize]
class ScreenSizeLayoutBuilder extends StatefulWidget {
  const ScreenSizeLayoutBuilder({
    required this.mobile,
    this.desktopLarge,
    this.desktop,
    this.tablet,
    this.watch,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    super.key,
  });
  final Widget Function(BuildContext context)? desktopLarge;
  final Widget Function(BuildContext context)? desktop;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? watch;
  final Widget Function(BuildContext context) mobile;
  final BaseBreakpoints<ScreenSize> breakpoints;

  @override
  State<ScreenSizeLayoutBuilder> createState() =>
      _ScreenSizeLayoutBuilderState();
}

class _ScreenSizeLayoutBuilderState extends State<ScreenSizeLayoutBuilder> {
  late final contoller = BreakpointsController<Widget, ScreenSize>(
    callbacks: {
      ScreenSize.desktopLarge: widget.desktopLarge,
      ScreenSize.desktop: widget.desktop,
      ScreenSize.tablet: widget.tablet,
      ScreenSize.mobile: widget.mobile,
      ScreenSize.watch: widget.watch,
    },
    defaultValue: ScreenSize.mobile,
    breakpoints: Breakpoints.defaultBreakpoints,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return contoller.breakpointCallback(context);
      },
    );
  }
}
