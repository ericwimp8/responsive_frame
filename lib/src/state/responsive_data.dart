import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A class that provides access to responsive data and handlers based on screen size.
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
class ResponsiveData<K extends Enum>
    extends InheritedNotifier<ResponsiveDataChangeNotifier<K>> {
  /// Constructs a [ResponsiveData] widget.
  const ResponsiveData({
    required ResponsiveDataChangeNotifier<K> super.notifier,
    required super.child,
    super.key,
  });

  /// Retrieves the [ResponsiveDataChangeNotifier] of type [K] from the nearest ancestor [ResponsiveData] widget.
  ///
  /// Throws an assertion error if [ResponsiveData] is not found in the widget tree.
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

  /// Retrieves a handler of type [T] with the specified [key] and [size] from the nearest ancestor [ResponsiveData] widget.
  ///
  /// Throws an assertion error if [ResponsiveData] is not found in the widget tree or if no handler is found for the specified key.
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
