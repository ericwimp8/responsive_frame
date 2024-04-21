/// Each field represents the values greater than or equal to the given
/// argument and below the next highest argument
class Breakpoints {
  const Breakpoints({
    this.desktopLarge = 1200,
    this.desktop = 950,
    this.tablet = 600,
    this.mobile = 300,
  });

  final double desktopLarge;
  final double desktop;
  final double tablet;
  final double mobile;

  static const defaultBreakpoints = Breakpoints();

  /// Map that maps [ScreenSize] to it's [Breakpoints] value
  Map<ScreenSize, double> get values => {
        ScreenSize.desktopLarge: desktopLarge,
        ScreenSize.desktop: desktop,
        ScreenSize.tablet: tablet,
        ScreenSize.mobile: mobile,
        ScreenSize.watch: 0,
      };

  /// Returns the breakpoint value given a device width
  double getBreakpointFromWidth(double deviceWidth, {ScreenSize? screenSize}) {
    return values[screenSize ?? getScreenSize(deviceWidth: deviceWidth)]!;
  }

  /// Returns the breakpoint value for a given [ScreenSize]
  double getBreakPointFromScreenSize(ScreenSize screenSize) {
    return values[screenSize]!;
  }

  /// Returns the [ScreenSize] given a [deviceWidth]
  ScreenSize getScreenSize({required double deviceWidth}) {
    if (deviceWidth >= desktopLarge) return ScreenSize.desktopLarge;
    if (deviceWidth >= desktop) return ScreenSize.desktop;
    if (deviceWidth >= tablet) return ScreenSize.tablet;
    if (deviceWidth >= mobile) return ScreenSize.mobile;
    return ScreenSize.watch;
  }

  @override
  String toString() {
    return 'Breakpoints(desktopLarge: $desktopLarge, desktop: $desktop, tablet: $tablet, mobile: $mobile)';
  }
}

/// Indicators for screen size at different breakpoints
enum ScreenSize {
  desktopLarge,
  desktop,
  tablet,
  mobile,
  watch,
}
