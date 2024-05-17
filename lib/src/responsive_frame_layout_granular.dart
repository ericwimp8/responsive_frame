import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that makes it easy to create responsive layouts with a consistent frame structure.
///
/// {@tool snippet}
/// This example shows how to use the [ResponsiveFrameLayoutGranular] widget to create a responsive layout with a consistent frame structure.
///
/// ```dart
/// ResponsiveFrameLayoutGranular(
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
///   jumboExtraLarge: (context) => FrameConfig(
///     body: const Text('Jumbo extra large layout'),
///   ),
///   jumboLarge: (context) => FrameConfig(
///     body: const Text('Jumbo large layout'),
///   ),
///   jumboNormal: (context) => FrameConfig(
///     body: const Text('Jumbo normal layout'),
///   ),
///   jumboSmall: (context) => FrameConfig(
///     body: const Text('Jumbo small layout'),
///   ),
///   standardExtraLarge: (context) => FrameConfig(
///     body: const Text('Standard extra large layout'),
///   ),
///   standardLarge: (context) => FrameConfig(
///     leftEnd: const Text('Standard large layout left end'),
///     body: const Text('Standard large layout body'),
///   ),
///   standardNormal: (context) => FrameConfig(
///     top: const Text('Standard normal layout top'),
///     leftEnd: const Text('Standard normal layout left end'),
///     body: const Text('Standard normal layout body'),
///   ),
///   standardSmall: (context) => FrameConfig(
///     top: const Text('Standard small layout top'),
///     leftEnd: const Text('Standard small layout left end'),
///     rightEnd: const Text('Standard small layout right end'),
///     body: const Text('Standard small layout body'),
///   ),
///   compactExtraLarge: (context) => FrameConfig(
///     body: const Text('Compact extra large layout'),
///   ),
///   compactLarge: (context) => FrameConfig(
///     body: const Text('Compact large layout'),
///   ),
///   compactNormal: (context) => FrameConfig(
///     body: const Text('Compact normal layout'),
///   ),
///   compactSmall: (context) => FrameConfig(
///     body: const Text('Compact small layout'),
///   ),
///   tiny: (context) => FrameConfig(
///     body: const Text('Tiny layout'),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// The [jumboExtraLarge], [jumboLarge], [jumboNormal], [jumboSmall],
/// [standardExtraLarge], [standardLarge], [standardNormal], [standardSmall],
/// [compactExtraLarge], [compactLarge], [compactNormal], [compactSmall], and
/// [tiny] properties define the [FrameConfig] to use for each layout size.
/// The [FrameConfig] object defines the widgets to render in each of the
/// frame's slots.
///
/// The [animations] property can be used to disable animations when the layout changes.
/// The [persistentFrameConfig] property can be used to define a [FrameConfig] that
/// will be merged with the [FrameConfig] for the current layout size. This is useful
/// for defining widgets that should be rendered in the same slot for all layout sizes.
class ResponsiveFrameLayoutGranular extends StatelessWidget {
  /// Creates a new [ResponsiveFrameLayoutGranular] widget.
  ///
  /// The [jumboExtraLarge], [jumboLarge], [jumboNormal], [jumboSmall],
  /// [standardExtraLarge], [standardLarge], [standardNormal], [standardSmall],
  /// [compactExtraLarge], [compactLarge], [compactNormal], [compactSmall], and
  /// [tiny] properties define the [FrameConfig] to use for each layout size.
  /// The [FrameConfig] object defines the widgets to render in each of the
  /// frame's slots.
  ///
  /// The [animations] property can be used to disable animations when the layout changes.
  /// The [persistentFrameConfig] property can be used to define a [FrameConfig] that
  /// will be merged with the [FrameConfig] for the current layout size. This is useful
  /// for defining widgets that should be rendered in the same slot for all layout sizes.
  const ResponsiveFrameLayoutGranular({
    super.key,
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
    this.animations = true,
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
    this.persistentFrameConfig = FrameConfig.empty,
    this.tiny,
    this.backgroundColor,
  }) : assert(
          jumboExtraLarge != null ||
              jumboLarge != null ||
              jumboNormal != null ||
              jumboSmall != null ||
              standardExtraLarge != null ||
              standardLarge != null ||
              standardNormal != null ||
              standardSmall != null ||
              compactExtraLarge != null ||
              compactLarge != null ||
              compactNormal != null ||
              compactSmall != null ||
              tiny != null,
          'At least one size parameter must be provided.',
        );

  /// The breakpoints to use for each layout size.
  final BreakpointsGranular breakpoints;

  /// Whether to animate changes to the layout.
  final bool animations;

  /// The [FrameConfig] to use when the screen size is jumbo extra large.
  final FrameConfig Function(BuildContext context)? jumboExtraLarge;

  /// The [FrameConfig] to use when the screen size is jumbo large.
  final FrameConfig Function(BuildContext context)? jumboLarge;

  /// The [FrameConfig] to use when the screen size is jumbo normal.
  final FrameConfig Function(BuildContext context)? jumboNormal;

  /// The [FrameConfig] to use when the screen size is jumbo small.
  final FrameConfig Function(BuildContext context)? jumboSmall;

  /// The [FrameConfig] to use when the screen size is standard extra large.
  final FrameConfig Function(BuildContext context)? standardExtraLarge;

  /// The [FrameConfig] to use when the screen size is standard large.
  final FrameConfig Function(BuildContext context)? standardLarge;

  /// The [FrameConfig] to use when the screen size is standard normal.
  final FrameConfig Function(BuildContext context)? standardNormal;

  /// The [FrameConfig] to use when the screen size is standard small.
  final FrameConfig Function(BuildContext context)? standardSmall;

  /// The [FrameConfig] to use when the screen size is compact extra large.
  final FrameConfig Function(BuildContext context)? compactExtraLarge;

  /// The [FrameConfig] to use when the screen size is compact large.
  final FrameConfig Function(BuildContext context)? compactLarge;

  /// The [FrameConfig] to use when the screen size is compact normal.
  final FrameConfig Function(BuildContext context)? compactNormal;

  /// The [FrameConfig] to use when the screen size is compact small.
  final FrameConfig Function(BuildContext context)? compactSmall;

  /// The [FrameConfig] to use when the screen size is tiny.
  final FrameConfig Function(BuildContext context)? tiny;

  /// A [FrameConfig] that will be merged with the [FrameConfig] for the current layout size.
  final FrameConfig persistentFrameConfig;

  /// The background color of the frame.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BreakpointsDataGranular(
      handlers: {
        'frameconfig': BreakpointsHandlerGranular<
            FrameConfig Function(
              BuildContext,
            )>(
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
        ),
      },
      child: _FrameWrapper(
        persistentFrameConfig: persistentFrameConfig,
        backgroundColor: backgroundColor,
        animations: animations,
      ),
    );
  }
}

class _FrameWrapper extends StatefulWidget {
  const _FrameWrapper({
    required this.persistentFrameConfig,
    required this.animations,
    this.backgroundColor,
  });
  final Color? backgroundColor;
  final FrameConfig persistentFrameConfig;
  final bool animations;
  @override
  State<_FrameWrapper> createState() => _FrameWrapperState();
}

class _FrameWrapperState extends State<_FrameWrapper> {
  bool _isInit = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setInitStatus();
    });
    super.initState();
  }

  void setInitStatus() {
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final handler = ResponsiveData.handlerOf<FrameConfig Function(BuildContext),
        LayoutSizeGranular>(
      context,
      'frameconfig',
      MediaQuery.sizeOf(context).width,
    );
    final config = handler.call(context).merge(widget.persistentFrameConfig);

    return Material(
      color: widget.backgroundColor,
      child: SafeArea(
        child: Frame(
          dimensions: config.dimensions,
          animations: !_isInit && widget.animations,
          body: config.body ?? const SizedBox(),
          top: config.top,
          bodyTop: config.bodyTop,
          leftEnd: config.leftEnd,
          leftEndTop: config.leftEndTop,
          rightEnd: config.rightEnd,
          rightEndTop: config.rightEndTop,
          bodyBottom: config.bodyBottom,
          bottom: config.bottom,
        ),
      ),
    );
  }
}
