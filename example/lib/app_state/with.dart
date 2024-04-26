import 'package:flutter/material.dart';

// Simple generic InheritedNotiifer and InheritedWidget to manage state

class WithUpdate<T extends ChangeNotifier> extends InheritedNotifier<T> {
  const WithUpdate({
    required T super.notifier,
    required super.child,
    this.shouldNotify,
    super.key,
  });
  final bool Function(WithUpdate<T>)? shouldNotify;

  static K of<K extends ChangeNotifier>(
    BuildContext context,
  ) {
    final result = context.dependOnInheritedWidgetOfExactType<WithUpdate<K>>();
    // TODO(ericwimp): implement this as listen: false for usage inside initState
    // final foo = context
    //     .getElementForInheritedWidgetOfExactType<WithUpdate<K>>()!
    //     .widget as InheritedWidget;

    if (result == null) {
      throw FlutterError(
        '$K was not found in the widget tree. Make sure to wrap your widget tree with a $K.',
      );
    }
    return result.notifier!;
  }

  @override
  bool updateShouldNotify(WithUpdate<T> oldWidget) =>
      shouldNotify?.call(oldWidget) ?? true;
}

class With<T> extends InheritedWidget {
  const With({
    required this.value,
    required super.child,
    this.shouldNotify,
    super.key,
  });

  final bool Function(With<T>)? shouldNotify;

  final T value;

  static T? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<With<T>>()?.value;
  }

  static T of<T>(BuildContext context) {
    final result = maybeOf<T>(context);
    assert(
      result != null,
      '$T was not found in the widget tree. Make sure to wrap your widget tree with a $T.',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(With<T> oldWidget) =>
      shouldNotify?.call(oldWidget) ?? value != oldWidget.value;
}
