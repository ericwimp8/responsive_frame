import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that shows its child based on the current screen size.
///
/// The `ResponsiveWidget` takes a [child] widget and a set of boolean values
/// that represent whether the child should be shown at different screen sizes.
/// The [breakpoints] parameter allows you to specify custom breakpoints.
///
/// Example:
///
/// ```dart
/// ResponsiveWidget(
///   child: Text('Hello, world!'),
///   extraLarge: true,
///   large: true,
///   medium: false,
///   small: false,
///   extraSmall: false,
/// )
/// ```
///
/// In this example, the `Text` widget will be shown on extra large and large
/// screens, but not on medium, small, or extra small screens.
class ResponsiveWidget extends StatelessWidget {
  /// A widget that shows its child based on the current screen size.
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

  /// The widget to be shown based on the current screen size.
  final Widget child;

  /// Whether the child should be shown on extra large screens.
  ///
  /// Defaults to `false`.
  final bool extraLarge;

  /// Whether the child should be shown on large screens.
  ///
  /// Defaults to `false`.
  final bool large;

  /// Whether the child should be shown on medium screens.
  ///
  /// Defaults to `false`.
  final bool medium;

  /// Whether the child should be shown on small screens.
  ///
  /// Defaults to `false`.
  final bool small;

  /// Whether the child should be shown on extra small screens.
  ///
  /// Defaults to `false`.
  final bool extraSmall;

  /// Custom breakpoints to specify different screen sizes.
  final Breakpoints? breakpoints;

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
  /// Defaults to `-1`.
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

  /// A function that defines the transition of the child widget.
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
