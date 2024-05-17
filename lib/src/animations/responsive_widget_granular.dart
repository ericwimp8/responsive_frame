import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that shows its child based on the current screen size.
///
/// The `ResponsiveWidgetGranular` takes a [child] widget and a set of boolean values
/// that represent whether the child should be shown at different screen sizes.
/// The [breakpoints] parameter allows you to specify custom [BreakpointsGranular].
/// The [useShortestSide] parameter allows you to use the shortest side.
/// The [transitionBuilder] allows you to specify a custom transition.
/// The [animate] parameter allows you to turn off animations.
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
/// In this example, the `Text` widget will be shown on jumboExtraLarge, jumboLarge,
/// jumboNormal and jumboSmall screens sizes only.
class ResponsiveWidgetGranular extends StatelessWidget {
  /// A widget that shows its child based on the current screen size.
  ResponsiveWidgetGranular({
    required this.child,
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
    this.useShortestSide = false,
    super.key,
    this.jumboExtraLarge = false,
    this.jumboLarge = false,
    this.jumboNormal = false,
    this.jumboSmall = false,
    this.standardExtraLarge = false,
    this.standardLarge = false,
    this.standardNormal = false,
    this.standardSmall = false,
    this.compactExtraLarge = false,
    this.compactLarge = false,
    this.compactNormal = false,
    this.compactSmall = false,
    this.tiny = false,
    this.transitionBuilder,
    this.axis = Axis.horizontal,
    this.axisAlignment = -1,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 180),
    this.animate = true,
  }) : assert(
          jumboExtraLarge ||
              jumboLarge ||
              jumboNormal ||
              jumboSmall ||
              standardExtraLarge ||
              standardLarge ||
              standardNormal ||
              standardSmall ||
              compactExtraLarge ||
              compactLarge ||
              compactNormal ||
              compactSmall ||
              tiny,
          'At least one of the size params must be true',
        );

  /// The widget to be shown based on the current screen size.
  final Widget child;

  /// Custom breakpoints to specify different screen sizes.
  ///
  /// Defaults to [BreakpointsGranular.defaultBreakpoints].
  final BreakpointsGranular breakpoints;

  /// Whether the child should be shown on jumboExtraLarge screens.
  ///
  /// Defaults to `false`.
  final bool jumboExtraLarge;

  /// Whether the child should be shown on jumboLarge screens.
  ///
  /// Defaults to `false`.
  final bool jumboLarge;

  /// Whether the child should be shown on jumboNormal screens.
  ///
  /// Defaults to `false`.
  final bool jumboNormal;

  /// Whether the child should be shown on jumboSmall screens.
  ///
  /// Defaults to `false`.
  final bool jumboSmall;

  /// Whether the child should be shown on standardExtraLarge screens.
  ///
  /// Defaults to `false`.
  final bool standardExtraLarge;

  /// Whether the child should be shown on standardLarge screens.
  ///
  /// Defaults to `false`.
  final bool standardLarge;

  /// Whether the child should be shown on standardNormal screens.
  ///
  /// Defaults to `false`.
  final bool standardNormal;

  /// Whether the child should be shown on standardSmall screens.
  ///
  /// Defaults to `false`.
  final bool standardSmall;

  /// Whether the child should be shown on compactExtraLarge screens.
  ///
  /// Defaults to `false`.
  final bool compactExtraLarge;

  /// Whether the child should be shown on compactLarge screens.
  ///
  /// Defaults to `false`.
  final bool compactLarge;

  /// Whether the child should be shown on compactNormal screens.
  ///
  /// Defaults to `false`.
  final bool compactNormal;

  /// Whether the child should be shown on compactSmall screens.
  ///
  /// Defaults to `false`.
  final bool compactSmall;

  /// Whether the child should be shown on tiny screens.
  ///
  /// Defaults to `false`.
  final bool tiny;

  /// Whether to use the shortest side of the screen for calculations.
  ///
  /// Defaults to `false`.
  final bool useShortestSide;

  /// The axis along which the child will be aligned.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis axis;

  /// The alignment of the child along the specified axis.
  ///
  /// Defaults to `-1.0`.
  final double axisAlignment;

  /// The animation curve for showing/hiding the child.
  ///
  /// Defaults to [Curves.ease].
  final Curve curve;

  /// The duration of the animation for showing/hiding the child.
  ///
  /// Defaults to `Duration(milliseconds: 180)`.
  final Duration duration;

  /// Whether to animate the showing/hiding of the child.
  ///
  /// Defaults to `true`.
  final bool animate;

  /// A custom transition builder for animations.
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  )? transitionBuilder;

  late final BreakpointsHandlerGranular<bool> handler =
      BreakpointsHandlerGranular<bool>(
    breakpoints: breakpoints,
    jumboExtraLarge: jumboExtraLarge,
    jumboLarge: jumboLarge,
    jumboNormal: jumboNormal,
    jumboSmall: jumboSmall,
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
      transitionBuilder: transitionBuilder,
      axis: axis,
      curve: curve,
      axisAlignment: axisAlignment,
      child: showChild ? child : null,
    );
  }
}
