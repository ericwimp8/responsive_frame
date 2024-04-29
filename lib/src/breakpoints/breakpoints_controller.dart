import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/barrel.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsController<T, K> {
  BreakpointsController({
    required this.breakpoints,
    required this.callbacks,
    required this.defaultValue,
  });
  final Breakpoints<K> breakpoints;

  final K defaultValue;
  K? screenSizeCache;
  T Function(BuildContext context)? currentvalue;
  Map<K, T Function(BuildContext context)?> callbacks;

  double get currentBreakpoint => breakpoints.getBreakpoint();

  List<K> get values => callbacks.entries.map((e) => e.key).toList();

  T Function(BuildContext context) get breakpointCallback {
    final currentScreenSize = breakpoints.getScreenSize();

    if (screenSizeCache == currentScreenSize && currentvalue != null) {
      return currentvalue!;
    }

    screenSizeCache = currentScreenSize;
    final callback = callbacks[screenSizeCache];
    if (callback != null) {
      currentvalue = callback;
      return callback;
    }
    final index = values.indexOf(screenSizeCache as K);
    final validBuilders = values.sublist(index);
    for (final e in validBuilders) {
      final callback = callbacks[e];
      if (callback != null) {
        currentvalue = callback;
        return currentvalue!;
      }
    }

    currentvalue = callbacks[defaultValue];
    return currentvalue!;
  }
}

class BreakpointsControllerNew with WidgetsBindingObserver {
  BreakpointsControllerNew({
    this.breakpoints = BreakpointsNew.defaultBreakpoints,
    this.onChanged,
    this.useShortestSide = false,
    this.handlers = const {},
  }) {
    WidgetsBinding.instance.addObserver(this);
    _handlers.addAll(handlers);
  }

  final BreakpointsNew breakpoints;

  final ValueChanged<ScreenSize>? onChanged;
  final bool useShortestSide;
  final Map<String, BreakpointCallbackHandler<Object? Function()>> handlers;
  final Map<String, BreakpointCallbackHandler<Object? Function()>> _handlers =
      {};

  ScreenSize? screenSizeCache;
  @override
  void didChangeMetrics() {
    final currentScreenSize = getScreenSize();

    for (final element in _handlers.entries) {
      final handler = element.value;
      final handlerKey = element.key;
      handler.onChanged?.call(currentScreenSize);
      if (screenSizeCache == currentScreenSize &&
          handler.currentValue != null) {
        handler.currentValue!.call();
        return;
      }
      screenSizeCache = currentScreenSize;
      final callback = handler.callbacks[screenSizeCache];
      if (callback != null) {
        _handlers[handlerKey] = handler.copyWith(currentValue: callback);
        callback.call();
        return;
      }
      final index = ScreenSize.values.indexOf(screenSizeCache!);
      final validBuilders = ScreenSize.values.sublist(index);
      for (final e in validBuilders) {
        final callback = handler.callbacks[e];
        if (callback != null) {
          _handlers[handlerKey] = handler.copyWith(currentValue: callback);
          callback.call();
          return;
        }
      }

      handler.currentValue!.call();
    }
  }

  Map<String, BreakpointCallbackHandler<Object? Function()>> get handlersMap =>
      _handlers;

  void registerCallbackHandler({
    required Map<String, BreakpointCallbackHandler<Object? Function()>>
        handlers,
  }) {
    _handlers.addAll(handlers);
  }

  void disposeHandler(String handlerKey) {
    _handlers.remove(handlerKey);
  }

  void dispose() {
    _handlers.clear();
    WidgetsBinding.instance.removeObserver(this);
  }

  double deviceWidth() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    if (useShortestSide) {
      return size.shortestSide / pixelRatio;
    }
    return size.width / pixelRatio;
  }

  ScreenSize getScreenSize() {
    for (final entry in breakpoints.values.entries) {
      if (deviceWidth() >= entry.value) {
        return entry.key;
      }
    }
    return ScreenSize.mobile;
  }

  double getBreakpoint() {
    return breakpoints.values[getScreenSize()]!;
  }
}

@immutable
class BreakpointsNew {
  factory BreakpointsNew({
    double desktopLarge = 1200,
    double desktop = 950,
    double tablet = 600,
    double mobile = 300,
    double watch = 0.0,
  }) {
    assert(
      isDescendingOrder<ScreenSize>({
        ScreenSize.desktopLarge: desktopLarge,
        ScreenSize.desktop: desktop,
        ScreenSize.tablet: tablet,
        ScreenSize.mobile: mobile,
        ScreenSize.watch: watch,
      }),
      'Breakpoints values must be in descending order',
    );
    return BreakpointsNew._(
      desktopLarge: desktopLarge,
      desktop: desktop,
      tablet: tablet,
      mobile: mobile,
      watch: watch,
    );
  }
  const BreakpointsNew._({
    this.desktopLarge = 1200,
    this.desktop = 950,
    this.tablet = 600,
    this.mobile = 300,
    this.watch = 0.0,
  });

  final double desktopLarge;
  final double desktop;
  final double tablet;
  final double mobile;
  final double watch;

  static const defaultBreakpoints = BreakpointsNew._();

  Map<ScreenSize, double> get values => {
        ScreenSize.desktopLarge: desktopLarge,
        ScreenSize.desktop: desktop,
        ScreenSize.tablet: tablet,
        ScreenSize.mobile: mobile,
        ScreenSize.watch: watch,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BreakpointsNew &&
        other.desktopLarge == desktopLarge &&
        other.desktop == desktop &&
        other.tablet == tablet &&
        other.mobile == mobile &&
        other.watch == watch;
  }

  @override
  int get hashCode {
    return desktopLarge.hashCode ^
        desktop.hashCode ^
        tablet.hashCode ^
        mobile.hashCode ^
        watch.hashCode;
  }

  @override
  String toString() {
    return 'BreakpointsNew(desktopLarge: $desktopLarge, desktop: $desktop, tablet: $tablet, mobile: $mobile, watch: $watch)';
  }
}

class BreakpointCallbackHandler<T extends Object?> {
  BreakpointCallbackHandler({
    this.desktopLarge,
    this.desktop,
    this.tablet,
    this.mobile,
    this.watch,
    this.onChanged,
    this.currentValue,
  }) : assert(
          desktopLarge != null ||
              desktop != null ||
              tablet != null ||
              mobile != null ||
              watch != null,
          'At least one callback must be provided',
        );

  final T? desktopLarge;
  final T? desktop;
  final T? tablet;
  final T? mobile;
  final T? watch;
  final ValueChanged<ScreenSize>? onChanged;
  final T? currentValue;

  Map<ScreenSize, T?> get callbacks => {
        ScreenSize.desktopLarge: desktopLarge,
        ScreenSize.desktop: desktop,
        ScreenSize.tablet: tablet,
        ScreenSize.mobile: mobile,
        ScreenSize.watch: watch,
      };

  BreakpointCallbackHandler<T> copyWith({
    T? desktopLarge,
    T? desktop,
    T? tablet,
    T? mobile,
    T? watch,
    ValueChanged<ScreenSize>? onChanged,
    T? currentValue,
  }) {
    return BreakpointCallbackHandler<T>(
      desktopLarge: desktopLarge ?? this.desktopLarge,
      desktop: desktop ?? this.desktop,
      tablet: tablet ?? this.tablet,
      mobile: mobile ?? this.mobile,
      watch: watch ?? this.watch,
      onChanged: onChanged ?? this.onChanged,
      currentValue: currentValue ?? this.currentValue,
    );
  }
}

bool isDescendingOrder<T>(Map<T, double> values) {
  double? previousValue;
  for (final value in values.values) {
    if (previousValue != null && value >= previousValue) {
      return false;
    }
    previousValue = value;
  }
  return true;
}
