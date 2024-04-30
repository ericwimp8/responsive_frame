// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/breakpoints/breakpoints_controller.dart';

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
