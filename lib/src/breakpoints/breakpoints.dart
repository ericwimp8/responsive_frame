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
    this.extraSmall = 0.0,
  });
  final double extraLarge;
  final double large;
  final double medium;
  final double small;
  final double extraSmall;

  /// Default instance of [Breakpoints] for standard screen size breakpoints.
  static const defaultBreakpoints = Breakpoints();

  /// Default breakpoint values for standard screen sizes.
  @override
  Map<LayoutSize, double> get values => {
        LayoutSize.extraLarge: extraLarge,
        LayoutSize.large: large,
        LayoutSize.medium: medium,
        LayoutSize.small: small,
        LayoutSize.extraSmall: extraSmall,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breakpoints &&
        other.extraLarge == extraLarge &&
        other.large == large &&
        other.medium == medium &&
        other.small == small &&
        other.extraSmall == extraSmall;
  }

  @override
  int get hashCode {
    return extraLarge.hashCode ^
        large.hashCode ^
        medium.hashCode ^
        small.hashCode ^
        extraSmall.hashCode;
  }

  @override
  String toString() {
    return 'Breakpoints(extraLarge: $extraLarge, large: $large, medium: $medium, small: $small, extraSmall: $extraSmall)';
  }
}

@immutable
class BreakpointsGranular implements BaseBreakpoints<LayoutSizeGranular> {
  const BreakpointsGranular({
    this.jumboExtraLarge = 4096.0,
    this.jumboLarge = 3840.0,
    this.jumboNormal = 2560.0,
    this.jumboSmall = 1920.0,
    this.standarExtraLarge = 1280.0,
    this.standarLarge = 1024.0,
    this.standarNormal = 768.0,
    this.standarSmall = 568.0,
    this.compactExtraLarge = 480.0,
    this.compactLarge = 420.0,
    this.compactNormal = 360.0,
    this.compactSmall = 320.0,
    this.tiny = 0.0,
  });
  final double jumboExtraLarge;
  final double jumboLarge;
  final double jumboNormal;
  final double jumboSmall;
  final double standarExtraLarge;
  final double standarLarge;
  final double standarNormal;
  final double standarSmall;
  final double compactExtraLarge;
  final double compactLarge;
  final double compactNormal;
  final double compactSmall;
  final double tiny;

  static const defaultBreakpoints = BreakpointsGranular();

  @override
  Map<LayoutSizeGranular, double> get values => {
        LayoutSizeGranular.jumboExtraLarge: jumboExtraLarge,
        LayoutSizeGranular.jumboLarge: jumboLarge,
        LayoutSizeGranular.jumboNormal: jumboNormal,
        LayoutSizeGranular.jumboSmall: jumboSmall,
        LayoutSizeGranular.standardExtraLarge: standarExtraLarge,
        LayoutSizeGranular.standardLarge: standarLarge,
        LayoutSizeGranular.standardNormal: standarNormal,
        LayoutSizeGranular.standardSmall: standarSmall,
        LayoutSizeGranular.compactExtraLarge: compactExtraLarge,
        LayoutSizeGranular.compactLarge: compactLarge,
        LayoutSizeGranular.compactNormal: compactNormal,
        LayoutSizeGranular.compactSmall: compactSmall,
        LayoutSizeGranular.tiny: tiny,
      };

  @override
  String toString() {
    return 'BreakpointsGranular(jumboExtraLarge: $jumboExtraLarge, jumboLarge: $jumboLarge, jumboNormal: $jumboNormal, jumboSmall: $jumboSmall, standarExtraLarge: $standarExtraLarge, standarLarge: $standarLarge, standarNormal: $standarNormal, standarSmall: $standarSmall, compactExtraLarge: $compactExtraLarge, compactLarge: $compactLarge, compactNormal: $compactNormal, compactSmall: $compactSmall, tiny: $tiny)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BreakpointsGranular &&
        other.jumboExtraLarge == jumboExtraLarge &&
        other.jumboLarge == jumboLarge &&
        other.jumboNormal == jumboNormal &&
        other.jumboSmall == jumboSmall &&
        other.standarExtraLarge == standarExtraLarge &&
        other.standarLarge == standarLarge &&
        other.standarNormal == standarNormal &&
        other.standarSmall == standarSmall &&
        other.compactExtraLarge == compactExtraLarge &&
        other.compactLarge == compactLarge &&
        other.compactNormal == compactNormal &&
        other.compactSmall == compactSmall &&
        other.tiny == tiny;
  }

  @override
  int get hashCode {
    return jumboExtraLarge.hashCode ^
        jumboLarge.hashCode ^
        jumboNormal.hashCode ^
        jumboSmall.hashCode ^
        standarExtraLarge.hashCode ^
        standarLarge.hashCode ^
        standarNormal.hashCode ^
        standarSmall.hashCode ^
        compactExtraLarge.hashCode ^
        compactLarge.hashCode ^
        compactNormal.hashCode ^
        compactSmall.hashCode ^
        tiny.hashCode;
  }
}

/// Enumerates granular screen size types for more detailed breakpoint handling.
enum ScreenSizeGranular {
  desktopExtraLarge,
  desktopLarge,
  desktopNormal,
  desktopSmall,
  tabletExtraLarge,
  tabletLarge,
  tabletNormal,
  tabletSmall,
  mobileExtraLarge,
  mobileLarge,
  mobileNormal,
  mobileSmall,
  watch,
}

/// Enumerates standard screen size types for basic breakpoint handling.
// enum ScreenSize {
//   desktopLarge,
//   desktop,
//   tablet,
//   mobile,
//   watch,
// }

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
