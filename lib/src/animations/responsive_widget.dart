import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveWidget extends StatelessWidget {
  ResponsiveWidget({
    required this.child,
    this.extraLarge = false,
    this.large = false,
    this.medium = false,
    this.small = false,
    this.extraSmall = false,
    this.breakpoints,
    this.useShortestSide = false,
    this.transiationBuilder,
    this.axis = Axis.horizontal,
    this.axisAlignment = -1,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 180),
    this.animate = true,
    super.key,
  }) : assert(
            extraLarge != null ||
                large != null ||
                medium != null ||
                small != null ||
                extraSmall != null,
            'At least one of extralarge, large, medium, small or extraSmall '
            'has to be provided');
  final Widget child;
  final Breakpoints? breakpoints;
  final bool? extraLarge;
  final bool? large;
  final bool? medium;
  final bool? small;
  final bool? extraSmall;
  final bool useShortestSide;
  final Axis axis;
  final double axisAlignment;
  final Curve curve;
  final Duration duration;
  final bool animate;
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  )? transiationBuilder;

  late final BreakpointsHandler<bool> handler = BreakpointsHandler<bool>(
    breakpoints: breakpoints ?? Breakpoints.defaultBreakpoints,
    extraLarge: extraLarge,
    large: large,
    medium: medium,
    small: small,
    extraSmall: extraSmall,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = useShortestSide ? size.shortestSide : size.width;
    final showChild = handler.getLayoutSizeValue(width);

    return AnimatedShowHide(
      animate: animate,
      duration: duration,
      transitionBuilder: transiationBuilder,
      axis: axis,
      curve: curve,
      axisAlignment: axisAlignment,
      child: showChild ? child : null,
    );
  }
}
