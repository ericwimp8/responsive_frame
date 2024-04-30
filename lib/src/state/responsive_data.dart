// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/breakpoints/breakpoints_controller.dart';

// @immutable
// class ResponsiveDataState<T> {
//   const ResponsiveDataState({
//     required this.screenSize,
//     required this.deviceWidth,
//     required this.currentBreakpoint,
//     required this.breakpoints,
//   });
//   final T screenSize;
//   final double deviceWidth;
//   final double currentBreakpoint;
//   final Breakpoints<T> breakpoints;

//   @override
//   String toString() {
//     return 'BreakpointState(screenSize: $screenSize, deviceWidth: $deviceWidth, currentBreakpoint: $currentBreakpoint, breakpoints: $breakpoints)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is ResponsiveDataState &&
//         other.screenSize == screenSize &&
//         other.deviceWidth == deviceWidth &&
//         other.currentBreakpoint == currentBreakpoint &&
//         other.breakpoints == breakpoints;
//   }

//   @override
//   int get hashCode {
//     return screenSize.hashCode ^
//         deviceWidth.hashCode ^
//         currentBreakpoint.hashCode ^
//         breakpoints.hashCode;
//   }
// }

class ResponsiveDataChangeNotifier<K extends Enum> with ChangeNotifier {
  ResponsiveDataChangeNotifier({
    required this.controller,
  });

  BreakpointsController<K> controller;
  BreakpointHandler<T, K> getHandler<T extends Object>(String key) {
    return controller.getHandler<T>(key);
  }

  void addAllHandlers<T extends Object>({
    required Map<String, BreakpointHandler<T, K>> handlers,
  }) {
    controller.addAllHandlers<T>(handlers: handlers);
    notifyListeners();
  }

  void addHandler<T extends Object>({
    required String key,
    required BreakpointHandler<T, K> handler,
  }) {
    controller.addHandler<T>(key: key, handler: handler);
    notifyListeners();
  }

  void removeAllHandlers() {
    controller.removeAllHandlers();
    notifyListeners();
  }

  void removeHandler(String key) {
    controller.removeHandler(key);
    notifyListeners();
  }

  void disposeHandler(String handlerKey) {
    controller.disposeHandler(handlerKey);
    notifyListeners();
  }

  K getScreenSize(double size) {
    for (final entry in controller.breakpoints.values.entries) {
      if (size >= entry.value) {
        return entry.key as K;
      }
    }
    throw Exception(
      'No screen size found in ${controller.breakpoints.values}. ',
    );
  }
}

class ResponsiveData extends InheritedNotifier<ResponsiveDataChangeNotifier> {
  const ResponsiveData({
    required ResponsiveDataChangeNotifier super.notifier,
    required super.child,
    super.key,
  });

  static ResponsiveDataChangeNotifier of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ResponsiveData>();
    if (result == null) {
      throw FlutterError(
        'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
      );
    }
    return result.notifier!;
  }

  static BreakpointHandler handlerOf(
    BuildContext context,
    String key,
  ) {
    final result = context.dependOnInheritedWidgetOfExactType<ResponsiveData>();
    if (result == null) {
      throw FlutterError(
        'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
      );
    }
    return result.notifier!.getHandler(key);
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNotifier<ResponsiveDataChangeNotifier> oldWidget,
  ) {
    return oldWidget.notifier?.controller != notifier?.controller;
  }
}
