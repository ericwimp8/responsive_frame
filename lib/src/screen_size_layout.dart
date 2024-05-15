import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ScreenSizeLayout extends StatefulWidget {
  const ScreenSizeLayout({
    this.extraLarge,
    this.large,
    this.medium,
    this.small,
    this.extraSmall,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.useLocalSizeConstraints = false,
    this.useShortestSide = false,
    super.key,
  });
  final Widget Function(BuildContext context)? extraLarge;
  final Widget Function(BuildContext context)? large;
  final Widget Function(BuildContext context)? medium;
  final Widget Function(BuildContext context)? small;
  final Widget Function(BuildContext context)? extraSmall;
  final bool useLocalSizeConstraints;
  final bool useShortestSide;
  final Breakpoints breakpoints;

  @override
  State<ScreenSizeLayout> createState() => _ScreenSizeLayoutState();
}

class _ScreenSizeLayoutState extends State<ScreenSizeLayout> {
  late final handler = BreakpointsHandler(
    breakpoints: widget.breakpoints,
    extraLarge: widget.extraLarge,
    large: widget.large,
    medium: widget.medium,
    small: widget.small,
    extraSmall: widget.extraSmall,
  );

  double _width(Size size) {
    if (widget.useShortestSide) {
      return size.height < size.width ? size.height : size.width;
    }
    return size.width;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useLocalSizeConstraints) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return handler.getLayoutSizeValue(
            _width(Size(constraints.maxWidth, constraints.maxHeight)),
          )(
            context,
          );
        },
      );
    }
    return handler.getLayoutSizeValue(
      _width(MediaQuery.sizeOf(context)),
    )(context);
  }
}
