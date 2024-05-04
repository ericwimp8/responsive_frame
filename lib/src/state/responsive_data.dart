// ignore_for_file: strict_raw_type

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveDataChangeNotifier<K extends Enum> with ChangeNotifier {
  ResponsiveDataChangeNotifier({
    required this.breakpoints,
    Map<String, BreakpointsHandler<Object?>> initialHandlers = const {},
  }) : _handlers = initialHandlers;
  final BaseBreakpoints<K> breakpoints;
  final Map<String, BreakpointsHandler<Object?>> _handlers;

  BreakpointsHandler<T> getHandler<T extends Object>(String key) {
    if (_handlers.containsKey(key)) {
      return _handlers[key]! as BreakpointsHandler<T>;
    }
    throw FlutterError(
      'BreakpointsController: No handler found for key: $key. '
      'Check that the key is correct or that the handler is added to the controller.',
    );
  }

  void addAllHandlers<T extends Object>({
    required Map<String, BreakpointsHandler<T>> handlers,
  }) {
    _handlers.addAll(handlers);
    notifyListeners();
  }

  void addHandler<T extends Object>({
    required String key,
    required BreakpointsHandler<T> handler,
  }) {
    _handlers[key] = handler;
    notifyListeners();
  }

  void removeAllHandlers() {
    _handlers.clear();
    notifyListeners();
  }

  void removeHandler(String key) {
    _handlers.remove(key);
    notifyListeners();
  }

  void disposeHandler(String handlerKey) {
    _handlers.remove(handlerKey);
    notifyListeners();
  }

  K getScreenSize(double size) {
    for (final entry in breakpoints.values.entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }
    throw Exception(
      'No screen size found in ${breakpoints.values}. ',
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
    if (result == null) {
      throw FlutterError(
        'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
      );
    }
    return result.notifier!;
  }

  static T handlerOf<T extends Object, K extends Enum>(
    BuildContext context,
    String key,
    double size,
  ) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ResponsiveData<K>>();
    if (result == null) {
      throw FlutterError(
        'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
      );
    }

    return result.notifier!.getHandler<T>(key).getLayoutSizeValue(size);
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNotifier<ResponsiveDataChangeNotifier> oldWidget,
  ) {
    return mapEquals(oldWidget.notifier!._handlers, notifier!._handlers);
  }
}
