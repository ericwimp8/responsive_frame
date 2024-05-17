import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

/// A widget that renders different layouts based on the screen size.
///
/// {@tool snippet}
/// This example shows how to use the [ScreenSizeLayout] widget to render different layouts based on the screen size.
///
/// ```dart
/// ScreenSizeLayout(
///   breakpoints: const Breakpoints(
///     extraLarge: 1400,
///     large: 1100,
///     medium: 800,
///     small: 500,
///   ),
///   extraLarge: (context) => const Text('Extra large layout'),
///   large: (context) => const Text('Large layout'),
///   medium: (context) => const Text('Medium layout'),
///   small: (context) => const Text('Small layout'),
///   extraSmall: (context) => const Text('Extra small layout'),
/// )
/// ```
/// {@end-tool}
///
/// The [breakpoints] property defines the breakpoints for each layout size.
/// The [extraLarge], [large], [medium], [small], and [extraSmall] properties
/// define the widgets to render for each layout size.
///
/// The [useLocalSizeConstraints] property can be used to determine the layout size
/// based on the size of the parent widget. This is useful when the widget is being
/// rendered inside a container that is not the full screen size.
///
/// The [useShortestSide] property can be used to determine the layout size based
/// on the shortest side of the screen. This is useful for layouts that are
/// designed to be responsive to both portrait and landscape orientations.
class ScreenSizeLayout extends StatefulWidget {
  /// Creates a new [ScreenSizeLayout] widget.
  ///
  /// The [breakpoints] property defines the breakpoints for each layout size.
  /// The [extraLarge], [large], [medium], [small], and [extraSmall] properties
  /// define the widgets to render for each layout size.
  ///
  /// The [useLocalSizeConstraints] property can be used to determine the layout size
  /// based on the size of the parent widget. This is useful when the widget is being
  /// rendered inside a container that is not the full screen size.
  ///
  /// The [useShortestSide] property can be used to determine the layout size based
  /// on the shortest side of the screen. This is useful for layouts that are
  /// designed to be responsive to both portrait and landscape orientations.
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

  /// The widget to render when the screen size is extra large.
  final Widget Function(BuildContext context)? extraLarge;

  /// The widget to render when the screen size is large.
  final Widget Function(BuildContext context)? large;

  /// The widget to render when the screen size is medium.
  final Widget Function(BuildContext context)? medium;

  /// The widget to render when the screen size is small.
  final Widget Function(BuildContext context)? small;

  /// The widget to render when the screen size is extra small.
  final Widget Function(BuildContext context)? extraSmall;

  /// Whether to use the local size constraints to determine the layout size.
  final bool useLocalSizeConstraints;

  /// Whether to use the shortest side of the screen to determine the layout size.
  final bool useShortestSide;

  /// The breakpoints to use for each layout size.
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
