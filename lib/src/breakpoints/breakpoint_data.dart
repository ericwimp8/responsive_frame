import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointData extends StatelessWidget {
  const BreakpointData({
    required this.child,
    this.initialHandlers = const {},
    super.key,
  });
  final Widget child;
  final Map<String, BreakpointsHandler<Object?>> initialHandlers;

  @override
  Widget build(BuildContext context) {
    return ResponsiveData(
      notifier: ResponsiveDataChangeNotifier(
        breakpoints: Breakpoints.defaultBreakpoints,
        initialHandlers: initialHandlers,
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
