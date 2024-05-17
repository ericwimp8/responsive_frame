import 'package:flutter/foundation.dart';

/// A base class for breakpoints.
///
/// The [BaseBreakpoints] class defines the interface for breakpoints. Breakpoints
/// are used to determine the layout of a widget based on the screen size.
///
/// The [values] property is a map that defines the breakpoints for each layout
/// size. The keys of the map are the layout sizes, and the values are the
/// corresponding breakpoints.
///
/// {@tool snippet}
/// This example shows how to use the [BaseBreakpoints] class to define
/// breakpoints for a widget.
///
/// ```dart
/// class MyBreakpoints extends BaseBreakpoints<LayoutSize> {
///   const MyBreakpoints({
///     this.extraLarge = 1200.0,
///     this.large = 950.0,
///     this.medium = 600.0,
///     this.small = 300.0,
///   }) : assert(
///           extraLarge > large && large > medium && medium > small && small >= 0,
///           'Breakpoints must be in decending order and larger than or equal to 0.',
///         );
///   final double extraLarge;
///   final double large;
///   final double medium;
///   final double small;
///
///   @override
///   Map<LayoutSize, double> get values => {
///         LayoutSize.extraLarge: extraLarge,
///         LayoutSize.large: large,
///         LayoutSize.medium: medium,
///         LayoutSize.small: small,
///         LayoutSize.extraSmall: -1,
///       };
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Breakpoints]
///  * [BreakpointsGranular]
///  * [LayoutSize]
abstract class BaseBreakpoints<T extends Enum> {
  /// Creates a new [BaseBreakpoints] object.
  const BaseBreakpoints();

  /// A map that defines the breakpoints for each layout size.
  Map<T, double> get values;
}

/// A class that defines breakpoints for responsive layouts.
///
/// The [Breakpoints] class defines breakpoints for responsive layouts.
/// Breakpoints are used to determine the layout of a widget based on the screen
/// size. The [Breakpoints] class defines four breakpoints:
///
///  * **extraLarge:** For screens larger than 1200 pixels wide.
///  * **large:** For screens larger than 950 pixels wide but smaller than or
///    equal to 1200 pixels wide.
///  * **medium:** For screens larger than 600 pixels wide but smaller than or
///    equal to 950 pixels wide.
///  * **small:** For screens smaller than or equal to 600 pixels wide.
///
/// You can create a custom [Breakpoints] object with different breakpoints using
/// the constructor.
///
/// {@tool snippet}
/// This example shows how to create a custom [Breakpoints] object with
/// different breakpoints.
///
/// ```dart
/// final breakpoints = Breakpoints(
///   extraLarge: 1400,
///   large: 1000,
///   medium: 700,
///   small: 400,
/// );
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [BaseBreakpoints]
///  * [BreakpointsGranular]
@immutable
class Breakpoints implements BaseBreakpoints<LayoutSize> {
  /// Creates a new [Breakpoints] object.
  ///
  /// The [extraLarge], [large], [medium], and [small] parameters define the
  /// breakpoints for each layout size.
  const Breakpoints({
    this.extraLarge = 1200.0,
    this.large = 950.0,
    this.medium = 600.0,
    this.small = 300.0,
  }) : assert(
          extraLarge > large && large > medium && medium > small && small >= 0,
          'Breakpoints must be in decending order and larger than or equal to 0.',
        );

  /// The breakpoint for extra large screens.
  final double extraLarge;

  /// The breakpoint for large screens.
  final double large;

  /// The breakpoint for medium screens.
  final double medium;

  /// The breakpoint for small screens.
  final double small;

  /// The default breakpoints for responsive layouts.
  static const defaultBreakpoints = Breakpoints();

  @override
  Map<LayoutSize, double> get values => {
        LayoutSize.extraLarge: extraLarge,
        LayoutSize.large: large,
        LayoutSize.medium: medium,
        LayoutSize.small: small,
        LayoutSize.extraSmall: -1,
      };

  @override
  String toString() {
    return 'Breakpoints(extraLarge: $extraLarge, large: $large, medium: $medium, small: $small)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breakpoints &&
        other.extraLarge == extraLarge &&
        other.large == large &&
        other.medium == medium &&
        other.small == small;
  }

  @override
  int get hashCode {
    return extraLarge.hashCode ^
        large.hashCode ^
        medium.hashCode ^
        small.hashCode;
  }

  /// Creates a copy of this [Breakpoints] object with the given properties
  /// replaced.
  ///
  /// The [extraLarge], [large], [medium], and [small] parameters can be used
  /// to replace the corresponding properties of this object.
  Breakpoints copyWith({
    double? extraLarge,
    double? large,
    double? medium,
    double? small,
  }) {
    return Breakpoints(
      extraLarge: extraLarge ?? this.extraLarge,
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
    );
  }
}

/// A class that defines breakpoints for responsive layouts with granular
/// size categories.
///
/// The [BreakpointsGranular] class defines breakpoints for responsive layouts
/// with granular size categories, providing more precise control over layout
/// adjustments at different screen sizes. It offers 11 breakpoints, categorized
/// into "jumbo," "standard," and "compact" size groups, along with a "tiny"
/// category for extremely small screens.
///
/// The breakpoints are:
///
///  * **jumboExtraLarge:** For screens larger than 4096 pixels wide.
///  * **jumboLarge:** For screens larger than 3840 pixels wide but smaller than
///    or equal to 4096 pixels wide.
///  * **jumboNormal:** For screens larger than 2560 pixels wide but smaller
///    than or equal to 3840 pixels wide.
///  * **jumboSmall:** For screens larger than 1920 pixels wide but smaller
///    than or equal to 2560 pixels wide.
///  * **standardExtraLarge:** For screens larger than 1280 pixels wide but
///    smaller than or equal to 1920 pixels wide.
///  * **standardLarge:** For screens larger than 1024 pixels wide but smaller
///    than or equal to 1280 pixels wide.
///  * **standardNormal:** For screens larger than 768 pixels wide but smaller
///    than or equal to 1024 pixels wide.
///  * **standardSmall:** For screens larger than 568 pixels wide but smaller
///    than or equal to 768 pixels wide.
///  * **compactExtraLarge:** For screens larger than 480 pixels wide but smaller
///    than or equal to 568 pixels wide.
///  * **compactLarge:** For screens larger than 430 pixels wide but smaller than
///    or equal to 480 pixels wide.
///  * **compactNormal:** For screens larger than 360 pixels wide but smaller
///    than or equal to 430 pixels wide.
///  * **compactSmall:** For screens larger than 300 pixels wide but smaller than
///    or equal to 360 pixels wide.
///  * **tiny:** For screens smaller than or equal to 300 pixels wide.
///
/// You can create a custom [BreakpointsGranular] object with different breakpoints
/// using the constructor.
///
/// {@tool snippet}
/// This example shows how to create a custom [BreakpointsGranular] object with
/// different breakpoints.
///
/// ```dart
/// final breakpoints = BreakpointsGranular(
///   jumboExtraLarge: 4500,
///   jumboLarge: 4000,
///   jumboNormal: 3000,
///   jumboSmall: 2500,
///   standardExtraLarge: 1500,
///   standardLarge: 1200,
///   standardNormal: 900,
///   standardSmall: 700,
///   compactExtraLarge: 500,
///   compactLarge: 450,
///   compactNormal: 400,
///   compactSmall: 350,
/// );
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [BaseBreakpoints]
///  * [Breakpoints]
@immutable
class BreakpointsGranular implements BaseBreakpoints<LayoutSizeGranular> {
  /// Creates a new [BreakpointsGranular] object.
  ///
  /// The parameters define the breakpoints for each layout size category.
  const BreakpointsGranular({
    this.jumboExtraLarge = 4096.0,
    this.jumboLarge = 3840.0,
    this.jumboNormal = 2560.0,
    this.jumboSmall = 1920.0,
    this.standardExtraLarge = 1280.0,
    this.standardLarge = 1024.0,
    this.standardNormal = 768.0,
    this.standardSmall = 568.0,
    this.compactExtraLarge = 480.0,
    this.compactLarge = 430.0,
    this.compactNormal = 360.0,
    this.compactSmall = 300.0,
  }) : assert(
          jumboExtraLarge > jumboLarge &&
              jumboLarge > jumboNormal &&
              jumboNormal > jumboSmall &&
              jumboSmall > standardExtraLarge &&
              standardExtraLarge > standardLarge &&
              standardLarge > standardNormal &&
              standardNormal > standardSmall &&
              standardSmall > compactExtraLarge &&
              compactExtraLarge > compactLarge &&
              compactLarge > compactNormal &&
              compactNormal > compactSmall &&
              compactSmall >= 0,
          'Breakpoints must be in decending order and larger than or equal to 0',
        );

  /// The breakpoint for jumbo extra large screens.
  final double jumboExtraLarge;

  /// The breakpoint for jumbo large screens.
  final double jumboLarge;

  /// The breakpoint for jumbo normal screens.
  final double jumboNormal;

  /// The breakpoint for jumbo small screens.
  final double jumboSmall;

  /// The breakpoint for standard extra large screens.
  final double standardExtraLarge;

  /// The breakpoint for standard large screens.
  final double standardLarge;

  /// The breakpoint for standard normal screens.
  final double standardNormal;

  /// The breakpoint for standard small screens.
  final double standardSmall;

  /// The breakpoint for compact extra large screens.
  final double compactExtraLarge;

  /// The breakpoint for compact large screens.
  final double compactLarge;

  /// The breakpoint for compact normal screens.
  final double compactNormal;

  /// The breakpoint for compact small screens.
  final double compactSmall;

  /// The default breakpoints for responsive layouts with granular size
  /// categories.
  static const defaultBreakpoints = BreakpointsGranular();

  @override
  Map<LayoutSizeGranular, double> get values => {
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
        LayoutSizeGranular.tiny: -1,
      };

  /// Creates a copy of this [BreakpointsGranular] object with the given
  /// properties replaced.
  ///
  /// The parameters can be used to replace the corresponding properties of this
  /// object.
  BreakpointsGranular copyWith({
    double? jumboExtraLarge,
    double? jumboLarge,
    double? jumboNormal,
    double? jumboSmall,
    double? standardExtraLarge,
    double? standardLarge,
    double? standardNormal,
    double? standardSmall,
    double? compactExtraLarge,
    double? compactLarge,
    double? compactNormal,
    double? compactSmall,
  }) {
    return BreakpointsGranular(
      jumboExtraLarge: jumboExtraLarge ?? this.jumboExtraLarge,
      jumboLarge: jumboLarge ?? this.jumboLarge,
      jumboNormal: jumboNormal ?? this.jumboNormal,
      jumboSmall: jumboSmall ?? this.jumboSmall,
      standardExtraLarge: standardExtraLarge ?? this.standardExtraLarge,
      standardLarge: standardLarge ?? this.standardLarge,
      standardNormal: standardNormal ?? this.standardNormal,
      standardSmall: standardSmall ?? this.standardSmall,
      compactExtraLarge: compactExtraLarge ?? this.compactExtraLarge,
      compactLarge: compactLarge ?? this.compactLarge,
      compactNormal: compactNormal ?? this.compactNormal,
      compactSmall: compactSmall ?? this.compactSmall,
    );
  }

  @override
  String toString() {
    return 'BreakpointsGranular(jumboExtraLarge: $jumboExtraLarge, jumboLarge: $jumboLarge, jumboNormal: $jumboNormal, jumboSmall: $jumboSmall, standardExtraLarge: $standardExtraLarge, standardLarge: $standardLarge, standardNormal: $standardNormal, standardSmall: $standardSmall, compactExtraLarge: $compactExtraLarge, compactLarge: $compactLarge, compactNormal: $compactNormal, compactSmall: $compactSmall)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BreakpointsGranular &&
        other.jumboExtraLarge == jumboExtraLarge &&
        other.jumboLarge == jumboLarge &&
        other.jumboNormal == jumboNormal &&
        other.jumboSmall == jumboSmall &&
        other.standardExtraLarge == standardExtraLarge &&
        other.standardLarge == standardLarge &&
        other.standardNormal == standardNormal &&
        other.standardSmall == standardSmall &&
        other.compactExtraLarge == compactExtraLarge &&
        other.compactLarge == compactLarge &&
        other.compactNormal == compactNormal &&
        other.compactSmall == compactSmall;
  }

  @override
  int get hashCode {
    return jumboExtraLarge.hashCode ^
        jumboLarge.hashCode ^
        jumboNormal.hashCode ^
        jumboSmall.hashCode ^
        standardExtraLarge.hashCode ^
        standardLarge.hashCode ^
        standardNormal.hashCode ^
        standardSmall.hashCode ^
        compactExtraLarge.hashCode ^
        compactLarge.hashCode ^
        compactNormal.hashCode ^
        compactSmall.hashCode;
  }
}

/// An enum representing different layout sizes.
///
/// The [LayoutSize] enum defines five layout sizes:
///
///  * **extraLarge:** For screens larger than 1200 pixels wide.
///  * **large:** For screens larger than 950 pixels wide but smaller than or
///    equal to 1200 pixels wide.
///  * **medium:** For screens larger than 600 pixels wide but smaller than or
///    equal to 950 pixels wide.
///  * **small:** For screens smaller than or equal to 600 pixels wide.
///  * **extraSmall:** For screens smaller than or equal to 300 pixels wide.
///
/// These layout sizes are used by the [Breakpoints] class to determine the
/// layout of a widget based on the screen size.
///
/// See also:
///
///  * [Breakpoints]
///  * [BreakpointsGranular]
enum LayoutSize {
  /// For screens larger than 1200 pixels wide.
  extraLarge,

  /// For screens larger than 950 pixels wide but smaller than or equal to
  /// 1200 pixels wide.
  large,

  /// For screens larger than 600 pixels wide but smaller than or equal to
  /// 950 pixels wide.
  medium,

  /// For screens smaller than or equal to 600 pixels wide.
  small,

  /// For screens smaller than or equal to 300 pixels wide.
  extraSmall,
}

/// An enum representing different layout sizes with granular size categories.
///
/// The [LayoutSizeGranular] enum defines 12 layout sizes with granular size
/// categories, providing more precise control over layout adjustments at
/// different screen sizes. The categories are:
///
///  * **jumbo:** For screens with a large display area, often used for
///    desktops or large tablets.
///  * **standard:** For screens with a standard display area, commonly found
///    on laptops or smaller tablets.
///  * **compact:** For screens with a smaller display area, typical of mobile
///    devices.
///  * **tiny:** For screens with an extremely small display area, often found
///    on very old or specialized devices.
///
/// Within each category, there are multiple sizes, allowing for even finer
/// granularity in layout adjustments.
///
/// This enum is used by the [BreakpointsGranular] class to define breakpoints
/// for responsive layouts with granular size categories.
///
/// See also:
///
///  * [BreakpointsGranular]
///  * [Breakpoints]
enum LayoutSizeGranular {
  /// For screens larger than 4096 pixels wide.
  jumboExtraLarge,

  /// For screens larger than 3840 pixels wide but smaller than or equal to
  /// 4096 pixels wide.
  jumboLarge,

  /// For screens larger than 2560 pixels wide but smaller than or equal to
  /// 3840 pixels wide.
  jumboNormal,

  /// For screens larger than 1920 pixels wide but smaller than or equal to
  /// 2560 pixels wide.
  jumboSmall,

  /// For screens larger than 1280 pixels wide but smaller than or equal to
  /// 1920 pixels wide.
  standardExtraLarge,

  /// For screens larger than 1024 pixels wide but smaller than or equal to
  /// 1280 pixels wide.
  standardLarge,

  /// For screens larger than 768 pixels wide but smaller than or equal to
  /// 1024 pixels wide.
  standardNormal,

  /// For screens larger than 568 pixels wide but smaller than or equal to
  /// 768 pixels wide.
  standardSmall,

  /// For screens larger than 480 pixels wide but smaller than or equal to
  /// 568 pixels wide.
  compactExtraLarge,

  /// For screens larger than 430 pixels wide but smaller than or equal to
  /// 480 pixels wide.
  compactLarge,

  /// For screens larger than 360 pixels wide but smaller than or equal to
  /// 430 pixels wide.
  compactNormal,

  /// For screens larger than 300 pixels wide but smaller than or equal to
  /// 360 pixels wide.
  compactSmall,

  /// For screens smaller than or equal to 300 pixels wide.
  tiny,
}
