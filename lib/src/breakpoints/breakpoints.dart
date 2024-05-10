import 'package:flutter/foundation.dart';

abstract class BaseBreakpoints<T extends Enum> {
  const BaseBreakpoints();
  Map<T, double> get values;
}

@immutable
class Breakpoints implements BaseBreakpoints<LayoutSize> {
  const Breakpoints({
    this.extraLarge = 1200.0,
    this.large = 950.0,
    this.medium = 600.0,
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

  /// Default breakpoint values for standard screen sizes.
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

@immutable
class BreakpointsGranular implements BaseBreakpoints<LayoutSizeGranular> {
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
}

enum LayoutSize {
  extraLarge,
  large,
  medium,
  small,
  extraSmall,
}

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
