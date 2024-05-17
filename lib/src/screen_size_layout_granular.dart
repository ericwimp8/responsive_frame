import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides a responsive layout based on the screen size
/// and provides granular control over the layout for different screen sizes.
///
/// This widget allows you to define different widgets for different
/// screen sizes. The `BreakpointsGranular` class provides a way to define
/// different breakpoints for different screen sizes. You can use this widget
/// to create a layout that is optimized for different screen sizes.
///
/// ##Example
///
/// ```dart
/// ScreenSizeLayoutGranular(
///   jumboExtraLarge: (context) => const Text('Jumbo Extra Large'),
///   standardLarge: (context) => const Text('Standard Large'),
///   standardNormal: (context) => const Text('Standard Normal'),
///   compactNormal: (context) => const Text('Compact Normal'),
/// )
/// ```
class ScreenSizeLayoutGranular extends StatefulWidget {
  /// Creates a new `ScreenSizeLayoutGranular` widget.
  ///
  /// The `breakpoints` parameter specifies the breakpoints for different
  /// screen sizes.
  ///
  /// The `jumboExtraLarge`, `jumboLarge`, `jumboNormal`, `jumboSmall`,
  /// `standardExtraLarge`, `standardLarge`, `standardNormal`,
  /// `standardSmall`, `compactExtraLarge`, `compactLarge`,
  /// `compactNormal`, `compactSmall` and `tiny` parameters specify the
  /// widget for different screen sizes.
  ///
  /// The `useShortestSide` parameter specifies whether to use the shortest
  /// side of the screen as the basis for determining the screen size.
  ///
  /// The `useLocalSizeConstraints` parameter specifies whether to use the
  /// local size constraints of the widget as the basis for determining the
  /// screen size.
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

  /// The widget for jumbo extra large screens.
  final Widget Function(BuildContext context)? jumboExtraLarge;

  /// The widget for jumbo large screens.
  final Widget Function(BuildContext context)? jumboLarge;

  /// The widget for jumbo normal screens.
  final Widget Function(BuildContext context)? jumboNormal;

  /// The widget for jumbo small screens.
  final Widget Function(BuildContext context)? jumboSmall;

  /// The widget for standard extra large screens.
  final Widget Function(BuildContext context)? standardExtraLarge;

  /// The widget for standard large screens.
  final Widget Function(BuildContext context)? standardLarge;

  /// The widget for standard normal screens.
  final Widget Function(BuildContext context)? standardNormal;

  /// The widget for standard small screens.
  final Widget Function(BuildContext context)? standardSmall;

  /// The widget for compact extra large screens.
  final Widget Function(BuildContext context)? compactExtraLarge;

  /// The widget for compact large screens.
  final Widget Function(BuildContext context)? compactLarge;

  /// The widget for compact normal screens.
  final Widget Function(BuildContext context)? compactNormal;

  /// The widget for compact small screens.
  final Widget Function(BuildContext context)? compactSmall;

  /// The widget for tiny screens.
  final Widget Function(BuildContext context)? tiny;

  /// The breakpoints for different screen sizes.
  final BreakpointsGranular breakpoints;

  /// Whether to use the shortest side of the screen as the basis for
  /// determining the screen size.
  final bool useShortestSide;

  /// Whether to use the local size constraints of the widget as the basis for
  /// determining the screen size.
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
