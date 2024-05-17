// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScreenSizeLayout extends StatefulWidget {
  const ScreenSizeLayout({
    this.extraLarge,
    this.large,
    this.medium,
    this.small,
    this.extraSmall,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.useLocalSizeConstraints = false,
    this.useShortestSide = false,
    super.key,
  });
  final Widget Function(BuildContext context)? extraLarge;
  final Widget Function(BuildContext context)? large;
  final Widget Function(BuildContext context)? medium;
  final Widget Function(BuildContext context)? small;
  final Widget Function(BuildContext context)? extraSmall;
  final bool useLocalSizeConstraints;
  final bool useShortestSide;
  final Breakpoints breakpoints;

  @override
  State<ScreenSizeLayout> createState() => _ScreenSizeLayoutState();
}

class _ScreenSizeLayoutState extends State<ScreenSizeLayout> {
  late final handler = BreakpointsHandler(
    breakpoints: widget.breakpoints,
    extraLarge: widget.extraLarge,
    large: widget.large,
    medium: widget.medium,
    small: widget.small,
    extraSmall: widget.extraSmall,
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

class ScreenSizeLayoutGranular extends StatefulWidget {
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

  final Widget Function(BuildContext context)? jumboExtraLarge;

  final Widget Function(BuildContext context)? jumboLarge;

  final Widget Function(BuildContext context)? jumboNormal;

  final Widget Function(BuildContext context)? jumboSmall;

  final Widget Function(BuildContext context)? standardExtraLarge;

  final Widget Function(BuildContext context)? standardLarge;

  final Widget Function(BuildContext context)? standardNormal;

  final Widget Function(BuildContext context)? standardSmall;

  final Widget Function(BuildContext context)? compactExtraLarge;

  final Widget Function(BuildContext context)? compactLarge;

  final Widget Function(BuildContext context)? compactNormal;

  final Widget Function(BuildContext context)? compactSmall;

  final Widget Function(BuildContext context)? tiny;

  final BreakpointsGranular breakpoints;

  final bool useShortestSide;

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

class ResponsiveFrameLayout extends StatelessWidget {
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

class ResponsiveFrameLayoutGranular extends StatelessWidget {
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

  final BreakpointsGranular breakpoints;

  final bool animations;

  final FrameConfig Function(BuildContext context)? jumboExtraLarge;

  final FrameConfig Function(BuildContext context)? jumboLarge;

  final FrameConfig Function(BuildContext context)? jumboNormal;

  final FrameConfig Function(BuildContext context)? jumboSmall;

  final FrameConfig Function(BuildContext context)? standardExtraLarge;

  final FrameConfig Function(BuildContext context)? standardLarge;

  final FrameConfig Function(BuildContext context)? standardNormal;

  final FrameConfig Function(BuildContext context)? standardSmall;

  final FrameConfig Function(BuildContext context)? compactExtraLarge;

  final FrameConfig Function(BuildContext context)? compactLarge;

  final FrameConfig Function(BuildContext context)? compactNormal;

  final FrameConfig Function(BuildContext context)? compactSmall;

  final FrameConfig Function(BuildContext context)? tiny;

  final FrameConfig persistentFrameConfig;

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

class ResponsiveData<K extends Enum>
    extends InheritedNotifier<ResponsiveDataChangeNotifier<K>> {
  const ResponsiveData({
    required ResponsiveDataChangeNotifier<K> super.notifier,
    required super.child,
    super.key,
  });

  static ResponsiveDataChangeNotifier<K> of<K extends Enum>(
    BuildContext context,
  ) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ResponsiveData<K>>();

    assert(
      result != null,
      'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
    );

    return result!.notifier!;
  }

  static T handlerOf<T extends Object, K extends Enum>(
    BuildContext context,
    String key,
    double size,
  ) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ResponsiveData<K>>();

    assert(
      result != null,
      'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
    );

    return result!.notifier!.getHandler<T>(key).getLayoutSizeValue(size);
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNotifier<ResponsiveDataChangeNotifier> oldWidget,
  ) {
    return true;
  }
}

class ResponsiveDataChangeNotifier<K extends Enum> extends ChangeNotifier
    with WidgetsBindingObserver {
  ResponsiveDataChangeNotifier({
    required this.breakpoints,
    bool useShortestSide = false,
    Map<String, BaseBreakpointsHandler<Object?, K>> handlers = const {},
    // testView is only used for testing
    this.testView,
  })  : _handlers = handlers,
        _useShortestSide = useShortestSide {
    updateMetrics();
  }
  final FlutterView? testView;
  final BaseBreakpoints<K> breakpoints;
  K? screenSize;
  double? currentBreakpoint;
  final Map<String, BaseBreakpointsHandler<Object?, K>> _handlers;
  bool _useShortestSide;
  Map<String, BaseBreakpointsHandler<Object?, K>> get handlers => _handlers;
  bool get useShortestSide => _useShortestSide;

  void setUseShortestSide({required bool value}) {
    _useShortestSide = value;
    updateMetrics();
    notifyListeners();
  }

  @override
  void didChangeMetrics() {
    updateMetrics();
  }

  BaseBreakpointsHandler<T, K> getHandler<T extends Object>(String key) {
    final hasHandler = _handlers.containsKey(key);
    if (!hasHandler) {
      assert(
        hasHandler,
        'No handler found for key: $key. '
        'Check that the key is correct or that the handler is added to the controller.',
      );
    }
    return _handlers[key]! as BaseBreakpointsHandler<T, K>;
  }

  void updateMetrics() {
    // Get the current view or the first platform view if testView is null
    final view =
        testView ?? WidgetsBinding.instance.platformDispatcher.views.first;

    final physicalWidth = view.physicalSize.width;
    final physicalHeight = view.physicalSize.height;
    final devicePixelRatio = view.devicePixelRatio;

    // Calculate the screen width and height in logical pixels
    final screenWidth = physicalWidth / devicePixelRatio;
    final screenHeight = physicalHeight / devicePixelRatio;

    late double width;

    // Determine the width based on the shortest side if _useShortestSide is true
    if (_useShortestSide) {
      width = screenWidth < screenHeight
          ? width = screenWidth
          : width = screenHeight;
    } else {
      width = screenWidth;
    }

    // Get the screen size based on the calculated width
    final screensize = _getScreenSize(width);

    // Update screenSize and currentBreakpoint if screen size has changed
    if (screensize != this.screenSize) {
      this.screenSize = screensize;
      currentBreakpoint = breakpoints.values[screenSize];
      notifyListeners();
    }
  }

  K _getScreenSize(double size) {
    final entries = breakpoints.values.entries;
    for (final entry in entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }

    return entries.last.key;
  }

  @override
  String toString() {
    return 'ResponsiveDataChangeNotifier(useShortestSide: $useShortestSide, screenSize: $screenSize, currentBreakpoint: $currentBreakpoint)';
  }
}

class Frame extends StatelessWidget {
  const Frame({
    required this.body,
    this.dimensions = DimensionsConfig.empty,
    this.backgroundColor,
    this.animations = true,
    this.top,
    this.bodyTop,
    this.leftEnd,
    this.leftEndTop,
    this.rightEnd,
    this.rightEndTop,
    this.bodyBottom,
    this.bottom,
    super.key,
  });

  final bool animations;

  final Widget body;

  final Widget? top;

  final Widget? bodyTop;

  final Widget? leftEnd;

  final Widget? leftEndTop;

  final Widget? rightEnd;

  final Widget? rightEndTop;

  final Widget? bodyBottom;

  final Widget? bottom;

  final DimensionsConfig? dimensions;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedShowHide(
          animate: animations,
          child: top != null
              ? FrameVerticalEnd(
                  maxHeight: dimensions?.topMaxHeight,
                  minHeight: dimensions?.topMinHeight,
                  child: top!,
                )
              : null,
        ),
        Expanded(
          child: Row(
            children: [
              AnimatedShowHide(
                axis: Axis.horizontal,
                animate: animations,
                child: leftEnd != null &&
                        (dimensions?.leftEndFillVertical ??
                            kDefaultFillVertical)
                    ? FrameHorizontalEnd(
                        maxWidth: dimensions?.leftEndMaxWidth,
                        minWidth: dimensions?.leftEndMinWidth,
                        topMaxHeight: dimensions?.leftEndTopMaxHeight,
                        topMinHeight: dimensions?.leftEndTopMinHeight,
                        top: leftEndTop != null &&
                                (dimensions?.leftEndFillVertical ??
                                    kDefaultFillVertical)
                            ? leftEndTop!
                            : null,
                        child: leftEnd!,
                      )
                    : null,
              ),
              Expanded(
                child: Column(
                  children: [
                    AnimatedShowHide(
                      animate: animations,
                      child: bodyTop != null
                          ? FrameVerticalEnd(
                              maxHeight: dimensions?.bodyTopMaxHeight,
                              minHeight: dimensions?.bodyTopMinHeight,
                              child: bodyTop!,
                            )
                          : null,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          AnimatedShowHide(
                            animate: animations,
                            axis: Axis.horizontal,
                            child: leftEnd != null &&
                                    !(dimensions?.leftEndFillVertical ??
                                        kDefaultFillVertical)
                                ? FrameHorizontalEnd(
                                    top: leftEndTop != null &&
                                            !(dimensions?.leftEndFillVertical ??
                                                kDefaultFillVertical)
                                        ? leftEndTop
                                        : null,
                                    maxWidth: dimensions?.leftEndMaxWidth,
                                    minWidth: dimensions?.leftEndMinWidth,
                                    topMaxHeight:
                                        dimensions?.leftEndTopMaxHeight,
                                    topMinHeight:
                                        dimensions?.leftEndTopMinHeight,
                                    child: leftEnd!,
                                  )
                                : null,
                          ),
                          Flexible(
                            child: Align(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: dimensions?.bodyMaxWidth ??
                                      double.infinity,
                                  minWidth: dimensions?.bodyMinWidth ?? 0.0,
                                ),
                                child: AnimatedShowHide(
                                  axis: Axis.horizontal,
                                  animate: animations,
                                  child: body,
                                ),
                              ),
                            ),
                          ),
                          AnimatedShowHide(
                            animate: animations,
                            axis: Axis.horizontal,
                            child: rightEnd != null &&
                                    !(dimensions?.rightEndFillVertical ??
                                        kDefaultFillVertical)
                                ? FrameHorizontalEnd(
                                    top: rightEndTop != null &&
                                            !(dimensions
                                                    ?.rightEndFillVertical ??
                                                kDefaultFillVertical)
                                        ? rightEndTop
                                        : null,
                                    topMaxHeight:
                                        dimensions?.rightEndTopMaxHeight,
                                    topMinHeight:
                                        dimensions?.rightEndTopMinHeight,
                                    maxWidth: dimensions?.rightEndMaxWidth,
                                    minWidth: dimensions?.rightEndMinWidth,
                                    child: rightEnd!,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                    AnimatedShowHide(
                      animate: animations,
                      child: bodyBottom != null
                          ? FrameVerticalEnd(
                              maxHeight: dimensions?.bodyBottomMaxHeight,
                              minHeight: dimensions?.bodyBottomMinHeight,
                              child: bodyBottom!,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              AnimatedShowHide(
                animate: animations,
                axis: Axis.horizontal,
                child: (dimensions?.rightEndFillVertical ??
                            kDefaultFillVertical) &&
                        rightEnd != null
                    ? FrameHorizontalEnd(
                        top: (dimensions?.rightEndFillVertical ??
                                    kDefaultFillVertical) &&
                                rightEndTop != null
                            ? rightEndTop
                            : null,
                        maxWidth: dimensions?.rightEndMaxWidth,
                        minWidth: dimensions?.rightEndMinWidth,
                        topMaxHeight: dimensions?.rightEndTopMaxHeight,
                        topMinHeight: dimensions?.rightEndTopMinHeight,
                        child: rightEnd!,
                      )
                    : null,
              ),
            ],
          ),
        ),
        AnimatedShowHide(
          animate: animations,
          child: bottom != null
              ? FrameVerticalEnd(
                  maxHeight: dimensions?.bottomMaxHeight,
                  minHeight: dimensions?.bottomMinHeight,
                  child: bottom!,
                )
              : null,
        ),
      ],
    );
  }
}

class FrameVerticalEnd extends StatelessWidget {
  const FrameVerticalEnd({
    required this.child,
    super.key,
    this.maxHeight = kDefaultVerticalMaxHeight,
    this.minHeight = kDefaultVerticalMinHeight,
  });

  final Widget child;

  final double? maxHeight;

  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: maxHeight ?? kDefaultVerticalMaxHeight,
        minHeight: minHeight ?? kDefaultVerticalMinHeight,
      ),
      child: child,
    );
  }
}

class FrameHorizontalEnd extends StatelessWidget {
  const FrameHorizontalEnd({
    required this.child,
    this.top,
    this.maxWidth = kDefaultHorizontalEndWidth,
    this.minWidth = kDefaultHorizontalEndWidth,
    this.topMaxHeight = kDefaultVerticalMaxHeight,
    this.topMinHeight = kDefaultVerticalMinHeight,
    super.key,
  });

  final Widget? top;

  final Widget child;

  final double? maxWidth;

  final double? minWidth;

  final double? topMinHeight;

  final double? topMaxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? kDefaultHorizontalEndWidth,
        minWidth: minWidth ?? kDefaultHorizontalEndWidth,
      ),
      child: Column(
        children: [
          if (top != null)
            AnimatedConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: topMaxHeight ?? kDefaultVerticalMaxHeight,
                minHeight: topMinHeight ?? kDefaultVerticalMinHeight,
              ),
              child: top,
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

@immutable
class FrameConfig {
  const FrameConfig({
    this.body,
    this.top,
    this.bodyTop,
    this.leftEnd,
    this.leftEndTop,
    this.rightEnd,
    this.rightEndTop,
    this.bodyBottom,
    this.bottom,
    this.dimensions = DimensionsConfig.empty,
  });

  final Widget? body;

  final Widget? top;

  final Widget? bodyTop;

  final Widget? leftEnd;

  final Widget? leftEndTop;

  final Widget? rightEnd;

  final Widget? rightEndTop;

  final Widget? bodyBottom;

  final Widget? bottom;

  final DimensionsConfig? dimensions;

  static const empty = FrameConfig();

  FrameConfig merge(FrameConfig other) {
    return FrameConfig(
      body: body ?? other.body,
      top: top ?? other.top,
      bodyTop: bodyTop ?? other.bodyTop,
      leftEnd: leftEnd ?? other.leftEnd,
      leftEndTop: leftEndTop ?? other.leftEndTop,
      rightEnd: rightEnd ?? other.rightEnd,
      rightEndTop: rightEndTop ?? other.rightEndTop,
      bodyBottom: bodyBottom ?? other.bodyBottom,
      bottom: bottom ?? other.bottom,
      dimensions: dimensions?.merge(other.dimensions),
    );
  }

  FrameConfig copyWith({
    Widget? body,
    Widget? top,
    Widget? bodyTop,
    Widget? leftEnd,
    Widget? leftEndTop,
    Widget? rightEnd,
    Widget? rightEndTop,
    Widget? bodyBottom,
    Widget? bottom,
    DimensionsConfig? dimensions,
  }) {
    return FrameConfig(
      body: body ?? this.body,
      top: top ?? this.top,
      bodyTop: bodyTop ?? this.bodyTop,
      leftEnd: leftEnd ?? this.leftEnd,
      leftEndTop: leftEndTop ?? this.leftEndTop,
      rightEnd: rightEnd ?? this.rightEnd,
      rightEndTop: rightEndTop ?? this.rightEndTop,
      bodyBottom: bodyBottom ?? this.bodyBottom,
      bottom: bottom ?? this.bottom,
      dimensions: dimensions ?? this.dimensions,
    );
  }

  @override
  String toString() {
    return 'FrameConfig(body: $body, top: $top, bodyTop: $bodyTop, leftEnd: $leftEnd, leftEndTop: $leftEndTop, rightEnd: $rightEnd, rightEndTop: $rightEndTop, bodyBottom: $bodyBottom, bottom: $bottom, dimensions: $dimensions)';
  }
}

@immutable
class DimensionsConfig {
  const DimensionsConfig({
    this.topMaxHeight,
    this.topMinHeight,
    this.bodyTopMaxHeight,
    this.bodyTopMinHeight,
    this.bodyMaxWidth,
    this.bodyMinWidth,
    this.leftEndMaxWidth,
    this.leftEndMinWidth,
    this.leftEndFillVertical,
    this.leftEndTopMaxHeight,
    this.leftEndTopMinHeight,
    this.rightEndMaxWidth,
    this.rightEndMinWidth,
    this.rightEndFillVertical,
    this.rightEndTopMaxHeight,
    this.rightEndTopMinHeight,
    this.bodyBottomMaxHeight,
    this.bodyBottomMinHeight,
    this.bottomMaxHeight,
    this.bottomMinHeight,
    this.bodyAlignment,
  });

  final double? topMaxHeight;

  final double? topMinHeight;

  final double? bodyTopMaxHeight;

  final double? bodyTopMinHeight;

  final double? bodyMaxWidth;

  final double? bodyMinWidth;

  final double? leftEndMaxWidth;

  final double? leftEndMinWidth;

  final bool? leftEndFillVertical;

  final double? leftEndTopMaxHeight;

  final double? leftEndTopMinHeight;

  final double? rightEndMaxWidth;

  final double? rightEndMinWidth;

  final bool? rightEndFillVertical;

  final double? rightEndTopMaxHeight;

  final double? rightEndTopMinHeight;

  final double? bodyBottomMaxHeight;

  final double? bodyBottomMinHeight;

  final double? bottomMaxHeight;

  final double? bottomMinHeight;

  final Alignment? bodyAlignment;

  static const empty = DimensionsConfig();

  DimensionsConfig merge(DimensionsConfig? config) {
    return DimensionsConfig(
      topMaxHeight: topMaxHeight ?? config?.topMaxHeight,
      topMinHeight: topMinHeight ?? config?.topMinHeight,
      bodyTopMaxHeight: bodyTopMaxHeight ?? config?.bodyTopMaxHeight,
      bodyTopMinHeight: bodyTopMinHeight ?? config?.bodyTopMinHeight,
      bodyMaxWidth: bodyMaxWidth ?? config?.bodyMaxWidth,
      bodyMinWidth: bodyMinWidth ?? config?.bodyMinWidth,
      leftEndMaxWidth: leftEndMaxWidth ?? config?.leftEndMaxWidth,
      leftEndMinWidth: leftEndMinWidth ?? config?.leftEndMinWidth,
      leftEndFillVertical: leftEndFillVertical ?? config?.leftEndFillVertical,
      leftEndTopMaxHeight: leftEndTopMaxHeight ?? config?.leftEndTopMaxHeight,
      leftEndTopMinHeight: leftEndTopMinHeight ?? config?.leftEndTopMinHeight,
      rightEndMaxWidth: rightEndMaxWidth ?? config?.rightEndMaxWidth,
      rightEndMinWidth: rightEndMinWidth ?? config?.rightEndMinWidth,
      rightEndFillVertical:
          rightEndFillVertical ?? config?.rightEndFillVertical,
      rightEndTopMaxHeight:
          rightEndTopMaxHeight ?? config?.rightEndTopMaxHeight,
      rightEndTopMinHeight:
          rightEndTopMinHeight ?? config?.rightEndTopMinHeight,
      bodyBottomMaxHeight: bodyBottomMaxHeight ?? config?.bodyBottomMaxHeight,
      bodyBottomMinHeight: bodyBottomMinHeight ?? config?.bodyBottomMinHeight,
      bottomMaxHeight: bottomMaxHeight ?? config?.bottomMaxHeight,
      bottomMinHeight: bottomMinHeight ?? config?.bottomMinHeight,
      bodyAlignment: bodyAlignment ?? config?.bodyAlignment,
    );
  }

  DimensionsConfig copyWith({
    double? topMaxHeight,
    double? topMinHeight,
    double? bodyTopMaxHeight,
    double? bodyTopMinHeight,
    double? bodyMaxWidth,
    double? bodyMinWidth,
    double? leftEndMaxWidth,
    double? leftEndMinWidth,
    bool? leftEndFillVertical,
    double? leftEndTopMaxHeight,
    double? leftEndTopMinHeight,
    double? rightEndMaxWidth,
    double? rightEndMinWidth,
    bool? rightEndFillVertical,
    double? rightEndTopMaxHeight,
    double? rightEndTopMinHeight,
    double? bodyBottomMaxHeight,
    double? bodyBottomMinHeight,
    double? bottomMaxHeight,
    double? bottomMinHeight,
    Alignment? bodyAlignment,
  }) {
    return DimensionsConfig(
      topMaxHeight: topMaxHeight ?? this.topMaxHeight,
      topMinHeight: topMinHeight ?? this.topMinHeight,
      bodyTopMaxHeight: bodyTopMaxHeight ?? this.bodyTopMaxHeight,
      bodyTopMinHeight: bodyTopMinHeight ?? this.bodyTopMinHeight,
      bodyMaxWidth: bodyMaxWidth ?? this.bodyMaxWidth,
      bodyMinWidth: bodyMinWidth ?? this.bodyMinWidth,
      leftEndMaxWidth: leftEndMaxWidth ?? this.leftEndMaxWidth,
      leftEndMinWidth: leftEndMinWidth ?? this.leftEndMinWidth,
      leftEndFillVertical: leftEndFillVertical ?? this.leftEndFillVertical,
      leftEndTopMaxHeight: leftEndTopMaxHeight ?? this.leftEndTopMaxHeight,
      leftEndTopMinHeight: leftEndTopMinHeight ?? this.leftEndTopMinHeight,
      rightEndMaxWidth: rightEndMaxWidth ?? this.rightEndMaxWidth,
      rightEndMinWidth: rightEndMinWidth ?? this.rightEndMinWidth,
      rightEndFillVertical: rightEndFillVertical ?? this.rightEndFillVertical,
      rightEndTopMaxHeight: rightEndTopMaxHeight ?? this.rightEndTopMaxHeight,
      rightEndTopMinHeight: rightEndTopMinHeight ?? this.rightEndTopMinHeight,
      bodyBottomMaxHeight: bodyBottomMaxHeight ?? this.bodyBottomMaxHeight,
      bodyBottomMinHeight: bodyBottomMinHeight ?? this.bodyBottomMinHeight,
      bottomMaxHeight: bottomMaxHeight ?? this.bottomMaxHeight,
      bottomMinHeight: bottomMinHeight ?? this.bottomMinHeight,
      bodyAlignment: bodyAlignment ?? this.bodyAlignment,
    );
  }

  @override
  String toString() {
    return 'DimensionsConfig(topMaxHeight: $topMaxHeight, topMinHeight: $topMinHeight, bodyTopMaxHeight: $bodyTopMaxHeight, bodyTopMinHeight: $bodyTopMinHeight, bodyMaxWidth: $bodyMaxWidth, bodyMinWidth: $bodyMinWidth, leftEndMaxWidth: $leftEndMaxWidth, leftEndMinWidth: $leftEndMinWidth, leftEndFillVertical: $leftEndFillVertical, leftEndTopMaxHeight: $leftEndTopMaxHeight, leftEndTopMinHeight: $leftEndTopMinHeight, rightEndMaxWidth: $rightEndMaxWidth, rightEndMinWidth: $rightEndMinWidth, rightEndFillVertical: $rightEndFillVertical, rightEndTopMaxHeight: $rightEndTopMaxHeight, rightEndTopMinHeight: $rightEndTopMinHeight, bodyBottomMaxHeight: $bodyBottomMaxHeight, bodyBottomMinHeight: $bodyBottomMinHeight, bottomMaxHeight: $bottomMaxHeight, bottomMinHeight: $bottomMinHeight, bodyAlignment: $bodyAlignment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DimensionsConfig &&
        other.topMaxHeight == topMaxHeight &&
        other.topMinHeight == topMinHeight &&
        other.bodyTopMaxHeight == bodyTopMaxHeight &&
        other.bodyTopMinHeight == bodyTopMinHeight &&
        other.bodyMaxWidth == bodyMaxWidth &&
        other.bodyMinWidth == bodyMinWidth &&
        other.leftEndMaxWidth == leftEndMaxWidth &&
        other.leftEndMinWidth == leftEndMinWidth &&
        other.leftEndFillVertical == leftEndFillVertical &&
        other.leftEndTopMaxHeight == leftEndTopMaxHeight &&
        other.leftEndTopMinHeight == leftEndTopMinHeight &&
        other.rightEndMaxWidth == rightEndMaxWidth &&
        other.rightEndMinWidth == rightEndMinWidth &&
        other.rightEndFillVertical == rightEndFillVertical &&
        other.rightEndTopMaxHeight == rightEndTopMaxHeight &&
        other.rightEndTopMinHeight == rightEndTopMinHeight &&
        other.bodyBottomMaxHeight == bodyBottomMaxHeight &&
        other.bodyBottomMinHeight == bodyBottomMinHeight &&
        other.bottomMaxHeight == bottomMaxHeight &&
        other.bottomMinHeight == bottomMinHeight &&
        other.bodyAlignment == bodyAlignment;
  }

  @override
  int get hashCode {
    return topMaxHeight.hashCode ^
        topMinHeight.hashCode ^
        bodyTopMaxHeight.hashCode ^
        bodyTopMinHeight.hashCode ^
        bodyMaxWidth.hashCode ^
        bodyMinWidth.hashCode ^
        leftEndMaxWidth.hashCode ^
        leftEndMinWidth.hashCode ^
        leftEndFillVertical.hashCode ^
        leftEndTopMaxHeight.hashCode ^
        leftEndTopMinHeight.hashCode ^
        rightEndMaxWidth.hashCode ^
        rightEndMinWidth.hashCode ^
        rightEndFillVertical.hashCode ^
        rightEndTopMaxHeight.hashCode ^
        rightEndTopMinHeight.hashCode ^
        bodyBottomMaxHeight.hashCode ^
        bodyBottomMinHeight.hashCode ^
        bottomMaxHeight.hashCode ^
        bottomMinHeight.hashCode ^
        bodyAlignment.hashCode;
  }
}

abstract class BaseBreakpoints<T extends Enum> {
  const BaseBreakpoints();

  Map<T, double> get values;
}

@immutable
class Breakpoints implements BaseBreakpoints<LayoutSize> {
  const Breakpoints({
    this.extraLarge = 1200.0,
    this.large = 950.0,
    this.medium = 600.0,
    this.small = 300.0,
  }) : assert(
          extraLarge > large && large > medium && medium > small && small >= 0,
          'Breakpoints must be in decending order and larger than or equal to 0.',
        );
  final double extraLarge;
  final double large;
  final double medium;
  final double small;

  static const defaultBreakpoints = Breakpoints();

  @override
  Map<LayoutSize, double> get values => {
        LayoutSize.extraLarge: extraLarge,
        LayoutSize.large: large,
        LayoutSize.medium: medium,
        LayoutSize.small: small,
        LayoutSize.extraSmall: -1,
      };

  @override
  String toString() {
    return 'Breakpoints(extraLarge: $extraLarge, large: $large, medium: $medium, small: $small)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breakpoints &&
        other.extraLarge == extraLarge &&
        other.large == large &&
        other.medium == medium &&
        other.small == small;
  }

  @override
  int get hashCode {
    return extraLarge.hashCode ^
        large.hashCode ^
        medium.hashCode ^
        small.hashCode;
  }

  Breakpoints copyWith({
    double? extraLarge,
    double? large,
    double? medium,
    double? small,
  }) {
    return Breakpoints(
      extraLarge: extraLarge ?? this.extraLarge,
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
    );
  }
}

@immutable
class BreakpointsGranular implements BaseBreakpoints<LayoutSizeGranular> {
  const BreakpointsGranular({
    this.jumboExtraLarge = 4096.0,
    this.jumboLarge = 3840.0,
    this.jumboNormal = 2560.0,
    this.jumboSmall = 1920.0,
    this.standardExtraLarge = 1280.0,
    this.standardLarge = 1024.0,
    this.standardNormal = 768.0,
    this.standardSmall = 568.0,
    this.compactExtraLarge = 480.0,
    this.compactLarge = 430.0,
    this.compactNormal = 360.0,
    this.compactSmall = 300.0,
  }) : assert(
          jumboExtraLarge > jumboLarge &&
              jumboLarge > jumboNormal &&
              jumboNormal > jumboSmall &&
              jumboSmall > standardExtraLarge &&
              standardExtraLarge > standardLarge &&
              standardLarge > standardNormal &&
              standardNormal > standardSmall &&
              standardSmall > compactExtraLarge &&
              compactExtraLarge > compactLarge &&
              compactLarge > compactNormal &&
              compactNormal > compactSmall &&
              compactSmall >= 0,
          'Breakpoints must be in decending order and larger than or equal to 0',
        );
  final double jumboExtraLarge;
  final double jumboLarge;
  final double jumboNormal;
  final double jumboSmall;
  final double standardExtraLarge;
  final double standardLarge;
  final double standardNormal;
  final double standardSmall;
  final double compactExtraLarge;
  final double compactLarge;
  final double compactNormal;
  final double compactSmall;

  static const defaultBreakpoints = BreakpointsGranular();

  @override
  Map<LayoutSizeGranular, double> get values => {
        LayoutSizeGranular.jumboExtraLarge: jumboExtraLarge,
        LayoutSizeGranular.jumboLarge: jumboLarge,
        LayoutSizeGranular.jumboNormal: jumboNormal,
        LayoutSizeGranular.jumboSmall: jumboSmall,
        LayoutSizeGranular.standardExtraLarge: standardExtraLarge,
        LayoutSizeGranular.standardLarge: standardLarge,
        LayoutSizeGranular.standardNormal: standardNormal,
        LayoutSizeGranular.standardSmall: standardSmall,
        LayoutSizeGranular.compactExtraLarge: compactExtraLarge,
        LayoutSizeGranular.compactLarge: compactLarge,
        LayoutSizeGranular.compactNormal: compactNormal,
        LayoutSizeGranular.compactSmall: compactSmall,
        LayoutSizeGranular.tiny: -1,
      };

  BreakpointsGranular copyWith({
    double? jumboExtraLarge,
    double? jumboLarge,
    double? jumboNormal,
    double? jumboSmall,
    double? standardExtraLarge,
    double? standardLarge,
    double? standardNormal,
    double? standardSmall,
    double? compactExtraLarge,
    double? compactLarge,
    double? compactNormal,
    double? compactSmall,
  }) {
    return BreakpointsGranular(
      jumboExtraLarge: jumboExtraLarge ?? this.jumboExtraLarge,
      jumboLarge: jumboLarge ?? this.jumboLarge,
      jumboNormal: jumboNormal ?? this.jumboNormal,
      jumboSmall: jumboSmall ?? this.jumboSmall,
      standardExtraLarge: standardExtraLarge ?? this.standardExtraLarge,
      standardLarge: standardLarge ?? this.standardLarge,
      standardNormal: standardNormal ?? this.standardNormal,
      standardSmall: standardSmall ?? this.standardSmall,
      compactExtraLarge: compactExtraLarge ?? this.compactExtraLarge,
      compactLarge: compactLarge ?? this.compactLarge,
      compactNormal: compactNormal ?? this.compactNormal,
      compactSmall: compactSmall ?? this.compactSmall,
    );
  }

  @override
  String toString() {
    return 'BreakpointsGranular(jumboExtraLarge: $jumboExtraLarge, jumboLarge: $jumboLarge, jumboNormal: $jumboNormal, jumboSmall: $jumboSmall, standardExtraLarge: $standardExtraLarge, standardLarge: $standardLarge, standardNormal: $standardNormal, standardSmall: $standardSmall, compactExtraLarge: $compactExtraLarge, compactLarge: $compactLarge, compactNormal: $compactNormal, compactSmall: $compactSmall)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BreakpointsGranular &&
        other.jumboExtraLarge == jumboExtraLarge &&
        other.jumboLarge == jumboLarge &&
        other.jumboNormal == jumboNormal &&
        other.jumboSmall == jumboSmall &&
        other.standardExtraLarge == standardExtraLarge &&
        other.standardLarge == standardLarge &&
        other.standardNormal == standardNormal &&
        other.standardSmall == standardSmall &&
        other.compactExtraLarge == compactExtraLarge &&
        other.compactLarge == compactLarge &&
        other.compactNormal == compactNormal &&
        other.compactSmall == compactSmall;
  }

  @override
  int get hashCode {
    return jumboExtraLarge.hashCode ^
        jumboLarge.hashCode ^
        jumboNormal.hashCode ^
        jumboSmall.hashCode ^
        standardExtraLarge.hashCode ^
        standardLarge.hashCode ^
        standardNormal.hashCode ^
        standardSmall.hashCode ^
        compactExtraLarge.hashCode ^
        compactLarge.hashCode ^
        compactNormal.hashCode ^
        compactSmall.hashCode;
  }
}

enum LayoutSize {
  extraLarge,
  large,
  medium,
  small,
  extraSmall,
}

enum LayoutSizeGranular {
  jumboExtraLarge,
  jumboLarge,
  jumboNormal,
  jumboSmall,
  standardExtraLarge,
  standardLarge,
  standardNormal,
  standardSmall,
  compactExtraLarge,
  compactLarge,
  compactNormal,
  compactSmall,
  tiny,
}

abstract class BaseBreakpointsHandler<T extends Object?, K extends Enum> {
  BaseBreakpointsHandler({required this.breakpoints, this.onChanged});
  final void Function(K)? onChanged;
  final BaseBreakpoints<K> breakpoints;
  T? currentValue;
  K? layoutSizeCache;
  Map<K, T?> get values;

  T getLayoutSizeValue(double size) {
    assert(size >= 0, 'Size must be greater than or equal to 0.');

    // get the current layout size based on the provided size.
    final currentLayoutSize = getScreenSize(size);
    // call an optional callback function with the current layout size.
    onChanged?.call(currentLayoutSize);
    // return currentValue if there is no need to update the layout size cache
    if (layoutSizeCache == currentLayoutSize && currentValue != null) {
      return currentValue!;
    }
    // update the layout size cache
    layoutSizeCache = currentLayoutSize;

    // get the callback associated with the current layout size
    var callback = values[layoutSizeCache];
    // return the callback if it is not null and update the currentValue
    if (callback != null) {
      currentValue = callback;
      return callback;
    }

    // determine the index of the current layout size in the breakpoints values
    final index = breakpoints.values.keys.toList().indexOf(layoutSizeCache!);
    final validCallbacks = values.values.toList().sublist(index);
    // get the nest smallest callback that is not null and return it
    callback = validCallbacks.firstWhere(
      (element) => element != null,
      orElse: () => null,
    );

    if (callback != null) {
      currentValue = callback;
      return callback;
    }

    // get the nearest larger callback that is not null and return it
    callback = values.values.lastWhere((element) => element != null);
    currentValue = callback;
    return callback!;
  }

  K getScreenSize(double size) {
    final entries = breakpoints.values.entries;
    for (final entry in entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }

    return entries.last.key;
  }
}

class BreakpointsHandler<T> extends BaseBreakpointsHandler<T, LayoutSize> {
  BreakpointsHandler({
    required super.breakpoints,
    super.onChanged,
    this.extraLarge,
    this.large,
    this.medium,
    this.small,
    this.extraSmall,
  }) : assert(
          extraLarge != null ||
              large != null ||
              medium != null ||
              small != null ||
              extraSmall != null,
          'BreakpointsHandler requires at least one of the size arguments to be filled out',
        );

  final T? extraLarge;
  final T? large;
  final T? medium;
  final T? small;
  final T? extraSmall;

  @override
  Map<LayoutSize, T?> get values => {
        LayoutSize.extraLarge: extraLarge,
        LayoutSize.large: large,
        LayoutSize.medium: medium,
        LayoutSize.small: small,
        LayoutSize.extraSmall: extraSmall,
      };
}

class BreakpointsHandlerGranular<T>
    extends BaseBreakpointsHandler<T, LayoutSizeGranular> {
  BreakpointsHandlerGranular({
    super.breakpoints = BreakpointsGranular.defaultBreakpoints,
    super.onChanged,
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
          'BreakpointsHandlerGranular requires at least one of the size arguments to be filled out',
        );

  final T? jumboExtraLarge;
  final T? jumboLarge;
  final T? jumboNormal;
  final T? jumboSmall;
  final T? standardExtraLarge;
  final T? standardLarge;
  final T? standardNormal;
  final T? standardSmall;
  final T? compactExtraLarge;
  final T? compactLarge;
  final T? compactNormal;
  final T? compactSmall;
  final T? tiny;

  @override
  Map<LayoutSizeGranular, T?> get values => {
        LayoutSizeGranular.jumboExtraLarge: jumboExtraLarge,
        LayoutSizeGranular.jumboLarge: jumboLarge,
        LayoutSizeGranular.jumboNormal: jumboNormal,
        LayoutSizeGranular.jumboSmall: jumboSmall,
        LayoutSizeGranular.standardExtraLarge: standardExtraLarge,
        LayoutSizeGranular.standardLarge: standardLarge,
        LayoutSizeGranular.standardNormal: standardNormal,
        LayoutSizeGranular.standardSmall: standardSmall,
        LayoutSizeGranular.compactExtraLarge: compactExtraLarge,
        LayoutSizeGranular.compactLarge: compactLarge,
        LayoutSizeGranular.compactNormal: compactNormal,
        LayoutSizeGranular.compactSmall: compactSmall,
        LayoutSizeGranular.tiny: tiny,
      };
}

class BreakpointsData extends StatelessWidget {
  const BreakpointsData({
    required this.child,
    this.handlers = const {},
    super.key,
  });

  final Widget child;

  final Map<String, BreakpointsHandler<Object?>> handlers;

  @override
  Widget build(BuildContext context) {
    return ResponsiveData(
      notifier: ResponsiveDataChangeNotifier(
        breakpoints: Breakpoints.defaultBreakpoints,
        handlers: handlers,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          ResponsiveData.of<LayoutSize>(context);
          return child;
        },
      ),
    );
  }
}

class BreakpointsDataGranular extends StatelessWidget {
  const BreakpointsDataGranular({
    required this.child,
    this.handlers = const {},
    super.key,
  });

  final Widget child;

  final Map<String, BreakpointsHandlerGranular<Object?>> handlers;

  @override
  Widget build(BuildContext context) {
    return ResponsiveData<LayoutSizeGranular>(
      notifier: ResponsiveDataChangeNotifier<LayoutSizeGranular>(
        breakpoints: BreakpointsGranular.defaultBreakpoints,
        handlers: handlers,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // ResponsiveData.of<LayoutSizeGranular>(context); test if this is needed
          return child;
        },
      ),
    );
  }
}

class ResponsiveWidget extends StatelessWidget {
  ResponsiveWidget({
    required this.child,
    this.extraLarge = false,
    this.large = false,
    this.medium = false,
    this.small = false,
    this.extraSmall = false,
    this.breakpoints,
    this.useShortestSide = false,
    this.transiationBuilder,
    this.axis = Axis.horizontal,
    this.axisAlignment = -1,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 180),
    this.animate = true,
    super.key,
  }) : assert(
          extraLarge || large || medium || small || extraSmall,
          'At least one of the size parameters must be true',
        );

  final Widget child;

  final bool extraLarge;

  final bool large;

  final bool medium;

  final bool small;

  final bool extraSmall;

  final Breakpoints? breakpoints;

  final bool useShortestSide;

  final Axis axis;

  final double axisAlignment;

  final Curve curve;

  final Duration duration;

  final bool animate;

  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  )? transiationBuilder;

  late final BreakpointsHandler<bool> handler = BreakpointsHandler<bool>(
    breakpoints: breakpoints ?? Breakpoints.defaultBreakpoints,
    extraLarge: extraLarge,
    large: large,
    medium: medium,
    small: small,
    extraSmall: extraSmall,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = useShortestSide ? size.shortestSide : size.width;
    final showChild = handler.getLayoutSizeValue(width);

    return AnimatedShowHide(
      animate: animate,
      duration: duration,
      transitionBuilder: transiationBuilder,
      axis: axis,
      curve: curve,
      axisAlignment: axisAlignment,
      child: showChild ? child : null,
    );
  }
}

class ResponsiveWidgetGranular extends StatelessWidget {
  ResponsiveWidgetGranular({
    required this.child,
    this.breakpoints = BreakpointsGranular.defaultBreakpoints,
    this.useShortestSide = false,
    super.key,
    this.jumboExtraLarge = false,
    this.jumboLarge = false,
    this.jumboNormal = false,
    this.jumboSmall = false,
    this.standardExtraLarge = false,
    this.standardLarge = false,
    this.standardNormal = false,
    this.standardSmall = false,
    this.compactExtraLarge = false,
    this.compactLarge = false,
    this.compactNormal = false,
    this.compactSmall = false,
    this.tiny = false,
    this.transitionBuilder,
    this.axis = Axis.horizontal,
    this.axisAlignment = -1,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 180),
    this.animate = true,
  }) : assert(
          jumboExtraLarge ||
              jumboLarge ||
              jumboNormal ||
              jumboSmall ||
              standardExtraLarge ||
              standardLarge ||
              standardNormal ||
              standardSmall ||
              compactExtraLarge ||
              compactLarge ||
              compactNormal ||
              compactSmall ||
              tiny,
          'At least one of the size params must be true',
        );

  final Widget child;

  final BreakpointsGranular breakpoints;

  final bool jumboExtraLarge;

  final bool jumboLarge;

  final bool jumboNormal;

  final bool jumboSmall;

  final bool standardExtraLarge;

  final bool standardLarge;

  final bool standardNormal;

  final bool standardSmall;

  final bool compactExtraLarge;

  final bool compactLarge;

  final bool compactNormal;

  final bool compactSmall;

  final bool tiny;

  final bool useShortestSide;

  final Axis axis;

  final double axisAlignment;

  final Curve curve;

  final Duration duration;

  final bool animate;

  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  )? transitionBuilder;

  late final BreakpointsHandlerGranular<bool> handler =
      BreakpointsHandlerGranular<bool>(
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
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = useShortestSide ? size.shortestSide : size.width;
    final showChild = handler.getLayoutSizeValue(width);

    return AnimatedShowHide(
      animate: animate,
      duration: duration,
      transitionBuilder: transitionBuilder,
      axis: axis,
      curve: curve,
      axisAlignment: axisAlignment,
      child: showChild ? child : null,
    );
  }
}

typedef AnimatedShowHideTransitionBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Widget? child,
);

class AnimatedShowHide extends StatelessWidget {
  const AnimatedShowHide({
    this.child,
    this.animate = true,
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.ease,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
    this.transitionBuilder,
    super.key,
  });

  final Widget? child;

  final bool animate;

  final Duration duration;

  final Curve curve;

  final Axis axis;

  final double axisAlignment;

  final AnimatedShowHideTransitionBuilder? transitionBuilder;

  Widget buildAnimationWidget(BuildContext context) {
    return AnimatedShowHideChild(
      transitionBuilder: transitionBuilder,
      duration: duration,
      curve: curve,
      axis: axis,
      axisAlignment: axisAlignment,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (animate) {
      return buildAnimationWidget(context);
    }
    return child ?? const SizedBox();
  }
}

class AnimatedShowHideChild extends StatefulWidget {
  const AnimatedShowHideChild({
    this.child,
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.ease,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
    this.transitionBuilder,
    super.key,
  });

  final Widget? child;
  final Duration duration;
  final Curve curve;
  final Axis axis;
  final double axisAlignment;
  final AnimatedShowHideTransitionBuilder? transitionBuilder;

  @override
  State<AnimatedShowHideChild> createState() => _AnimatedShowHideChildState();
}

class _AnimatedShowHideChildState extends State<AnimatedShowHideChild>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<double> animation;

  void _listener() {
    if (controller?.isDismissed ?? false) {
      setState(() {
        outGoingChild = const SizedBox();
      });
    }
  }

  Widget outGoingChild = const SizedBox();

  @override
  void initState() {
    controller ??= AnimationController(vsync: this, duration: widget.duration);
    controller!.addListener(_listener);
    animation = CurvedAnimation(
      parent: controller!.drive(Tween<double>(begin: 0, end: 1)),
      curve: widget.curve,
    );
    controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller?.removeListener(_listener);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedShowHideChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    animatedOnChanges(oldWidget);
  }

  // This method manages the changes in the animated widget and ensures the appropriate actions are taken based on the properties of the current and previous widgets.
  //
  // If the `transitionBuilder` property of the current widget is null, it checks the `child` property of the previous widget. If the previous child is not null, it sets `_outGoingChild` to the previous child; otherwise, it sets it to `SizedBox()`.
  //
  // If the `child` property of the current widget is null, it calls `reverse()` on `_controller`; otherwise, it calls `forward()`.
  //
  // If the `transitionBuilder` property is not null, it checks and sets `_outGoingChild` based on the transition builder's call with the context, animation, and child properties. It then decides whether to call `reverse()` or `forward()` on `_controller` based on the transition builder's call result.
  void animatedOnChanges(covariant AnimatedShowHideChild oldWidget) {
    if (widget.transitionBuilder == null) {
      if (oldWidget.child != null) {
        outGoingChild = oldWidget.child ?? const SizedBox();
      }
      if (widget.child == null) {
        controller?.reverse();
      } else {
        controller?.forward();
      }
    } else {
      if (oldWidget.transitionBuilder?.call(context, animation, widget.child) !=
          null) {
        outGoingChild = oldWidget.transitionBuilder
                ?.call(context, animation, widget.child) ??
            const SizedBox();
      }
      if (widget.transitionBuilder?.call(context, animation, widget.child) ==
          null) {
        controller?.reverse();
      } else {
        controller?.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transitionBuilder != null) {
      return widget.transitionBuilder!(
        context,
        animation,
        widget.child,
      );
    }
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: widget.axisAlignment,
      axis: widget.axis,
      child: widget.child ?? outGoingChild,
    );
  }
}

class AnimatedConstrainedBox extends ImplicitlyAnimatedWidget {
  AnimatedConstrainedBox({
    required this.child,
    required this.constraints,
    super.duration = kDefaultAnimationDuration,
    super.key,
  }) : assert(constraints.debugAssertIsValid(), '');

  final Widget? child;

  final BoxConstraints constraints;

  @override
  AnimatedWidgetBaseState<AnimatedConstrainedBox> createState() =>
      _AnimatedConstraintsState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(
      DiagnosticsProperty<BoxConstraints>(
        'constraints',
        constraints,
        defaultValue: null,
        showName: false,
      ),
    );
  }
}

class _AnimatedConstraintsState
    extends AnimatedWidgetBaseState<AnimatedConstrainedBox> {
  late BoxConstraintsTween _constraints;

  @override
  void initState() {
    _constraints = BoxConstraintsTween(
      begin: widget.constraints,
      end: widget.constraints,
    );
    super.initState();
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _constraints = visitor(
      _constraints,
      widget.constraints,
      (dynamic value) => BoxConstraintsTween(begin: value as BoxConstraints),
    )! as BoxConstraintsTween;
  }

  @override
  Widget build(BuildContext context) {
    final animation = this.animation;
    return ConstrainedBox(
      constraints: _constraints.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);

    description.add(
      DiagnosticsProperty<BoxConstraintsTween>(
        'constraints',
        _constraints,
        showName: false,
        defaultValue: null,
      ),
    );
  }
}

const kDefaultAnimationBeign = 0.0;
const kDefaultAnimationEnd = 1.0;
const kDefaultAnimationDuration = Duration(milliseconds: 180);
const kDefaultAnimationCurve = Curves.ease;
const kDefaultHorizontalEndWidth = 200.0;
const kDefaultVerticalMaxHeight = double.infinity;
const kDefaultVerticalMinHeight = 0.0;
const kDefaultBodyAlignment = Alignment.topCenter;
const kDefaultBodyMaxWidth = 950.0;
const kDefaultBodyMinWidth = 0.0;
const kDefaultFillVertical = true;
const kDefaultBorderRadius = BorderRadius.all(Radius.circular(8));
