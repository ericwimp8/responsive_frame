import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ScreenSizeLayoutGranular extends StatefulWidget {
  const ScreenSizeLayoutGranular({
    super.key,
    this.jumboExtraLarge,
    this.jumboLarge,
    this.jumboNormal,
    this.jumboSmall,
    this.standardExtraLarge,
    this.standardLarge,
    this.standardNormal,
    this.standardSmall,
    this.compactExtraLarge,
    this.compactLarge,
    this.compactNormal,
    this.compactSmall,
    this.tiny,
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
    this.useShortestSide = false,
    this.useLocalSizeConstraints = false,
  });
  final Widget Function(BuildContext context)? jumboExtraLarge;
  final Widget Function(BuildContext context)? jumboLarge;
  final Widget Function(BuildContext context)? jumboNormal;
  final Widget Function(BuildContext context)? jumboSmall;
  final Widget Function(BuildContext context)? standardExtraLarge;
  final Widget Function(BuildContext context)? standardLarge;
  final Widget Function(BuildContext context)? standardNormal;
  final Widget Function(BuildContext context)? standardSmall;
  final Widget Function(BuildContext context)? compactExtraLarge;
  final Widget Function(BuildContext context)? compactLarge;
  final Widget Function(BuildContext context)? compactNormal;
  final Widget Function(BuildContext context)? compactSmall;
  final Widget Function(BuildContext context)? tiny;
  final BreakpointsGranular breakpoints;
  final bool useShortestSide;
  final bool useLocalSizeConstraints;

  @override
  State<ScreenSizeLayoutGranular> createState() =>
      _ScreenSizeLayoutGranularState();
}

class _ScreenSizeLayoutGranularState extends State<ScreenSizeLayoutGranular> {
  late final handler = BreakpointsHandlerGranular(
    breakpoints: widget.breakpoints,
    jumboExtraLarge: widget.jumboExtraLarge,
    jumboLarge: widget.jumboLarge,
    jumboNormal: widget.jumboNormal,
    jumboSmall: widget.jumboSmall,
    standardExtraLarge: widget.standardExtraLarge,
    standardLarge: widget.standardLarge,
    standardNormal: widget.standardNormal,
    standardSmall: widget.standardSmall,
    compactExtraLarge: widget.compactExtraLarge,
    compactLarge: widget.compactLarge,
    compactNormal: widget.compactNormal,
    compactSmall: widget.compactSmall,
    tiny: widget.tiny,
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
