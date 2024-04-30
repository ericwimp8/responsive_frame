import 'package:flutter/foundation.dart';
import 'package:responsive_frame/barrel.dart';
import 'package:responsive_frame/responsive_frame.dart';

class BreakpointHandler<T extends Object?, K extends Enum> {
  BreakpointHandler({
    required this.breakpoints,
    required this.values,
    this.onChanged,
  }) : assert(
          values.length > 1,
          'At least one callback must be provided',
        );

  final Map<K, T?> values;
  final ValueChanged<K>? onChanged;
  final Breakpoints<K> breakpoints;
  K? screenSizeCache;

// match the number of callbacks

  K _getScreenSize(double size) {
    for (final entry in breakpoints.values.entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }

    throw FlutterError(
      'screenSize $screenSizeCache not found in ${breakpoints.values.keys}',
    );
  }

  T? currentValue;
  T? updateMetrics(double size) {
    final currentScreenSize = _getScreenSize(size);
    onChanged?.call(currentScreenSize);

    if (screenSizeCache == currentScreenSize && currentValue != null) {
      return currentValue!;
    }
    screenSizeCache = currentScreenSize;
    final callback = values[screenSizeCache];
    if (callback != null) {
      currentValue = callback;
      return callback;
    }
    final screenSizeEnum = breakpoints.values.keys.toList();
    final index = screenSizeEnum.indexOf(screenSizeCache!);
    final validBuilders = ScreenSize.values.sublist(index);
    for (final e in validBuilders) {
      final callback = values[e];
      if (callback != null) {
        currentValue = callback;
        return callback;
      }
    }

    return values[ScreenSize.mobile];
  }
}

bool isDescendingOrder<T>(Map<T, double> values) {
  double? previousValue;
  for (final value in values.values) {
    if (previousValue != null && value >= previousValue) {
      return false;
    }
    previousValue = value;
  }
  return true;
}
