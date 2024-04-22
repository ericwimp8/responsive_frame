// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

@immutable
class ResponsiveDataState<T> {
  const ResponsiveDataState({
    required this.screenSize,
    required this.deviceWidth,
    required this.currentBreakpoint,
    required this.breakpoints,
  });
  final T screenSize;
  final double deviceWidth;
  final double currentBreakpoint;
  final BaseBreakpoints<T> breakpoints;

  @override
  String toString() {
    return 'BreakpointState(screenSize: $screenSize, deviceWidth: $deviceWidth, currentBreakpoint: $currentBreakpoint, breakpoints: $breakpoints)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponsiveDataState &&
        other.screenSize == screenSize &&
        other.deviceWidth == deviceWidth &&
        other.currentBreakpoint == currentBreakpoint &&
        other.breakpoints == breakpoints;
  }

  @override
  int get hashCode {
    return screenSize.hashCode ^
        deviceWidth.hashCode ^
        currentBreakpoint.hashCode ^
        breakpoints.hashCode;
  }
}

class ResponsiveDataChangeNotifier<T> with ChangeNotifier {
  ResponsiveDataChangeNotifier({
    required this.breakpoints,
    this.useShortestSide = false,
    this.controllers,
  }) {
    _screenSize = breakpoints.getScreenSize();
    // breakpoints = breakpoints.copyWith(useShortestSide: useShortestSide);
  }
  BaseBreakpoints<T> breakpoints;
  final bool useShortestSide;
  late T _screenSize;

  Map<String, BreakpointsController>? controllers = {};
  BreakpointsController<Q, K> getController<Q, K>(String tag) {
    final controllersList =
        controllers!.entries.where((element) => element.key == tag);

    return controllersList.first.value as BreakpointsController<Q, K>;
  }

  ResponsiveDataState get state => ResponsiveDataState(
        screenSize: _screenSize,
        deviceWidth: deviceWidth(),
        currentBreakpoint: currentBreakPoint(),
        breakpoints: breakpoints,
      );

  double currentBreakPoint() => breakpoints.getBreakpoint();

  double deviceWidth() {
    return breakpoints.deviceWidth();
  }

  void updateScreenSize() {
    final newScreenSize = breakpoints.getScreenSize();
    if (_screenSize != newScreenSize) {
      _screenSize = newScreenSize;
      Future(notifyListeners);
    }
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

  static BreakpointsController<T, K> controllerOf<T, K>(
    BuildContext context,
    String tag,
  ) {
    final result = context.dependOnInheritedWidgetOfExactType<ResponsiveData>();
    if (result == null) {
      throw FlutterError(
        'BreakpointsController was not found in the widget tree. Make sure to wrap your widget tree with a BreakpointsController.',
      );
    }
    return result.notifier!.getController<T, K>(tag);
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNotifier<ResponsiveDataChangeNotifier> oldWidget,
  ) {
    return oldWidget.notifier?.state != notifier?.state;
  }
}
