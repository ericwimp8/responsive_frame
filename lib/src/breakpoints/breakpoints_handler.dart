import 'package:responsive_frame/responsive_frame.dart';

/// A base class for handling breakpoints and providing layout values.
///
/// The [BaseBreakpointsHandler] class serves as a base for handling breakpoints
/// and retrieving layout values associated with different screen sizes. It
/// provides a mechanism to map screen sizes to specific layout values, allowing
/// for responsive adjustments based on the device's screen width.
///
/// This class implements a strategy for determining the appropriate layout
/// value based on the provided screen size, considering breakpoints defined by
/// the [breakpoints] property. It also offers an optional callback function,
/// [onChanged], to notify about changes in the active layout size.
///
/// Subclasses should override the [values] property to define the mapping
/// between layout sizes and their corresponding layout values.
///
/// {@tool snippet}
/// This example shows how to use the [BaseBreakpointsHandler] class to define
/// layout values for different screen sizes.
///
/// ```dart
/// class MyBreakpointsHandler extends BaseBreakpointsHandler<String, LayoutSize> {
///   MyBreakpointsHandler({
///     required super.breakpoints,
///     super.onChanged,
///   });
///
///   @override
///   Map<LayoutSize, String?> get values => {
///         LayoutSize.extraLarge: 'Extra Large',
///         LayoutSize.large: 'Large',
///         LayoutSize.medium: 'Medium',
///         LayoutSize.small: 'Small',
///         LayoutSize.extraSmall: 'Extra Small',
///       };
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [BreakpointsHandler]
///  * [BreakpointsHandlerGranular]
abstract class BaseBreakpointsHandler<T extends Object?, K extends Enum> {
  /// Creates a new [BaseBreakpointsHandler] object.
  ///
  /// The [breakpoints] property defines the breakpoints for different screen
  /// sizes. The optional [onChanged] callback is invoked when the active layout
  /// size changes.
  BaseBreakpointsHandler({required this.breakpoints, this.onChanged});

  /// The optional callback function invoked when the active layout size
  /// changes.
  final void Function(K)? onChanged;

  /// The [Breakpoints] object that defines the breakpoints for different
  /// screen sizes.
  final BaseBreakpoints<K> breakpoints;

  /// The current layout value.
  T? currentValue;

  /// The cached layout size.
  K? layoutSizeCache;

  /// A map defining the mapping between layout sizes and their corresponding
  /// layout values.
  ///
  /// Subclasses should override this property to provide the mapping between
  /// layout sizes and their associated values.
  Map<K, T?> get values;

  /// Returns the layout value associated with the provided screen size.
  ///
  /// This method uses the defined breakpoints to determine the appropriate
  /// layout size based on the given screen size and retrieves the corresponding
  /// layout value from the [values] map. It also manages caching of the layout
  /// size and invokes the optional [onChanged] callback when the active layout
  /// size changes.
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

  /// Returns the layout size based on the given screen size.
  ///
  /// This method uses the defined breakpoints to determine the layout size
  /// based on the provided screen size.
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

/// A class for handling breakpoints and providing layout values for different
/// screen sizes.
///
/// The [BreakpointsHandler] class is used to manage breakpoints and retrieve
/// layout values associated with different screen sizes. It simplifies the process
/// of creating responsive layouts by providing a straightforward way to map screen
/// widths to specific layout values.
///
/// This class extends the [BaseBreakpointsHandler] class and defines the
/// mapping between layout sizes and their corresponding layout values through
/// the [values] property. It offers an optional callback function, [onChanged],
/// to notify about changes in the active layout size.
///
/// {@tool snippet}
/// This example shows how to use the [BreakpointsHandler] class to define
/// layout values for different screen sizes.
///
/// ```dart
/// final handler = BreakpointsHandler<String>(
///   breakpoints: Breakpoints.defaultBreakpoints,
///   extraLarge: 'Extra Large',
///   large: 'Large',
///   medium: 'Medium',
///   small: 'Small',
/// );
///
/// final layoutValue = handler.getLayoutSizeValue(MediaQuery.of(context).size.width);
///
/// print(layoutValue); // Output: 'Extra Large', 'Large', 'Medium', 'Small' based on screen size
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [BaseBreakpointsHandler]
///  * [BreakpointsHandlerGranular]
class BreakpointsHandler<T> extends BaseBreakpointsHandler<T, LayoutSize> {
  /// Creates a new [BreakpointsHandler] object.
  ///
  /// The [breakpoints] property defines the breakpoints for different screen
  /// sizes. The optional [onChanged] callback is invoked when the active layout
  /// size changes. The [extraLarge], [large], [medium], [small], and [extraSmall]
  /// parameters define the layout values for each layout size.
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

  /// The layout value for extra large screens.
  final T? extraLarge;

  /// The layout value for large screens.
  final T? large;

  /// The layout value for medium screens.
  final T? medium;

  /// The layout value for small screens.
  final T? small;

  /// The layout value for extra small screens.
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

/// A class for handling breakpoints and providing layout values for different
/// screen sizes with granular size categories.
///
/// The [BreakpointsHandlerGranular] class is used to manage breakpoints and
/// retrieve layout values associated with different screen sizes, taking into
/// account granular size categories for more precise layout adjustments. It
/// extends the [BaseBreakpointsHandler] class and defines the mapping between
/// layout sizes and their corresponding layout values through the [values]
/// property. It offers an optional callback function, [onChanged], to notify
/// about changes in the active layout size.
///
/// {@tool snippet}
/// This example shows how to use the [BreakpointsHandlerGranular] class to
/// define layout values for different screen sizes with granular size
/// categories.
///
/// ```dart
/// final handler = BreakpointsHandlerGranular<String>(
///   jumboExtraLarge: 'Jumbo Extra Large',
///   jumboLarge: 'Jumbo Large',
///   jumboNormal: 'Jumbo Normal',
///   jumboSmall: 'Jumbo Small',
///   standardExtraLarge: 'Standard Extra Large',
///   standardLarge: 'Standard Large',
///   standardNormal: 'Standard Normal',
///   standardSmall: 'Standard Small',
///   compactExtraLarge: 'Compact Extra Large',
///   compactLarge: 'Compact Large',
///   compactNormal: 'Compact Normal',
///   compactSmall: 'Compact Small',
///   tiny: 'Tiny',
/// );
///
/// final layoutValue = handler.getLayoutSizeValue(MediaQuery.of(context).size.width);
///
/// print(layoutValue); // Output: layout value based on screen size and granular category
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [BaseBreakpointsHandler]
///  * [BreakpointsHandler]
class BreakpointsHandlerGranular<T>
    extends BaseBreakpointsHandler<T, LayoutSizeGranular> {
  /// Creates a new [BreakpointsHandlerGranular] object.
  ///
  /// The optional [onChanged] callback is invoked when the active layout size
  /// changes. The parameters define the layout values for each layout size
  /// category.
  BreakpointsHandlerGranular({
    super.breakpoints = BreakpointsGranular.defaultBreakpoints,
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

  /// The layout value for jumbo extra large screens.
  final T? jumboExtraLarge;

  /// The layout value for jumbo large screens.
  final T? jumboLarge;

  /// The layout value for jumbo normal screens.
  final T? jumboNormal;

  /// The layout value for jumbo small screens.
  final T? jumboSmall;

  /// The layout value for standard extra large screens.
  final T? standardExtraLarge;

  /// The layout value for standard large screens.
  final T? standardLarge;

  /// The layout value for standard normal screens.
  final T? standardNormal;

  /// The layout value for standard small screens.
  final T? standardSmall;

  /// The layout value for compact extra large screens.
  final T? compactExtraLarge;

  /// The layout value for compact large screens.
  final T? compactLarge;

  /// The layout value for compact normal screens.
  final T? compactNormal;

  /// The layout value for compact small screens.
  final T? compactSmall;

  /// The layout value for tiny screens.
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
