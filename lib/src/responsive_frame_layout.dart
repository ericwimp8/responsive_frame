import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveFrameLayout extends StatelessWidget {
  const ResponsiveFrameLayout({
    required this.small,
    this.extraLarge,
    this.large,
    this.medium,
    this.extraSmall,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.animations = true,
    this.persistentFrameConfig = FrameConfig.empty,
    this.backgroundColor,
    super.key,
  }) : assert(
          small != null ||
              extraLarge != null ||
              large != null ||
              medium != null ||
              extraSmall != null,
          'At least one size parameter must be provided.',
        );

  final FrameConfig Function(BuildContext context)? extraLarge;
  final FrameConfig Function(BuildContext context)? large;
  final FrameConfig Function(BuildContext context)? medium;
  final FrameConfig Function(BuildContext context)? small;
  final FrameConfig Function(BuildContext context)? extraSmall;
  final Breakpoints breakpoints;
  final bool animations;
  final FrameConfig persistentFrameConfig;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BreakpointData(
      initialHandlers: {
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
