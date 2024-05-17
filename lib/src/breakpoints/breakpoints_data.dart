import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides responsive data and handlers based on screen size.
class BreakpointsData extends StatelessWidget {
  /// Creates a [BreakpointsData] widget.
  const BreakpointsData({
    required this.child,
    this.handlers = const {},
    super.key,
  });

  /// The widget to be rendered within the responsive data.
  final Widget child;

  /// Map of string keys to [BreakpointsHandler] objects.
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
