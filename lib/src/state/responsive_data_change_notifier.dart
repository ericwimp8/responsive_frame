import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Handles responsive data changes based on screen size.
///
/// The [ResponsiveDataChangeNotifier] class extends [ChangeNotifier] and includes [WidgetsBindingObserver].
/// It is used as a notifier for [ResponsiveData] that provides [BreakpointsHandler]s and current screen
/// size data to the widget tree below it.
///
/// ## Example:
///
/// ```dart
/// ResponsiveData(
///   notifier: ResponsiveDataChangeNotifier(
///     breakpoints: Breakpoints.defaultBreakpoints,
///     handlers: handlers,
///   ),
///   child: LayoutBuilder(
///     builder: (context, constraints) {
///       ResponsiveData.of<LayoutSize>(context);
///       return child;
///     },
///   ),
/// );
/// ```
/// See also:
/// - [ChangeNotifier], a class in the Flutter framework for managing listeners.
/// - [WidgetsBindingObserver], an interface for handling widget binding events.

class ResponsiveDataChangeNotifier<K extends Enum> extends ChangeNotifier
    with WidgetsBindingObserver {
  /// Handles responsive data changes based on screen size.
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

  /// Sets the [_useShortestSide] property with the provided [value].
  ///
  /// This method updates the metrics and notifies the listeners.
  void setUseShortestSide({required bool value}) {
    _useShortestSide = value;
    updateMetrics();
    notifyListeners();
  }

  @override
  void didChangeMetrics() {
    updateMetrics();
  }

  /// Gets the handler with the specified [key].
  ///
  /// If no handler is found for the given key, an assertion error is thrown.
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

  /// Updates [currentBreakpoint] and [screenSize] based on the current metrics.
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
