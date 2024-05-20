import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// {@template responsive_data}
/// {@tool snippet}
/// This example shows how to use the [ResponsiveData] with [ResponsiveDataChangeNotifier] widget to access responsive
/// data.
///
/// ```dart
///
/// ResponsiveData(
///    notifier: ResponsiveDataChangeNotifier(
///      breakpoints: Breakpoints.defaultBreakpoints,
///      handlers: {
///        'myHandler': BreakpointsHandler<String>(
///          breakpoints: Breakpoints.defaultBreakpoints,
///          extraLarge: 'Extra large',
///          large: 'Large',
///          medium: 'Medium',
///          small: 'Small',
///        ),
///      },
///    ),
///    child: MyNestedWidget(),
/// );
/// ```
/// {@end-tool}
///
/// {@tool snippet}
/// ```dart
/// class MyNestedWidget extends StatelessWidget {
///   const MyNestedWidget({super.key});
///   @override
///   Widget build(BuildContext context) {
///     final data = ResponsiveData.of<LayoutSize>(context);
///     print(data);
///     return Container();
///   }
/// }
/// ```
///
/// {@end-tool}
/// {@endtemplate}

/// A widget that provides access to responsive data.
///
/// The [ResponsiveData] widget provides access to responsive data, such as the
/// screen size and the current breakpoint. The data is provided through a
/// [ResponsiveDataChangeNotifier] object, which can be accessed using the
/// [of] static method.
///
/// The [ResponsiveData] widget should be placed at the top of your widget tree
/// to ensure that all child widgets have access to the responsive data.
///
/// {@macro responsive_data}
///
/// See also:
///
///  * [ResponsiveDataChangeNotifier]
///  * [Breakpoints]
///  * [BreakpointsHandler]
///  * [BreakpointsData] - a convenience widget wrapper over [ResponsiveData] for [LayoutSize]
///  * [BreakpointsDataGranular] - a convenience widget wrapper over [ResponsiveData] for [LayoutSizeGranular]
///  * [ResponsiveFrameLayout] - a consistent responsive layout over [BreakpointsData]
///  * [ResponsiveFrameLayoutGranular] - a consistent responsive layout over [BreakpointsDataGranular]
class ResponsiveData<K extends Enum>
    extends InheritedNotifier<ResponsiveDataChangeNotifier<K>> {
  /// Creates a new [ResponsiveData] widget.
  ///
  /// The [notifier] property is the [ResponsiveDataChangeNotifier] object that
  /// provides the responsive data. The [child] property is the widget to be
  /// wrapped by the [ResponsiveData] widget.
  const ResponsiveData({
    required ResponsiveDataChangeNotifier<K> super.notifier,
    required super.child,
    super.key,
  });

  /// Returns the [ResponsiveDataChangeNotifier] object associated with the
  /// nearest [ResponsiveData] widget in the widget tree.
  ///
  /// If there is no [ResponsiveData] widget in the widget tree, this method will
  /// throw an assertion error.
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

  /// Returns the handler associated with the given key and layout size.
  ///
  /// The handler is retrieved from the [ResponsiveDataChangeNotifier] object
  /// associated with the nearest [ResponsiveData] widget in the widget tree.
  ///
  /// If there is no [ResponsiveData] widget in the widget tree, this method will
  /// throw an assertion error.
  ///
  /// The `size` parameter is the layout size to be used to retrieve the handler.
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
