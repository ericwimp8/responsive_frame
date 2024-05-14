import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsDataGranular extends StatelessWidget {
  const BreakpointsDataGranular({
    required this.child,
    this.handlers = const {},
    super.key,
  });
  final Widget child;
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
          ResponsiveData.of<LayoutSizeGranular>(context);
          return child;
        },
      ),
    );
  }
}
