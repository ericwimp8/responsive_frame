import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveFrameLayoutGranular extends StatelessWidget {
  const ResponsiveFrameLayoutGranular({
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
    this.animations = true,
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

  final FrameConfig Function(BuildContext context)? jumboExtraLarge;
  final FrameConfig Function(BuildContext context)? jumboLarge;
  final FrameConfig Function(BuildContext context)? jumboSmall;
  final FrameConfig Function(BuildContext context)? jumboNormal;
  final FrameConfig Function(BuildContext context)? standardExtraLarge;
  final FrameConfig Function(BuildContext context)? standardLarge;
  final FrameConfig Function(BuildContext context)? standardNormal;
  final FrameConfig Function(BuildContext context)? standardSmall;
  final FrameConfig Function(BuildContext context)? compactExtraLarge;
  final FrameConfig Function(BuildContext context)? compactLarge;
  final FrameConfig Function(BuildContext context)? compactNormal;
  final FrameConfig Function(BuildContext context)? compactSmall;
  final FrameConfig Function(BuildContext context)? tiny;
  final BreakpointsGranular breakpoints;
  final bool animations;
  final FrameConfig persistentFrameConfig;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BreakpointDataGranular(
      initialHandlers: {
        'frameconfig':
            BreakpointsHandlerGranular<FrameConfig Function(BuildContext)>(
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
