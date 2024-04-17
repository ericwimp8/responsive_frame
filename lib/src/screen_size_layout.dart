import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Widget with builders to return widgets based on [ScreenSize]
class ScreenSizeLayout extends StatefulWidget {
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
  State<ScreenSizeLayout> createState() => _ScreenSizeLayoutState();
}

class _ScreenSizeLayoutState extends State<ScreenSizeLayout> {
  late final contoller = BreakpointsController<Widget>(
    watch: widget.watch,
    mobile: widget.mobile,
    tablet: widget.tablet,
    desktop: widget.desktop,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final deviceWidth = constraints.maxWidth;

        return contoller.breakpointCallback(
          deviceWidth: deviceWidth,
          context: context,
        );
      },
    );
  }
}
