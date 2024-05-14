import 'package:responsive_frame/responsive_frame.dart';

/// A base class for handling breakpoints.
///
/// Provides a way to manage and listen to breakpoint changes and return a function of a given
/// type T.
///
/// It takes a [breakpoints] object of type [BaseBreakpoints] which defines
/// the breakpoints to be handled. Optionally, you can provide an [onChanged]
/// callback function that will be called whenever the breakpoints change.
///
/// See and prefer using subclasses [BreakpointsHandler] and [BreakpointsHandlerGranular].
///
/// A [BaseBreakpointsHandler] can be created and used in the ephemeral widget tree see [BreakpointsHandler] and [BreakpointsHandlerGranular]
/// for examples.
/// Or it can be passed to [ResponsiveData] via the [ResponsiveDataChangeNotifier] which will make it
/// avaiable via the widget tree using [ResponsiveData.handlerOf] or `ResponsiveData.of(context).handlers` function .
/// See and prefer [BreakpointData] and [ResponsiveFrameLayout] or [BreakpointDataGranular] and [ResponsiveFrameLayoutGranular].
abstract class BaseBreakpointsHandler<T extends Object?, K extends Enum> {
  BaseBreakpointsHandler({required this.breakpoints, this.onChanged});
  final void Function(K)? onChanged;
  final BaseBreakpoints<K> breakpoints;
  T? currentValue;
  K? layoutSizeCache;
  Map<K, T?> get values;

  /// Finds the callback associated with the current layout size. If there is no callback it finds the next smallest callback that is not null.
  /// If all small callbacks are null finds the nearest larger callback that is not null.
  T getLayoutSizeValue(double size) {
    assert(size >= 0, 'Size must be greater than or equal to 0.');

    // get the current layout size based on the provided size.
    final currentLayoutSize = getScreenSize(size);
    // call an optional callback function with the current layout size.
    onChanged?.call(currentLayoutSize);
    // return currentValue if there is no need to update the layout size cache
    if (layoutSizeCache == currentLayoutSize && currentValue != null) {
      return currentValue!;
    }
    // update the layout size cache
    layoutSizeCache = currentLayoutSize;

    // get the callback associated with the current layout size
    var callback = values[layoutSizeCache];
    // return the callback if it is not null and update the currentValue
    if (callback != null) {
      currentValue = callback;
      return callback;
    }

    // determine the index of the current layout size in the breakpoints values
    final index = breakpoints.values.keys.toList().indexOf(layoutSizeCache!);
    final validCallbacks = values.values.toList().sublist(index);
    // get the nest smallest callback that is not null and return it
    callback = validCallbacks.firstWhere(
      (element) => element != null,
      orElse: () => null,
    );

    if (callback != null) {
      currentValue = callback;
      return callback;
    }

    // get the nearest larger callback that is not null and return it
    callback = values.values.lastWhere((element) => element != null);
    currentValue = callback;
    return callback!;
  }

  /// Retrieves the screen size key corresponding to the given [size] parameter.
  /// if the size is -1 it will return the smallest screen size.
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
