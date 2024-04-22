import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveFrameLayoutGranular extends StatefulWidget {
  const ResponsiveFrameLayoutGranular({
    required this.mobileNormal,
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
    this.animations = true,
    super.key,
    this.desktopExtraLarge,
    this.desktopLarge,
    this.desktopNormal,
    this.desktopSmall,
    this.tabletExtraLarge,
    this.tabletLarge,
    this.tabletNormal,
    this.tabletSmall,
    this.mobileExtraLarge,
    this.mobileLarge,
    this.mobileSmall,
    this.persistentConfig = FrameConfig.empty,
    this.watch,
  });
  final FrameConfig Function(BuildContext context) mobileNormal;
  final FrameConfig Function(BuildContext context)? desktopExtraLarge;
  final FrameConfig Function(BuildContext context)? desktopLarge;
  final FrameConfig Function(BuildContext context)? desktopNormal;
  final FrameConfig Function(BuildContext context)? desktopSmall;
  final FrameConfig Function(BuildContext context)? tabletExtraLarge;
  final FrameConfig Function(BuildContext context)? tabletLarge;
  final FrameConfig Function(BuildContext context)? tabletNormal;
  final FrameConfig Function(BuildContext context)? tabletSmall;
  final FrameConfig Function(BuildContext context)? mobileExtraLarge;
  final FrameConfig Function(BuildContext context)? mobileLarge;
  final FrameConfig Function(BuildContext context)? mobileSmall;
  final FrameConfig Function(BuildContext context)? watch;
  final BreakpointsGranular breakpoints;
  final bool animations;
  final FrameConfig persistentConfig;

  @override
  State<ResponsiveFrameLayoutGranular> createState() =>
      _ResponsiveFrameLayoutState();
}

class _ResponsiveFrameLayoutState extends State<ResponsiveFrameLayoutGranular> {
  late final controller =
      BreakpointsController<FrameConfig, ScreenSizeGranular>(
    callbacks: {
      ScreenSizeGranular.desktopExtraLarge: widget.desktopExtraLarge,
      ScreenSizeGranular.desktopLarge: widget.desktopLarge,
      ScreenSizeGranular.desktopNormal: widget.desktopNormal,
      ScreenSizeGranular.desktopSmall: widget.desktopSmall,
      ScreenSizeGranular.tabletExtraLarge: widget.tabletExtraLarge,
      ScreenSizeGranular.tabletLarge: widget.tabletLarge,
      ScreenSizeGranular.tabletNormal: widget.tabletNormal,
      ScreenSizeGranular.tabletSmall: widget.tabletSmall,
      ScreenSizeGranular.mobileExtraLarge: widget.mobileExtraLarge,
      ScreenSizeGranular.mobileLarge: widget.mobileLarge,
      ScreenSizeGranular.mobileNormal: widget.mobileNormal,
      ScreenSizeGranular.mobileSmall: widget.mobileSmall,
      ScreenSizeGranular.watch: widget.watch,
    },
    defaultValue: ScreenSizeGranular.mobileNormal,
    breakpoints: BreakpointsGranular.defaultBreakpoints,
  );

  bool _isInit = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setInitStatus(false);
    });
    super.initState();
  }

  void setInitStatus(bool isInit) {
    _isInit = isInit;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final config = controller
            .breakpointCallback(context)
            .merge(widget.persistentConfig);
        return Frame(
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
        );
      },
    );
  }
}
