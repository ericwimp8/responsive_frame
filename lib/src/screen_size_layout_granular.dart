import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Widget with builders to return layout widgets based on
/// device width
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

  @override
  State<ScreenSizeLayoutGranular> createState() =>
      _ScreenSizeLayoutGranularState();
}

class _ScreenSizeLayoutGranularState extends State<ScreenSizeLayoutGranular> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return LayoutBuilder(
    //   builder: (BuildContext context, BoxConstraints constraints) {
    //     return controller.breakpointCallback(context);
    //   },
    // );
  }
}
