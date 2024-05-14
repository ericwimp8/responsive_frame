import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsData extends StatelessWidget {
  const BreakpointsData({
    required this.child,
    this.handlers = const {},
    super.key,
  });
  final Widget child;
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
