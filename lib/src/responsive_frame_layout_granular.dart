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
  final BreakpointsGranular breakpoints;
  final bool animations;
  @override
  State<ResponsiveFrameLayoutGranular> createState() =>
      _ResponsiveFrameLayoutState();
}

class _ResponsiveFrameLayoutState extends State<ResponsiveFrameLayoutGranular> {
  late final controller = BreakpointsGranularController<FrameConfig>(
    desktopExtraLarge: widget.desktopExtraLarge,
    desktopLarge: widget.desktopLarge,
    desktopNormal: widget.desktopNormal,
    desktopSmall: widget.desktopSmall,
    tabletExtraLarge: widget.tabletExtraLarge,
    tabletLarge: widget.tabletLarge,
    tabletNormal: widget.tabletNormal,
    tabletSmall: widget.tabletSmall,
    mobileExtraLarge: widget.mobileExtraLarge,
    mobileLarge: widget.mobileLarge,
    mobileNormal: widget.mobileNormal,
    mobileSmall: widget.mobileSmall,
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
        final deviceWidth = constraints.maxWidth;
        final config = controller.breakpointCallback(
          deviceWidth: deviceWidth,
          context: context,
        );
        return Frame(
          animations: !_isInit && widget.animations,
          body: config.body,
          top: config.top,
          topHeight: config.topHeight,
          bodyTop: config.bodyTop,
          bodyTopHeight: config.bodyTopHeight,
          bodyAlignment: config.bodyAlignment,
          bodyMaxWidth: config.bodyMaxWidth,
          bodyMinWidth: config.bodyMinWidth,
          leftEnd: config.leftEnd,
          leftEndTop: config.leftEndTop,
          leftEndMaxWidth: config.leftEndMaxWidth,
          leftEndMinWidth: config.leftEndMinWidth,
          leftEndFillVertical: config.leftEndFillVertical,
          leftEndTopHeight: config.leftEndTopHeight,
          rightEnd: config.rightEnd,
          rightEndTop: config.rightEndTop,
          rightEndMaxWidth: config.rightEndMaxWidth,
          rightEndMinWidth: config.rightEndMinWidth,
          rightEndFillVertical: config.rightEndFillVertical,
          rightEndTopHeight: config.rightEndTopHeight,
          bodyBottom: config.bodyBottom,
          bodyBottomHeight: config.bodyBottomHeight,
          bottom: config.bottom,
          bottomHeight: config.bottomHeight,
        );
      },
    );
  }
}
