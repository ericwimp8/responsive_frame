import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that renders different layouts based on the screen size.
///
/// {@tool snippet}
/// This example shows how to use the [ScreenSizeLayoutGranular] widget to render different layouts based on the screen size.
///
/// ```dart
/// ScreenSizeLayoutGranular(
///   breakpoints: const BreakpointsGranular(
///     jumboExtraLarge: 4096,
///     jumboLarge: 3840,
///     jumboNormal: 2560,
///     jumboSmall: 1920,
///     standardExtraLarge: 1280,
///     standardLarge: 1024,
///     standardNormal: 768,
///     standardSmall: 568,
///     compactExtraLarge: 480,
///     compactLarge: 430,
///     compactNormal: 360,
///     compactSmall: 300,
///   ),
///   jumboExtraLarge: (context) => const Text('Jumbo extra large layout'),
///   jumboLarge: (context) => const Text('Jumbo large layout'),
///   jumboNormal: (context) => const Text('Jumbo normal layout'),
///   jumboSmall: (context) => const Text('Jumbo small layout'),
///   standardExtraLarge: (context) => const Text('Standard extra large layout'),
///   standardLarge: (context) => const Text('Standard large layout'),
///   standardNormal: (context) => const Text('Standard normal layout'),
///   standardSmall: (context) => const Text('Standard small layout'),
///   compactExtraLarge: (context) => const Text('Compact extra large layout'),
///   compactLarge: (context) => const Text('Compact large layout'),
///   compactNormal: (context) => const Text('Compact normal layout'),
///   compactSmall: (context) => const Text('Compact small layout'),
///   tiny: (context) => const Text('Tiny layout'),
/// )
/// ```
/// {@end-tool}
///
/// The [breakpoints] property defines the breakpoints for each layout size.
/// The [jumboExtraLarge], [jumboLarge], [jumboNormal], [jumboSmall],
/// [standardExtraLarge], [standardLarge], [standardNormal], [standardSmall],
/// [compactExtraLarge], [compactLarge], [compactNormal], [compactSmall], and
/// [tiny] properties define the widgets to render for each layout size.
///
/// The [useLocalSizeConstraints] property can be used to determine the layout size
/// based on the size of the parent widget. This is useful when the widget is being
/// rendered inside a container that is not the full screen size.
///
/// The [useShortestSide] property can be used to determine the layout size based
/// on the shortest side of the screen. This is useful for layouts that are
/// designed to be responsive to both portrait and landscape orientations.
class ScreenSizeLayoutGranular extends StatefulWidget {
  /// Creates a new [ScreenSizeLayoutGranular] widget.
  ///
  /// The [breakpoints] property defines the breakpoints for each layout size.
  /// The [jumboExtraLarge], [jumboLarge], [jumboNormal], [jumboSmall],
  /// [standardExtraLarge], [standardLarge], [standardNormal], [standardSmall],
  /// [compactExtraLarge], [compactLarge], [compactNormal], [compactSmall], and
  /// [tiny] properties define the widgets to render for each layout size.
  ///
  /// The [useLocalSizeConstraints] property can be used to determine the layout size
  /// based on the size of the parent widget. This is useful when the widget is being
  /// rendered inside a container that is not the full screen size.
  ///
  /// The [useShortestSide] property can be used to determine the layout size based
  /// on the shortest side of the screen. This is useful for layouts that are
  /// designed to be responsive to both portrait and landscape orientations.
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

  /// The widget to render when the screen size is jumbo extra large.
  final Widget Function(BuildContext context)? jumboExtraLarge;

  /// The widget to render when the screen size is jumbo large.
  final Widget Function(BuildContext context)? jumboLarge;

  /// The widget to render when the screen size is jumbo normal.
  final Widget Function(BuildContext context)? jumboNormal;

  /// The widget to render when the screen size is jumbo small.
  final Widget Function(BuildContext context)? jumboSmall;

  /// The widget to render when the screen size is standard extra large.
  final Widget Function(BuildContext context)? standardExtraLarge;

  /// The widget to render when the screen size is standard large.
  final Widget Function(BuildContext context)? standardLarge;

  /// The widget to render when the screen size is standard normal.
  final Widget Function(BuildContext context)? standardNormal;

  /// The widget to render when the screen size is standard small.
  final Widget Function(BuildContext context)? standardSmall;

  /// The widget to render when the screen size is compact extra large.
  final Widget Function(BuildContext context)? compactExtraLarge;

  /// The widget to render when the screen size is compact large.
  final Widget Function(BuildContext context)? compactLarge;

  /// The widget to render when the screen size is compact normal.
  final Widget Function(BuildContext context)? compactNormal;

  /// The widget to render when the screen size is compact small.
  final Widget Function(BuildContext context)? compactSmall;

  /// The widget to render when the screen size is tiny.
  final Widget Function(BuildContext context)? tiny;

  /// The breakpoints to use for each layout size.
  final BreakpointsGranular breakpoints;

  /// Whether to use the shortest side of the screen to determine the layout size.
  final bool useShortestSide;

  /// Whether to use the local size constraints to determine the layout size.
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
