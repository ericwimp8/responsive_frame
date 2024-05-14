import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

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

    assert(
      result != null,
      'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
    );

    return result!.notifier!;
  }

  static T handlerOf<T extends Object, K extends Enum>(
    BuildContext context,
    String key,
    double size,
  ) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ResponsiveData<K>>();

    assert(
      result != null,
      'ResponsiveData was not found in the widget tree. Make sure to wrap your widget tree with a ResponsiveData.',
    );

    return result!.notifier!.getHandler<T>(key).getLayoutSizeValue(size);
  }

  @override
  bool updateShouldNotify(
    covariant InheritedNotifier<ResponsiveDataChangeNotifier> oldWidget,
  ) {
    return true;
  }
}
