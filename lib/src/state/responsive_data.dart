import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/breakpoints/breakpoints.dart';

@immutable
class ResponsiveDataState {
  const ResponsiveDataState({
    required this.screenSize,
    required this.deviceWidth,
    required this.currentBreakpoint,
    required this.breakpoints,
  });
  final ScreenSize screenSize;
  final double deviceWidth;
  final double currentBreakpoint;
  final Breakpoints breakpoints;

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

class ResponsiveDataChangeNotifier with ChangeNotifier {
  ResponsiveDataChangeNotifier({
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.useShortestSide = false,
  }) {
    _screenSize = _getScreenSize;
  }
  final Breakpoints breakpoints;
  final bool useShortestSide;
  late ScreenSize _screenSize;

  ResponsiveDataState get state => ResponsiveDataState(
        screenSize: _screenSize,
        deviceWidth: deviceWidth(),
        currentBreakpoint: currentBreakPoint(),
        breakpoints: breakpoints,
      );

  double currentBreakPoint() =>
      breakpoints.getBreakpointFromWidth(deviceWidth());
  double deviceWidth() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    if (useShortestSide) {
      return view.physicalSize.shortestSide / pixelRatio;
    }
    return size.width / pixelRatio;
  }

  ScreenSize get _getScreenSize {
    return breakpoints.getScreenSize(deviceWidth: deviceWidth());
  }

  void updateScreenSize() {
    final newScreenSize = _getScreenSize;
    // if (_screenSize != newScreenSize) {
    _screenSize = newScreenSize;
    Future(notifyListeners);
    // }
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

  @override
  bool updateShouldNotify(
    covariant InheritedNotifier<ResponsiveDataChangeNotifier> oldWidget,
  ) {
    return oldWidget.notifier?.state != notifier?.state;
  }
}
