import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that displays a child widget based on the screen size and granular
/// size categories.
///
/// The [ResponsiveWidgetGranular] widget displays its child widget only when
/// the screen size matches one of the specified size parameters, taking into
/// account granular size categories for more precise layout adjustments. You can
/// control which screen sizes trigger the display of the child widget using the
/// `jumboExtraLarge`, `jumboLarge`, `jumboNormal`, `jumboSmall`,
/// `standardExtraLarge`, `standardLarge`, `standardNormal`, `standardSmall`,
/// `compactExtraLarge`, `compactLarge`, `compactNormal`, `compactSmall`, and
/// `tiny` properties.
///
/// You can optionally provide a custom [breakpoints] object to define the
/// breakpoints for each layout size category. The `useShortestSide` property
/// can be used to determine the layout size based on the shortest side of the
/// screen instead of the width.
///
/// The widget provides basic animation capabilities using the `animate`,
/// `duration`, `curve`, `axis`, `axisAlignment`, and `transitionBuilder`
/// properties.
///
/// {@tool snippet}
/// This example shows how to use the [ResponsiveWidgetGranular] widget to
/// display a child widget only when the screen size is in the "standard"
/// category and is large or extra large.
///
/// ```dart
/// ResponsiveWidgetGranular(
///   standardLarge: true,
///   standardExtraLarge: true,
///   child: const Text('This text is only visible on standard large or extra large screens.'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ResponsiveWidget]
///  * [BreakpointsGranular]
class ResponsiveWidgetGranular extends StatelessWidget {
  /// Creates a new [ResponsiveWidgetGranular] widget.
  ///
  /// The [child] property is the widget to be displayed. The `jumboExtraLarge`,
  /// `jumboLarge`, `jumboNormal`, `jumboSmall`, `standardExtraLarge`,
  /// `standardLarge`, `standardNormal`, `standardSmall`, `compactExtraLarge`,
  /// `compactLarge`, `compactNormal`, `compactSmall`, and `tiny` properties
  /// determine which screen sizes trigger the display of the child widget. You
  /// can optionally provide a custom [breakpoints] object to define the
  /// breakpoints for each layout size category. The `useShortestSide` property
  /// can be used to determine the layout size based on the shortest side of
  /// the screen instead of the width. The `animate`, `duration`, `curve`,
  /// `axis`, `axisAlignment`, and `transitionBuilder` properties control the
  /// animation of the child widget.
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

  /// The widget to be displayed.
  final Widget child;

  /// The [BreakpointsGranular] object to define the breakpoints for each
  /// layout size category.
  final BreakpointsGranular breakpoints;

  /// Whether to display the child widget on jumbo extra large screens.
  final bool jumboExtraLarge;

  /// Whether to display the child widget on jumbo large screens.
  final bool jumboLarge;

  /// Whether to display the child widget on jumbo normal screens.
  final bool jumboNormal;

  /// Whether to display the child widget on jumbo small screens.
  final bool jumboSmall;

  /// Whether to display the child widget on standard extra large screens.
  final bool standardExtraLarge;

  /// Whether to display the child widget on standard large screens.
  final bool standardLarge;

  /// Whether to display the child widget on standard normal screens.
  final bool standardNormal;

  /// Whether to display the child widget on standard small screens.
  final bool standardSmall;

  /// Whether to display the child widget on compact extra large screens.
  final bool compactExtraLarge;

  /// Whether to display the child widget on compact large screens.
  final bool compactLarge;

  /// Whether to display the child widget on compact normal screens.
  final bool compactNormal;

  /// Whether to display the child widget on compact small screens.
  final bool compactSmall;

  /// Whether to display the child widget on tiny screens.
  final bool tiny;

  /// Whether to use the shortest side of the screen to determine the layout
  /// size.
  final bool useShortestSide;

  /// The axis of the animation.
  final Axis axis;

  /// The axis alignment of the animation.
  final double axisAlignment;

  /// The curve of the animation.
  final Curve curve;

  /// The duration of the animation.
  final Duration duration;

  /// Whether to animate the child widget.
  final bool animate;

  /// A custom animation transition builder.
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
