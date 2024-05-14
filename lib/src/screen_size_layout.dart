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
  State<ScreenSizeLayoutBuilder> createState() =>
      _ScreenSizeLayoutBuilderState();
}

class _ScreenSizeLayoutBuilderState extends State<ScreenSizeLayoutBuilder> {
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
