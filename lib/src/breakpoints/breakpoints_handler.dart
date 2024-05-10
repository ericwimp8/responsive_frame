import 'package:responsive_frame/responsive_frame.dart';

abstract class BaseBreakpointsHandler<T extends Object?, K extends Enum> {
  BaseBreakpointsHandler({required this.breakpoints, this.onChanged});
  final void Function(K)? onChanged;
  final BaseBreakpoints<K> breakpoints;
  T? currentValue;
  K? layoutSizeCache;
  Map<K, T?> get values;
  T getLayoutSizeValue(double size) {
    final currentLayoutSize = getScreenSize(size);
    onChanged?.call(currentLayoutSize);

    if (layoutSizeCache == currentLayoutSize && currentValue != null) {
      return currentValue!;
    }
    layoutSizeCache = currentLayoutSize;

    var callback = values[layoutSizeCache];
    if (callback != null) {
      currentValue = callback;
      return callback;
    }

    final index = breakpoints.values.keys.toList().indexOf(layoutSizeCache!);
    final validCallbacks = values.values.toList().sublist(index);
    callback = validCallbacks.firstWhere(
      (element) => element != null,
      orElse: () => null,
    );
    if (callback != null) {
      currentValue = callback;
      return callback;
    }
    callback = values.values.lastWhere((element) => element != null);
    currentValue = callback;
    return callback!;
  }

  K getScreenSize(double size) {
    final entries = breakpoints.values.entries;
    for (final entry in entries) {
      if (size >= entry.value) {
        return entry.key;
      }
    }

    return entries.last.key;
  }
}

class BreakpointsHandler<T> extends BaseBreakpointsHandler<T, LayoutSize> {
  BreakpointsHandler({
    required super.breakpoints,
    super.onChanged,
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
          'BreakpointsHandler requires at least one of the size arguments to be filled out',
        );

  final T? extraLarge;
  final T? large;
  final T? medium;
  final T? small;
  final T? extraSmall;

  @override
  Map<LayoutSize, T?> get values => {
        LayoutSize.extraLarge: extraLarge,
        LayoutSize.large: large,
        LayoutSize.medium: medium,
        LayoutSize.small: small,
        LayoutSize.extraSmall: extraSmall,
      };
}

class BreakpointsHandlerGranular<T>
    extends BaseBreakpointsHandler<T, LayoutSizeGranular> {
  BreakpointsHandlerGranular({
    required super.breakpoints,
    super.onChanged,
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
          'BreakpointsHandlerGranular requires at least one of the size arguments to be filled out',
        );

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
}
