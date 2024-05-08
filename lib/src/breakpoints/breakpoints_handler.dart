import 'package:flutter/foundation.dart';
import 'package:responsive_frame/responsive_frame.dart';

abstract class BaseBreakpointsHandler<T extends Object?, K extends Enum> {
  const BaseBreakpointsHandler();
  Map<K, T?> get values;
}

class BreakpointsHandler<T> implements BaseBreakpointsHandler<T, LayoutSize> {
  BreakpointsHandler({
    required this.breakpoints,
    this.onChanged,
    this.extraLarge,
    this.large,
    this.medium,
    this.small,
    this.extraSmall,
  }) : assert(
          extraLarge != null ||
              large != null ||
              medium != null ||
              small != null ||
              extraSmall != null,
          'At least one argument must be supplied',
        );

  final ValueChanged<LayoutSize>? onChanged;
  final Breakpoints breakpoints;
  final T? extraLarge;
  final T? large;
  final T? medium;
  final T? small;
  final T? extraSmall;
  LayoutSize? layoutSizeCache;

  @override
  Map<LayoutSize, T?> get values => {
        LayoutSize.extraLarge: extraLarge,
        LayoutSize.large: large,
        LayoutSize.medium: medium,
        LayoutSize.small: small,
        LayoutSize.extraSmall: extraSmall,
      };

  LayoutSize getScreenSize(double size) {
    for (final entry in breakpoints.values.entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }

    throw FlutterError(
      'screenSize $layoutSizeCache not found in ${values.keys}',
    );
  }

  T? currentValue;
  T getLayoutSizeValue(double size) {
    final currentScreenSize = getScreenSize(size);
    onChanged?.call(currentScreenSize);

    if (layoutSizeCache == currentScreenSize && currentValue != null) {
      return currentValue!;
    }
    layoutSizeCache = currentScreenSize;
    var callback = values[layoutSizeCache];
    if (callback != null) {
      currentValue = callback;
      return callback;
    }
    final screenSizeEnum = breakpoints.values.keys.toList();
    final index = screenSizeEnum.indexOf(layoutSizeCache!);
    final validBuilders = LayoutSize.values.sublist(index);
    for (final e in validBuilders) {
      final _callback = values[e];
      if (_callback != null) {
        currentValue = callback;
        callback = _callback;
      }
    }

    return callback!;
  }
}

class BreakpointsHandlerGranular<T>
    implements BaseBreakpointsHandler<T, LayoutSizeGranular> {
  BreakpointsHandlerGranular({
    required this.breakpoints,
    this.onChanged,
    this.jumboExtraLarge,
    this.jumboLarge,
    this.jumboNormal,
    this.jumboSmall,
    this.standardExtraLarge,
    this.standardLarge,
    this.standardNormal,
    this.standardSmall,
    this.compactExtraLarge,
    this.compactLarge,
    this.compactNormal,
    this.compactSmall,
    this.tiny,
  }) : assert(
          jumboExtraLarge != null ||
              jumboLarge != null ||
              jumboNormal != null ||
              jumboSmall != null ||
              standardExtraLarge != null ||
              standardLarge != null ||
              standardNormal != null ||
              standardSmall != null ||
              compactExtraLarge != null ||
              compactLarge != null ||
              compactNormal != null ||
              compactSmall != null ||
              tiny != null,
          'BreakpointsHandlergranular requires at least one of the size arguments to be filled out',
        );

  final ValueChanged<LayoutSizeGranular>? onChanged;
  final BreakpointsGranular breakpoints;
  final T? jumboExtraLarge;
  final T? jumboLarge;
  final T? jumboNormal;
  final T? jumboSmall;
  final T? standardExtraLarge;
  final T? standardLarge;
  final T? standardNormal;
  final T? standardSmall;
  final T? compactExtraLarge;
  final T? compactLarge;
  final T? compactNormal;
  final T? compactSmall;
  final T? tiny;

  LayoutSizeGranular? layoutSizeCache;

  @override
  Map<LayoutSizeGranular, T?> get values => {
        LayoutSizeGranular.jumboExtraLarge: jumboExtraLarge,
        LayoutSizeGranular.jumboLarge: jumboLarge,
        LayoutSizeGranular.jumboNormal: jumboNormal,
        LayoutSizeGranular.jumboSmall: jumboSmall,
        LayoutSizeGranular.standardExtraLarge: standardExtraLarge,
        LayoutSizeGranular.standardLarge: standardLarge,
        LayoutSizeGranular.standardNormal: standardNormal,
        LayoutSizeGranular.standardSmall: standardSmall,
        LayoutSizeGranular.compactExtraLarge: compactExtraLarge,
        LayoutSizeGranular.compactLarge: compactLarge,
        LayoutSizeGranular.compactNormal: compactNormal,
        LayoutSizeGranular.compactSmall: compactSmall,
        LayoutSizeGranular.tiny: tiny,
      };

  LayoutSizeGranular getScreenSize(double size) {
    for (final entry in breakpoints.values.entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }

    throw FlutterError(
      'screenSize $layoutSizeCache not found in ${values.keys}',
    );
  }

  T? currentValue;
  T getLayoutSizeValue(double size) {
    final currentScreenSize = getScreenSize(size);
    onChanged?.call(currentScreenSize);

    if (layoutSizeCache == currentScreenSize && currentValue != null) {
      return currentValue!;
    }
    layoutSizeCache = currentScreenSize;
    var callback = values[layoutSizeCache];
    if (callback != null) {
      currentValue = callback;
      return callback;
    }
    final screenSizeEnum = breakpoints.values.keys.toList();
    final index = screenSizeEnum.indexOf(layoutSizeCache!);
    final validBuilders = LayoutSizeGranular.values.sublist(index);
    for (final e in validBuilders) {
      final _callback = values[e];
      if (_callback != null) {
        currentValue = callback;
        callback = _callback;
      }
    }

    return callback!;
  }
}
