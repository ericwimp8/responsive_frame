import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides access to breakpoints and responsive data.
///
/// The [BreakpointsData] widget provides a convenient way to manage breakpoints
/// and access responsive data within a widget tree. It creates a
/// [ResponsiveDataChangeNotifier] instance, which can be accessed using the
/// [ResponsiveData.of] method, and provides the necessary context for
/// responsive layout adjustments.
///
/// The widget accepts a map of handlers, keyed by string identifiers, which
/// define the layout values for different screen sizes. These handlers are
/// instances of [BreakpointsHandler] or [BreakpointsHandlerGranular] and are used
/// to determine the appropriate layout value based on the current screen size.
///
/// The [child] property represents the widget tree that will have access to the
/// responsive data.
///
/// {@tool snippet}
/// This example demonstrates how to use the [BreakpointsData] widget to define
/// breakpoints and access responsive data within a widget tree.
///
/// ```dart
/// BreakpointsData(
///   handlers: {
///     'myHandler': BreakpointsHandler<String>(
///       breakpoints: Breakpoints.defaultBreakpoints,
///       extraLarge: 'Extra Large',
///       large: 'Large',
///       medium: 'Medium',
///       small: 'Small',
///     ),
///   },
///   child: const Text('Hello World!'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [BreakpointsHandler]
///  * [BreakpointsHandlerGranular]
///  * [ResponsiveData]
///  * [ResponsiveDataChangeNotifier]
class BreakpointsData extends StatelessWidget {
  /// Creates a new [BreakpointsData] widget.
  ///
  /// The [child] property represents the widget tree that will have access to
  /// the responsive data. The optional [handlers] map defines the layout values
  /// for different screen sizes, keyed by string identifiers.
  const BreakpointsData({
    required this.child,
    this.handlers = const {},
    super.key,
  });

  /// The widget tree that will have access to the responsive data.
  final Widget child;

  /// A map of handlers, keyed by string identifiers, which define the layout
  /// values for different screen sizes. These handlers are instances of
  /// [BreakpointsHandler] or [BreakpointsHandlerGranular] and are used to
  /// determine the appropriate layout value based on the current screen size.
  final Map<String, BreakpointsHandler<Object?>> handlers;

  @override
  Widget build(BuildContext context) {
    return ResponsiveData(
      notifier: ResponsiveDataChangeNotifier(
        breakpoints: Breakpoints.defaultBreakpoints,
        handlers: handlers,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          ResponsiveData.of<LayoutSize>(context);
          return child;
        },
      ),
    );
  }
}
