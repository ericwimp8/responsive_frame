import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Widget with builders to return widgets based on [ScreenSize]
class ScreenSizeLayoutBuilder extends StatefulWidget {
  const ScreenSizeLayoutBuilder({
    required this.mobile,
    this.desktop,
    this.tablet,
    this.watch,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    super.key,
  });
  final Widget Function(BuildContext context, BoxConstraints contraints) mobile;
  final Widget Function(BuildContext context, BoxConstraints contraints)?
      tablet;
  final Widget Function(BuildContext context, BoxConstraints contraints)?
      desktop;
  final Widget Function(BuildContext context, BoxConstraints contraints)? watch;
  final Breakpoints breakpoints;

  @override
  State<ScreenSizeLayoutBuilder> createState() =>
      _ScreenSizeLayoutBuilderState();
}

class _ScreenSizeLayoutBuilderState extends State<ScreenSizeLayoutBuilder> {
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
        )(context, constraints);
      },
    );
  }
}
