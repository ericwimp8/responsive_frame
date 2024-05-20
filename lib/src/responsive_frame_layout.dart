import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// {@template responsive_frame_layout}
/// {@tool snippet}
/// This example shows how to use the [ResponsiveFrameLayout], using [FrameConfig] to create a responsive layout with a consistent frame structure.
///
/// ```dart
/// ResponsiveFrameLayout(
///   small: (context) => FrameConfig(
///     body: const Text('Small layout'),
///   ),
///   medium: (context) => FrameConfig(
///     leftEnd: const Text('Medium layout left end'),
///     body: const Text('Medium layout body'),
///   ),
///   large: (context) => FrameConfig(
///     top: const Text('Large layout top'),
///     leftEnd: const Text('Large layout left end'),
///     body: const Text('Large layout body'),
///   ),
///   extraLarge: (context) => FrameConfig(
///     top: const Text('Extra large layout top'),
///     leftEnd: const Text('Extra large layout left end'),
///     rightEnd: const Text('Extra large layout right end'),
///     body: const Text('Extra large layout body'),
///   ),
/// )
/// ```
/// {@end-tool}
/// {@endtemplate}

/// A widget that makes it easy to create responsive layouts with a consistent frame structure.
///
/// {@macro responsive_frame_layout}
///
/// The [small], [medium], [large], and [extraLarge] properties define the [FrameConfig]
/// to use for each layout size. The [FrameConfig] object defines the widgets to
/// render in each of the frame's slots.
///
/// The [animations] property can be used to disable animations when the layout changes.
/// The [persistentFrameConfig] property can be used to define a [FrameConfig] that
/// will be merged with the [FrameConfig] for the current layout size. This is useful
/// for defining widgets that should be rendered in the same slot for all layout sizes.
class ResponsiveFrameLayout extends StatelessWidget {
  /// Creates a new [ResponsiveFrameLayout] widget.
  ///
  /// The [small], [medium], [large], and [extraLarge] properties define the [FrameConfig]
  /// to use for each layout size. The [FrameConfig] object defines the widgets to
  /// render in each of the frame's slots.
  ///
  /// The [animations] property can be used to disable animations when the layout changes.
  /// The [persistentFrameConfig] property can be used to define a [FrameConfig] that
  /// will be merged with the [FrameConfig] for the current layout size. This is useful
  /// for defining widgets that should be rendered in the same slot for all layout sizes.
  const ResponsiveFrameLayout({
    this.small,
    super.key,
    this.extraLarge,
    this.large,
    this.medium,
    this.extraSmall,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.animations = true,
    this.persistentFrameConfig = FrameConfig.empty,
    this.backgroundColor,
  }) : assert(
          small != null ||
              extraLarge != null ||
              large != null ||
              medium != null ||
              extraSmall != null,
          'At least one size parameter must be provided.',
        );

  /// The [FrameConfig] to use when the screen size is extra large.
  final FrameConfig Function(BuildContext context)? extraLarge;

  /// The [FrameConfig] to use when the screen size is large.
  final FrameConfig Function(BuildContext context)? large;

  /// The [FrameConfig] to use when the screen size is medium.
  final FrameConfig Function(BuildContext context)? medium;

  /// The [FrameConfig] to use when the screen size is small.
  final FrameConfig Function(BuildContext context)? small;

  /// The [FrameConfig] to use when the screen size is extra small.
  final FrameConfig Function(BuildContext context)? extraSmall;

  /// The breakpoints to use for each layout size.
  final Breakpoints breakpoints;

  /// Whether to animate changes to the layout.
  final bool animations;

  /// A [FrameConfig] that will be merged with the [FrameConfig] for the current layout size.
  final FrameConfig persistentFrameConfig;

  /// The background color of the frame.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BreakpointsData(
      handlers: {
        'frameconfig': BreakpointsHandler<FrameConfig Function(BuildContext)>(
          breakpoints: breakpoints,
          extraLarge: extraLarge,
          large: large,
          medium: medium,
          small: small,
          extraSmall: extraSmall,
        ),
      },
      child: _Frame(
        persistentFrameConfig: persistentFrameConfig,
        backgroundColor: backgroundColor,
        animations: animations,
      ),
    );
  }
}

class _Frame extends StatefulWidget {
  const _Frame({
    required this.persistentFrameConfig,
    required this.animations,
    this.backgroundColor,
  });
  final Color? backgroundColor;
  final FrameConfig persistentFrameConfig;
  final bool animations;
  @override
  State<_Frame> createState() => _FrameState();
}

class _FrameState extends State<_Frame> {
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
        LayoutSize>(
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
