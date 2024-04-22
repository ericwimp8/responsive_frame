import 'package:responsive_frame/responsive_frame.dart';

/// Indicators for screen size at different breakpoints
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

/// Granular breakpoints for fined tuned control over layouts
/// Each field represents the values greater than or equal to the given
/// argument and below the next highest argument.
class BreakpointsGranular implements BaseBreakpoints<ScreenSizeGranular> {
  /// Any give break point must be higher that the previous break point
  const BreakpointsGranular({
    this.desktopExtraLarge = 4096,
    this.desktopLarge = 3840,
    this.desktopNormal = 2560,
    this.desktopSmall = 1920,
    this.tabletExtraLarge = 1280,
    this.tabletLarge = 1024,
    this.tabletNormal = 768,
    this.tabletSmall = 568,
    this.mobileExtraLarge = 480,
    this.mobileLarge = 420,
    this.mobileNormal = 360,
    this.mobileSmall = 300,
  })  : assert(
          desktopExtraLarge > desktopLarge,
          'desktopExtraLarge > desktopLarge must be true',
        ),
        assert(
          desktopLarge > desktopNormal,
          'desktopLarge > desktopNormal must be true',
        ),
        assert(
          desktopNormal > desktopSmall,
          'desktopNormal > desktopSmall must be true',
        ),
        assert(
          desktopSmall > tabletExtraLarge,
          'desktopSmall > tabletExtraLarge must be true',
        ),
        assert(
          tabletExtraLarge > tabletLarge,
          'tabletExtraLarge > tabletLarge must be true',
        ),
        assert(
          tabletLarge > tabletNormal,
          'tabletLarge > tabletNormal must be true',
        ),
        assert(
          tabletNormal > tabletSmall,
          'tabletNormal > tabletSmall must be true',
        ),
        assert(
          tabletSmall > mobileExtraLarge,
          'tabletSmall > mobileExtraLarge must be true',
        ),
        assert(
          mobileExtraLarge > mobileLarge,
          'mobileExtraLarge > mobileLarge',
        ),
        assert(
          mobileLarge > mobileNormal,
          'mobileLarge > mobileNormal must be true',
        ),
        assert(
          mobileNormal > mobileSmall,
          'mobileNormal > mobileSmall must be true',
        );

  final double mobileSmall;
  final double mobileNormal;
  final double mobileLarge;
  final double mobileExtraLarge;

  final double tabletSmall;
  final double tabletNormal;
  final double tabletLarge;
  final double tabletExtraLarge;

  final double desktopSmall;
  final double desktopNormal;
  final double desktopLarge;
  final double desktopExtraLarge;

  static const defaultBreakpoints = BreakpointsGranular();

  /// Map that maps [ScreenSizeGranular] to it's [BreakpointsGranular] value
  @override
  Map<ScreenSizeGranular, double> get values => {
        ScreenSizeGranular.desktopExtraLarge: desktopExtraLarge,
        ScreenSizeGranular.desktopLarge: desktopLarge,
        ScreenSizeGranular.desktopNormal: desktopNormal,
        ScreenSizeGranular.desktopSmall: desktopSmall,
        ScreenSizeGranular.tabletExtraLarge: tabletExtraLarge,
        ScreenSizeGranular.tabletLarge: tabletLarge,
        ScreenSizeGranular.tabletNormal: tabletNormal,
        ScreenSizeGranular.tabletSmall: tabletSmall,
        ScreenSizeGranular.mobileExtraLarge: mobileExtraLarge,
        ScreenSizeGranular.mobileLarge: mobileLarge,
        ScreenSizeGranular.mobileNormal: mobileNormal,
        ScreenSizeGranular.mobileSmall: mobileSmall,
        ScreenSizeGranular.watch: 0,
      };

  /// Returns the breakpoint value given a device width
  @override
  double getBreakpointFromWidth(
    double deviceWidth, {
    ScreenSizeGranular? screenSize,
  }) {
    return values[getScreenSize(deviceWidth: deviceWidth)]!;
  }

  /// Returns the [ScreenSizeGranular] given a [deviceWidth]
  @override
  ScreenSizeGranular getScreenSize({required double deviceWidth}) {
    for (final entry in values.entries) {
      if (deviceWidth >= entry.value) {
        return entry.key;
      }
    }

    return ScreenSizeGranular
        .watch; // Default to the smallest size if none match
  }

  @override
  String toString() {
    return 'Desktop: Small - $desktopSmall Normal - $desktopNormal Large - $desktopLarge ExtraLarge - $desktopExtraLarge\nTablet: Small - $tabletSmall Normal - $tabletNormal Large - $tabletLarge ExtraLarge - $tabletExtraLarge\nMobile: Small - $mobileSmall Normal - $mobileNormal Large - $mobileLarge ExtraLarge - $mobileExtraLarge';
  }

  @override
  double getBreakPointFromScreenSize(ScreenSizeGranular screenSize) {
    return values[screenSize]!;
  }
}
