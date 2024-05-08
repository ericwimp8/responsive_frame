import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that shows its child based on the current screen size.
///
/// The `ResponsiveWidgetGranular` takes a [child] widget and a set of boolean values
/// that represent whether the child should be shown at different screen sizes.
/// The [breakpoints] parameter allows you to specify custom [BreakpointsGranular].
///
/// Example:
///
/// ```dart
/// ResponsiveWidgetGranular(
///   child: Text('Hello, world!'),
///   jumboExtraLarge: true,
///   jumboLarge: true,
///   jumboNormal: true,
///   jumboSmall: true,
/// )
/// ```
///
/// In this example, the `Text` widget will be shown on jumbo extra large, jumbo large,
/// jumbo normal and jumbo small screens sizes only.
class ResponsiveWidgetGranular extends StatelessWidget {
  ResponsiveWidgetGranular({
    required this.child,
    this.breakpoints,
    this.useShortestSide = false,
    super.key,
    this.jumboExtraLarge,
    this.jumpoLarge,
    this.jumpboNormal,
    this.jumpboSmall,
    this.standardExtraLarge,
    this.standardLarge,
    this.standardNormal,
    this.standardSmall,
    this.compactExtraLarge,
    this.compactLarge,
    this.compactNormal,
    this.compactSmall,
    this.tiny,
    this.transiationBuilder,
    this.axis = Axis.horizontal,
    this.axisAlignment = -1,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 180),
    this.animate = true,
  }) : assert(
            jumboExtraLarge != null ||
                jumpoLarge != null ||
                jumpboNormal != null ||
                jumpboSmall != null ||
                standardExtraLarge != null ||
                standardLarge != null ||
                standardNormal != null ||
                standardSmall != null ||
                compactExtraLarge != null ||
                compactLarge != null ||
                compactNormal != null ||
                compactSmall != null ||
                tiny != null,
            'At least one of jumboExtraLarge, jumpoLarge, jumpboNormal, jumpboSmall, '
            'standardExtraLarge, standardLarge, standardNormal, standardSmall, compactExtraLarge, '
            'compactLarge, compactNormal, compactSmall or tiny '
            'has to be provided');
  final Widget child;
  final BreakpointsGranular? breakpoints;
  final bool? jumboExtraLarge;
  final bool? jumpoLarge;
  final bool? jumpboNormal;
  final bool? jumpboSmall;
  final bool? standardExtraLarge;
  final bool? standardLarge;
  final bool? standardNormal;
  final bool? standardSmall;
  final bool? compactExtraLarge;
  final bool? compactLarge;
  final bool? compactNormal;
  final bool? compactSmall;
  final bool useShortestSide;
  final bool? tiny;
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

  late final BreakpointsHandlerGranular<bool> handler =
      BreakpointsHandlerGranular<bool>(
    breakpoints: breakpoints ?? BreakpointsGranular.defaultBreakpoints,
    jumboExtraLarge: jumboExtraLarge,
    jumboLarge: jumpoLarge,
    jumboNormal: jumpboNormal,
    jumboSmall: jumpboSmall,
    standardExtraLarge: standardExtraLarge,
    standardLarge: standardLarge,
    standardNormal: standardNormal,
    standardSmall: standardSmall,
    compactExtraLarge: compactExtraLarge,
    compactLarge: compactLarge,
    compactNormal: compactNormal,
    compactSmall: compactSmall,
    tiny: tiny,
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
