import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/break_points_granular.dart';

/// Widget with builders to return layout widgets based on
/// device width
class ScreenSizeLayoutGranular extends StatefulWidget {
  const ScreenSizeLayoutGranular({
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
    super.key,
    this.mobileExtraLarge,
    this.mobileLarge,
    required this.mobileNormal,
    this.mobileSmall,
    this.tabletExtraLarge,
    this.tabletLarge,
    this.tabletNormal,
    this.tabletSmall,
    this.desktopExtraLarge,
    this.desktopLarge,
    this.desktopNormal,
    this.desktopSmall,
    this.watch,
  });
  final Widget Function(BuildContext context)? desktopExtraLarge;
  final Widget Function(BuildContext context)? desktopLarge;
  final Widget Function(BuildContext context)? desktopNormal;
  final Widget Function(BuildContext context)? desktopSmall;
  final Widget Function(BuildContext context)? tabletExtraLarge;
  final Widget Function(BuildContext context)? tabletLarge;
  final Widget Function(BuildContext context)? tabletNormal;
  final Widget Function(BuildContext context)? tabletSmall;
  final Widget Function(BuildContext context)? mobileExtraLarge;
  final Widget Function(BuildContext context)? mobileLarge;
  final Widget Function(BuildContext context) mobileNormal;
  final Widget Function(BuildContext context)? mobileSmall;
  final Widget Function(BuildContext context)? watch;

  final BreakpointsGranular breakpoints;

  @override
  State<ScreenSizeLayoutGranular> createState() =>
      _ScreenSizeLayoutGranularState();
}

class _ScreenSizeLayoutGranularState extends State<ScreenSizeLayoutGranular> {
  /// Map to map [ScreenSizeGranular] to its relevant builder
  late final _availableBuilders = {
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
  };

  /// Stores the current [ScreenSizeGranular] checked in findBuilder
  /// for a guard clause so logic is only run when there is actually
  /// a change
  ScreenSizeGranular? _screenSize;
  Widget Function(BuildContext)? _builder;

  void findBuilder(ScreenSizeGranular screenSize) {
    if (_screenSize == screenSize) return;
    _screenSize = screenSize;
    final builder = _availableBuilders[screenSize];
    if (builder != null) {
      _builder = builder;
      return;
    }
    final index = ScreenSizeGranular.values.indexOf(screenSize);
    final validBuilders = ScreenSizeGranular.values.sublist(index);
    for (var e in validBuilders) {
      final builder = _availableBuilders[e];
      if (builder != null) {
        _builder = builder;
        return;
      }
    }
    throw 'builder not found';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final deviceWidth = MediaQuery.sizeOf(context).width;

        final screensize =
            widget.breakpoints.screenSize(deviceWidth: deviceWidth);
        findBuilder(screensize);
        return _builder!.call(context);
      },
    );
  }
}
