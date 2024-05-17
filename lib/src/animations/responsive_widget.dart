import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that displays a child widget based on the screen size.
///
/// The [ResponsiveWidget] widget displays its child widget only when the screen
/// size matches one of the specified size parameters. You can control which
/// screen sizes trigger the display of the child widget using the
/// `extraLarge`, `large`, `medium`, `small`, and `extraSmall` properties.
///
/// You can optionally provide a custom [breakpoints] object to define the
/// breakpoints for each layout size. The `useShortestSide` property can be used
/// to determine the layout size based on the shortest side of the screen
/// instead of the width.
///
/// The widget provides basic animation capabilities using the `animate`,
/// `duration`, `curve`, `axis`, `axisAlignment`, and `transitionBuilder`
/// properties.
///
/// {@tool snippet}
/// This example shows how to use the [ResponsiveWidget] widget to display a
/// child widget only when the screen size is large or extra large.
///
/// ```dart
/// ResponsiveWidget(
///   extraLarge: true,
///   large: true,
///   child: const Text('This text is only visible on large or extra large screens.'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ResponsiveWidgetGranular]
///  * [Breakpoints]
class ResponsiveWidget extends StatelessWidget {
  /// Creates a new [ResponsiveWidget] widget.
  ///
  /// The [child] property is the widget to be displayed. The `extraLarge`,
  /// `large`, `medium`, `small`, and `extraSmall` properties determine which
  /// screen sizes trigger the display of the child widget. You can optionally
  /// provide a custom [breakpoints] object to define the breakpoints for each
  /// layout size. The `useShortestSide` property can be used to determine the
  /// layout size based on the shortest side of the screen instead of the width.
  /// The `animate`, `duration`, `curve`, `axis`, `axisAlignment`, and
  /// `transitionBuilder` properties control the animation of the child widget.
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
          extraLarge || large || medium || small || extraSmall,
          'At least one of the size parameters must be true',
        );

  /// The widget to be displayed.
  final Widget child;

  /// Whether to display the child widget on extra large screens.
  final bool extraLarge;

  /// Whether to display the child widget on large screens.
  final bool large;

  /// Whether to display the child widget on medium screens.
  final bool medium;

  /// Whether to display the child widget on small screens.
  final bool small;

  /// Whether to display the child widget on extra small screens.
  final bool extraSmall;

  /// A custom [Breakpoints] object to define the breakpoints for each layout
  /// size.
  final Breakpoints? breakpoints;

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
