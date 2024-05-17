import 'package:flutter/foundation.dart';

/// A base class representing breakpoints for different screen sizes.
///
/// This abstract class `BaseBreakpoints` defines the structure for breakpoints
/// with `T` representing an `Enum` type. It provides a method `values`
/// that returns a map of type `T` to `double`, where the key represents a
/// screen size and the value represents the breakpoint value for that size.
abstract class BaseBreakpoints<T extends Enum> {
  const BaseBreakpoints();

  /// Returns a map of type `T` to `double` representing the breakpoints for different screen sizes.
  Map<T, double> get values;
}

/// Represents the breakpoints for different screen sizes based on layout sizes.
///
/// The `Breakpoints` class implements [BaseBreakpoints] with [LayoutSize] as the generic type.
@immutable
class Breakpoints implements BaseBreakpoints<LayoutSize> {
  const Breakpoints({
    /// The breakpoint value for extra large screens.
    ///
    /// Defaults to `1200.0`.
    this.extraLarge = 1200.0,

    /// The breakpoint value for large screens.
    ///
    /// Defaults to `950.0`.
    this.large = 950.0,

    /// The breakpoint value for medium screens.
    ///
    /// Defaults to `600.0`.
    this.medium = 600.0,

    /// The breakpoint value for small screens.
    ///
    /// Defaults to `300.0`.
    this.small = 300.0,
  }) : assert(
          extraLarge > large && large > medium && medium > small && small >= 0,
          'Breakpoints must be in decending order and larger than or equal to 0.',
        );
  final double extraLarge;
  final double large;
  final double medium;
  final double small;

  /// Default instance of [Breakpoints] for standard screen size breakpoints.
  static const defaultBreakpoints = Breakpoints();

  /// Default breakpoint values mapped to correspoding [LayoutSize] value for reference.
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

/// Represents the breakpoints for different screen sizes based on granular layout sizes.
///
/// The `BreakpointsGranular` class implements [BaseBreakpoints] with [LayoutSizeGranular] as the generic type.
@immutable
class BreakpointsGranular implements BaseBreakpoints<LayoutSizeGranular> {
  const BreakpointsGranular({
    /// The breakpoint value for jumbo extra large screens.
    ///
    /// Defaults to `4096.0`.
    this.jumboExtraLarge = 4096.0,

    /// The breakpoint value for jumbo large screens.
    ///
    /// Defaults to `3840.0`.
    this.jumboLarge = 3840.0,

    /// The breakpoint value for jumbo normal screens.
    ///
    /// Defaults to `2560.0`.
    this.jumboNormal = 2560.0,

    /// The breakpoint value for jumbo small screens.
    ///
    /// Defaults to `1920.0`.
    this.jumboSmall = 1920.0,

    /// The breakpoint value for standard extra large screens.
    ///
    /// Defaults to `1280.0`.
    this.standardExtraLarge = 1280.0,

    /// The breakpoint value for standard large screens.
    ///
    /// Defaults to `1024.0`.
    this.standardLarge = 1024.0,

    /// The breakpoint value for standard normal screens.
    ///
    /// Defaults to `768.0`.
    this.standardNormal = 768.0,

    /// The breakpoint value for standard small screens.
    ///
    /// Defaults to `568.0`.
    this.standardSmall = 568.0,

    /// The breakpoint value for compact extra large screens.
    ///
    /// Defaults to `480.0`.
    this.compactExtraLarge = 480.0,

    /// The breakpoint value for compact large screens.
    ///
    /// Defaults to `430.0`.
    this.compactLarge = 430.0,

    /// The breakpoint value for compact normal screens.
    ///
    /// Defaults to `360.0`.
    this.compactNormal = 360.0,

    /// The breakpoint value for compact small screens.
    ///
    /// Defaults to `300.0`.
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
  final double jumboExtraLarge;
  final double jumboLarge;
  final double jumboNormal;
  final double jumboSmall;
  final double standardExtraLarge;
  final double standardLarge;
  final double standardNormal;
  final double standardSmall;
  final double compactExtraLarge;
  final double compactLarge;
  final double compactNormal;
  final double compactSmall;

  /// Default instance of [BreakpointsGranular] for standard screen size breakpoints.
  static const defaultBreakpoints = BreakpointsGranular();

  /// Default breakpoint values mapped to correspoding [LayoutSizeGranular] value for reference.
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

/// Enum representing different layout sizes.
enum LayoutSize {
  extraLarge,
  large,
  medium,
  small,
  extraSmall,
}

/// Enum representing different layout sizes with granular control.
enum LayoutSizeGranular {
  jumboExtraLarge,
  jumboLarge,
  jumboNormal,
  jumboSmall,
  standardExtraLarge,
  standardLarge,
  standardNormal,
  standardSmall,
  compactExtraLarge,
  compactLarge,
  compactNormal,
  compactSmall,
  tiny,
}
