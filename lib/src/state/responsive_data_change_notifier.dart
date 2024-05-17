import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A change notifier that provides access to responsive data.
///
/// The [ResponsiveDataChangeNotifier] class provides access to responsive data,
/// such as the screen size and the current breakpoint. The data is provided
/// through a [Breakpoints] object and a map of [BreakpointsHandler] objects.
///
/// The [ResponsiveDataChangeNotifier] class can be used with the
/// [ResponsiveData] widget to provide responsive data to child widgets.
///
/// This example shows how to use the [ResponsiveDataChangeNotifier] class to
/// provide responsive data.
/// {@macro responsive_data}
///
/// See also:
///
///  * [ResponsiveData]
///  * [Breakpoints]
///  * [BreakpointsHandler]
class ResponsiveDataChangeNotifier<K extends Enum> extends ChangeNotifier
    with WidgetsBindingObserver {
  /// Creates a new [ResponsiveDataChangeNotifier] object.
  ///
  /// The [breakpoints] property is the [Breakpoints] object that defines the
  /// breakpoints for each layout size. The [handlers] property is a map of
  /// [BreakpointsHandler] objects that provide access to the handlers for each
  /// layout size. The [useShortestSide] property determines whether to use the
  /// shortest side of the screen to determine the layout size.
  ///
  /// The [testView] parameter is used for testing purposes only. It allows
  /// you to provide a custom [FlutterView] object to the change notifier.
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

  /// The [FlutterView] object to use for testing purposes only.
  final FlutterView? testView;

  /// The [Breakpoints] object that defines the breakpoints for each layout size.
  final BaseBreakpoints<K> breakpoints;

  /// The current screen size.
  K? screenSize;

  /// The current breakpoint.
  double? currentBreakpoint;

  /// The map of [BreakpointsHandler] objects that provide access to the handlers
  /// for each layout size.
  final Map<String, BaseBreakpointsHandler<Object?, K>> _handlers;

  /// Whether to use the shortest side of the screen to determine the layout size.
  bool _useShortestSide;

  /// The map of [BreakpointsHandler] objects that provide access to the handlers
  /// for each layout size.
  Map<String, BaseBreakpointsHandler<Object?, K>> get handlers => _handlers;

  /// Whether to use the shortest side of the screen to determine the layout size.
  bool get useShortestSide => _useShortestSide;

  /// Sets whether to use the shortest side of the screen to determine the layout size.
  ///
  /// The [value] parameter determines whether to use the shortest side of the screen.
  void setUseShortestSide({required bool value}) {
    _useShortestSide = value;
    updateMetrics();
    notifyListeners();
  }

  @override
  void didChangeMetrics() {
    updateMetrics();
  }

  /// Returns the [BreakpointsHandler] object associated with the given key.
  ///
  /// The [key] parameter is the key of the handler to be retrieved.
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

  /// Updates the screen size and breakpoint.
  ///
  /// This method is called when the screen size changes. It updates the
  /// [screenSize] and [currentBreakpoint] properties based on the new screen
  /// size.
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

  /// Returns the screen size based on the given size.
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
