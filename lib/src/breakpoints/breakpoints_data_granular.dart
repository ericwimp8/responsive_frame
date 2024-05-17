import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Provides [ResponsiveData] of type [LayoutSizeGranular] to the widget tree.
///
/// This widget allows you to define a map of [BreakpointsHandlerGranular]
/// which can be used to return different values based on the screen size.
///
/// It uses the granular breakpoints which is defined in [BreakpointsGranular] by default
/// but can be overriden.
///
/// ## Example
/// ```dart
/// BreakpointsDataGranular(
///   handlers: {
///     'padding': BreakpointsHandlerGranular<EdgeInsets>(
///       standardNormal: const EdgeInsets.all(16),
///       compactSmall: const EdgeInsets.all(8),
///     ),
///     'fontSize': BreakpointsHandlerGranular<double>(
///       standardNormal: 20,
///       compactSmall: 16,
///     ),
///   },
///   child: Builder(
///     builder: (context) {
///       final width = MediaQuery.sizeOf(context).width;
///       final padding =
///           ResponsiveData.handlerOf<EdgeInsets, LayoutSizeGranular>(
///         context,
///         'padding',
///         width,
///       );
///       final fontSize = ResponsiveData.handlerOf<double, LayoutSizeGranular>(
///         context,
///         'fontSize',
///         width,
///      ///

///       return Padding(
///         padding: padding,
///         child: Text(
///           'Hello World!',
///           style: TextStyle(fontSize: fontSize),
///         ),
///       );
///     },
///   ),
/// );
/// ```
class BreakpointsDataGranular extends StatelessWidget {
  /// Provides [ResponsiveData] of type [LayoutSizeGranular] to the widget tree.
  const BreakpointsDataGranular({
    required this.child,
    this.handlers = const {},
    super.key,
  });

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// A map of [BreakpointsHandlerGranular] to be used by the [ResponsiveData].
  final Map<String, BreakpointsHandlerGranular<Object?>> handlers;

  @override
  Widget build(BuildContext context) {
    return ResponsiveData<LayoutSizeGranular>(
      notifier: ResponsiveDataChangeNotifier<LayoutSizeGranular>(
        breakpoints: BreakpointsGranular.defaultBreakpoints,
        handlers: handlers,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // ResponsiveData.of<LayoutSizeGranular>(context); test if this is needed
          return child;
        },
      ),
    );
  }
}
