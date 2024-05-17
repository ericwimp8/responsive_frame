import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides a responsive layout based on the screen size and
/// provides granular control over the layout for different screen sizes.
///
/// This widget allows you to define different frame configurations for different
/// screen sizes. The `BreakpointsGranular` class provides a way to define
/// different breakpoints for different screen sizes. You can use this widget
/// to create a layout that is optimized for different screen sizes.
///
/// ## Example
/// ```dart
/// ResponsiveFrameLayoutGranular(
///   breakpoints: BreakpointsGranular.defaultBreakpoints,
///   jumboExtraLarge: (context) => FrameConfig(
///     body: Container(color: Colors.red),
///     top: Text('Top Widget'),
///   ),
///   jumboLarge: (context) => FrameConfig(
///     body: Container(color: Colors.blue),
///     bottom: Text('Bottom Widget'),
///   ),
///   // Add configurations for other screen sizes as needed
///   persistentFrameConfig: FrameConfig(
///     bottom: Container(color: Colors.green),
///     rightEnd: Text('Right End Widget'),
///   ),
///   backgroundColor: Colors.white,
/// )
/// ```
class ResponsiveFrameLayoutGranular extends StatelessWidget {
  /// Creates a new `ResponsiveFrameLayoutGranular` widget.
  ///
  /// The `breakpoints` parameter specifies the breakpoints for different
  /// screen sizes. The `animations` parameter specifies whether to animate
  /// the layout transitions.
  ///
  /// The `jumboExtraLarge`, `jumboLarge`, `jumboNormal`, `jumboSmall`,
  /// `standardExtraLarge`, `standardLarge`, `standardNormal`,
  /// `standardSmall`, `compactExtraLarge`, `compactLarge`,
  /// `compactNormal`, `compactSmall` and `tiny` parameters specify the
  /// frame configuration for different screen sizes.
  ///
  /// The `persistentFrameConfig` parameter specifies a frame configuration
  /// that is applied to all screen sizes.
  ///
  /// The `backgroundColor` parameter specifies the background color of the
  /// frame.
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

  /// The breakpoints for different screen sizes.
  final BreakpointsGranular breakpoints;

  /// Whether to animate the layout transitions.
  final bool animations;

  /// The frame configuration for jumbo extra large screens.
  final FrameConfig Function(BuildContext context)? jumboExtraLarge;

  /// The frame configuration for jumbo large screens.
  final FrameConfig Function(BuildContext context)? jumboLarge;

  /// The frame configuration for jumbo normal screens.
  final FrameConfig Function(BuildContext context)? jumboNormal;

  /// The frame configuration for jumbo small screens.
  final FrameConfig Function(BuildContext context)? jumboSmall;

  /// The frame configuration for standard extra large screens.
  final FrameConfig Function(BuildContext context)? standardExtraLarge;

  /// The frame configuration for standard large screens.
  final FrameConfig Function(BuildContext context)? standardLarge;

  /// The frame configuration for standard normal screens.
  final FrameConfig Function(BuildContext context)? standardNormal;

  /// The frame configuration for standard small screens.
  final FrameConfig Function(BuildContext context)? standardSmall;

  /// The frame configuration for compact extra large screens.
  final FrameConfig Function(BuildContext context)? compactExtraLarge;

  /// The frame configuration for compact large screens.
  final FrameConfig Function(BuildContext context)? compactLarge;

  /// The frame configuration for compact normal screens.
  final FrameConfig Function(BuildContext context)? compactNormal;

  /// The frame configuration for compact small screens.
  final FrameConfig Function(BuildContext context)? compactSmall;

  /// The frame configuration for tiny screens.
  final FrameConfig Function(BuildContext context)? tiny;

  /// The frame configuration that is applied to all screen sizes.
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
