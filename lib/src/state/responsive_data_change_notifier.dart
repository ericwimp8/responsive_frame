import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveDataChangeNotifier<K extends Enum> extends ChangeNotifier
    with WidgetsBindingObserver {
  ResponsiveDataChangeNotifier({
    required this.breakpoints,
    bool useShortestSide = false,
    Map<String, BaseBreakpointsHandler<Object?, K>> handlers = const {},
    // view is only to be passed in for testing
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
    final view =
        testView ?? WidgetsBinding.instance.platformDispatcher.views.first;
    final physicalWidth = view.physicalSize.width;
    final physicalHeight = view.physicalSize.height;
    final devicePixelRatio = view.devicePixelRatio;
    final screenWidth = physicalWidth / devicePixelRatio;
    final screenHeight = physicalHeight / devicePixelRatio;
    late double width;

    if (_useShortestSide) {
      width = screenWidth < screenHeight
          ? width = screenWidth
          : width = screenHeight;
    } else {
      width = screenWidth;
    }

    final screensize = _getScreenSize(width);
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
