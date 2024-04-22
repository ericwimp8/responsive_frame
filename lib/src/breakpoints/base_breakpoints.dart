import 'package:flutter/material.dart';

class BaseBreakpoints<T> {
  const BaseBreakpoints({
    required this.values,
    this.useShortestSide = false,
  });
  final bool useShortestSide;
  final Map<T, double> values;

  double getBreakpoint() {
    return values[getScreenSize()]!;
  }

  T getScreenSize() {
    for (final entry in values.entries) {
      if (deviceWidth() >= entry.value) {
        return entry.key;
      }
    }

    return values
        .entries.last.key; // Default to the smallest size if none match
  }

  double deviceWidth() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize;
    final pixelRatio = view.devicePixelRatio;
    if (useShortestSide) {
      return view.physicalSize.shortestSide / pixelRatio;
    }
    return size.width / pixelRatio;
  }

  @override
  String toString() =>
      'BaseBreakpoints(useShortestSide: $useShortestSide, values: $values)';
}
