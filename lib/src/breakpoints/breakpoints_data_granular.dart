import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides access to breakpoints with granular size categories
/// and responsive data.
///
/// The [BreakpointsDataGranular] widget provides a convenient way to manage
/// breakpoints with granular size categories and access responsive data within
/// a widget tree. It creates a [ResponsiveDataChangeNotifier] instance, which
/// can be accessed using the [ResponsiveData.of] method, and provides the
/// necessary context for responsive layout adjustments with granular screen
/// size distinctions.
///
/// The widget accepts a map of handlers, keyed by string identifiers, which
/// define the layout values for different screen sizes using the granular
/// categories. These handlers are instances of
/// [BreakpointsHandlerGranular] and are used to determine the appropriate
/// layout value based on the current screen size and its granular size
/// category.
///
/// The [child] property represents the widget tree that will have access to the
/// responsive data.
///
/// {@tool snippet}
/// This example demonstrates how to use the [BreakpointsDataGranular] widget
/// to define breakpoints with granular size categories and access responsive
/// data within a widget tree.
///
/// ```dart
/// BreakpointsDataGranular(
///   handlers: {
///     'myHandler': BreakpointsHandlerGranular<String>(
///       jumboExtraLarge: 'Jumbo Extra Large',
///       jumboLarge: 'Jumbo Large',
///       jumboNormal: 'Jumbo Normal',
///       jumboSmall: 'Jumbo Small',
///       standardExtraLarge: 'Standard Extra Large',
///       standardLarge: 'Standard Large',
///       standardNormal: 'Standard Normal',
///       standardSmall: 'Standard Small',
///       compactExtraLarge: 'Compact Extra Large',
///       compactLarge: 'Compact Large',
///       compactNormal: 'Compact Normal',
///       compactSmall: 'Compact Small',
///       tiny: 'Tiny',
///     ),
///   },
///   child: const Text('Hello World!'),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [BreakpointsHandlerGranular]
///  * [ResponsiveData]
///  * [ResponsiveDataChangeNotifier]
///  * [ResponsiveFrameLayoutGranular] - a consistent responsive layout over [BreakpointsDataGranular]
class BreakpointsDataGranular extends StatelessWidget {
  /// Creates a new [BreakpointsDataGranular] widget.
  ///
  /// The [child] property represents the widget tree that will have access to
  /// the responsive data. The optional [handlers] map defines the layout values
  /// for different screen sizes, keyed by string identifiers.
  const BreakpointsDataGranular({
    required this.child,
    this.handlers = const {},
    super.key,
  });

  /// The widget tree that will have access to the responsive data.
  final Widget child;

  /// A map of handlers, keyed by string identifiers, which define the layout
  /// values for different screen sizes. These handlers are instances of
  /// [BreakpointsHandlerGranular] and are used to determine the appropriate
  /// layout value based on the current screen size and its granular size
  /// category.
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
