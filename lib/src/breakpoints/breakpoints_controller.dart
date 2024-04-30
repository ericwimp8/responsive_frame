import 'package:flutter/foundation.dart';
import 'package:responsive_frame/barrel.dart';
import 'package:responsive_frame/responsive_frame.dart';

@immutable
class BreakpointsController<K extends Enum> {
  factory BreakpointsController({
    Map<String, BreakpointHandler<Object, K>> initialHandlers = const {},
    Breakpoints breakpoints = Breakpoints.defaultBreakpoints,
  }) {
    return BreakpointsController._(
      initialHandlers: initialHandlers,
      breakpoints: breakpoints,
    );
  }
  const BreakpointsController._({
    this.breakpoints = Breakpoints.defaultBreakpoints,
    Map<String, BreakpointHandler<Object?, K>> initialHandlers = const {},
  }) : _handlers = initialHandlers;

  final Map<String, BreakpointHandler<Object?, K>> _handlers;
  final Breakpoints breakpoints;
  static const defaultController = BreakpointsController<ScreenSize>._();

  BreakpointHandler<T, K> getHandler<T extends Object>(String key) {
    if (_handlers.containsKey(key)) {
      return _handlers[key]! as BreakpointHandler<T, K>;
    }
    throw FlutterError(
      'BreakpointsController: No handler found for key: $key. '
      'Check that the key is correct or that the handler is added to the controller.',
    );
  }

  void addAllHandlers<T extends Object>({
    required Map<String, BreakpointHandler<T, K>> handlers,
  }) {
    _handlers.addAll(handlers);
  }

  void addHandler<T extends Object>({
    required String key,
    required BreakpointHandler<T, K> handler,
  }) {
    _handlers[key] = handler;
  }

  void removeAllHandlers() {
    _handlers.clear();
  }

  void removeHandler(String key) {
    _handlers.remove(key);
  }

  void disposeHandler(String handlerKey) {
    _handlers.remove(handlerKey);
  }

  void dispose() {
    _handlers.clear();
  }

  @override
  String toString() => 'BreakpointsController( _handlers: $_handlers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BreakpointsController &&
        mapEquals(other._handlers, _handlers);
  }

  @override
  int get hashCode => _handlers.hashCode;
}

class BreakpointHandler<T extends Object?, K extends Enum> {
  BreakpointHandler({
    required this.breakpoints,
    required this.values,
    this.onChanged,
  }) : assert(
          values.length > 1,
          'At least one callback must be provided',
        );

  final Map<K, T?> values;
  final ValueChanged<K>? onChanged;
  final Breakpoints<K> breakpoints;
  K? screenSizeCache;
  T? currentValue;

// match the number of callbacks

  K _getScreenSize(double size) {
    for (final entry in breakpoints.values.entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }

    throw FlutterError(
      'screenSize $screenSizeCache not found in ${breakpoints.values.keys}',
    );
  }

  double getBreakpoint(double size) {
    return breakpoints.values[screenSizeCache ?? _getScreenSize(size)]!;
  }

  T? updateMetrics(double size) {
    final currentScreenSize = _getScreenSize(size);
    print(currentScreenSize);
    onChanged?.call(currentScreenSize);

    if (screenSizeCache == currentScreenSize && currentValue != null) {
      return currentValue!;
    }
    screenSizeCache = currentScreenSize;
    final callback = values[screenSizeCache];
    if (callback != null) {
      currentValue = callback;
      return callback;
    }
    final screenSizeEnum = breakpoints.values.keys;
    final index = screenSizeEnum.toList().indexOf(screenSizeCache!);
    final validBuilders = screenSizeEnum.toList().sublist(index);
    for (final e in validBuilders) {
      final callback = values[e];
      if (callback != null) {
        currentValue = callback;
        return callback;
      }
    }

    return values[ScreenSize.mobile];
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
