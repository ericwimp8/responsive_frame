import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointDataGranular extends StatelessWidget {
  const BreakpointDataGranular({
    required this.child,
    this.initialHandlers = const {},
    super.key,
  });
  final Widget child;
  final Map<String, BreakpointsHandlerGranular<Object?>> initialHandlers;

  @override
  Widget build(BuildContext context) {
    return ResponsiveData<LayoutSizeGranular>(
      notifier: ResponsiveDataChangeNotifier<LayoutSizeGranular>(
        breakpoints: BreakpointsGranular.defaultBreakpoints,
        initialHandlers: initialHandlers,
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