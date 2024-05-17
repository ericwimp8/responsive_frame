import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides a responsive layout based on the screen size.
///
/// This widget allows you to define different frame configurations for different
/// screen sizes. The `Breakpoints` class provides a way to define different
/// breakpoints for different screen sizes. You can use this widget to
/// create a layout that is optimized for different screen sizes.
///
/// ##Example
///
/// ResponsiveFrameLayout(
///   breakpoints: Breakpoints.defaultBreakpoints,
///   large: (context) => FrameConfig(
///     body: Container(color: Colors.red),
///     top: Text('Top Widget'),
///   ),
///   medium: (context) => FrameConfig(
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
class ResponsiveFrameLayout extends StatelessWidget {
  /// Creates a new `ResponsiveFrameLayout` widget.
  ///
  /// The `breakpoints` parameter specifies the breakpoints for different
  /// screen sizes.
  ///
  /// The `animations` parameter specifies whether to animate
  /// the layout transitions.
  ///
  /// The `extraLarge`, `large`, `medium`, `small`, and `extraSmall` parameters
  /// specify the frame configuration for different screen sizes.
  ///
  /// The `persistentFrameConfig` parameter specifies a frame configuration
  /// that is applied to all screen sizes.
  ///
  /// The `backgroundColor` parameter specifies the background color of the
  /// frame.
  const ResponsiveFrameLayout({
    required this.small,
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

  /// The frame configuration for extra large screens.
  final FrameConfig Function(BuildContext context)? extraLarge;

  /// The frame configuration for large screens.
  final FrameConfig Function(BuildContext context)? large;

  /// The frame configuration for medium screens.
  final FrameConfig Function(BuildContext context)? medium;

  /// The frame configuration for small screens.
  final FrameConfig Function(BuildContext context)? small;

  /// The frame configuration for extra small screens.
  final FrameConfig Function(BuildContext context)? extraSmall;

  /// The breakpoints for different screen sizes.
  final Breakpoints breakpoints;

  /// Whether to animate the layout transitions.
  final bool animations;

  /// The frame configuration that is applied to all screen sizes.
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
