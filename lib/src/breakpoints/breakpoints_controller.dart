import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsController<T, K> {
  BreakpointsController({
    required this.breakpoints,
    required this.callbacks,
    required this.defaultValue,
  });
  final BaseBreakpoints<K> breakpoints;
  final K defaultValue;
  K? screenSizeCache;
  T Function(BuildContext context)? currentvalue;
  Map<K, T Function(BuildContext context)?> callbacks;

  double get currentBreakpoint => breakpoints.getBreakpoint();

  List<K> get values => callbacks.entries.map((e) => e.key).toList();

  T Function(BuildContext context) get breakpointCallback {
    final currentScreenSize = breakpoints.getScreenSize();

    if (screenSizeCache == currentScreenSize && currentvalue != null) {
      return currentvalue!;
    }

    screenSizeCache = currentScreenSize;
    final callback = callbacks[screenSizeCache];
    if (callback != null) {
      currentvalue = callback;
      return callback;
    }
    final index = values.indexOf(screenSizeCache as K);
    final validBuilders = values.sublist(index);
    for (final e in validBuilders) {
      final callback = callbacks[e];
      if (callback != null) {
        currentvalue = callback;
        return currentvalue!;
      }
    }

    currentvalue = callbacks[defaultValue];
    return currentvalue!;
  }
}
