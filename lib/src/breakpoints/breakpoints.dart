import 'package:responsive_frame/responsive_frame.dart';

class Breakpoints extends BaseBreakpoints<ScreenSize> {
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

  @override
  Map<ScreenSize, double> get values => {
        ScreenSize.desktopLarge: desktopLarge,
        ScreenSize.desktop: desktop,
        ScreenSize.tablet: tablet,
        ScreenSize.mobile: mobile,
        ScreenSize.watch: 0,
      };

  @override
  double getBreakpointFromWidth(double deviceWidth, {ScreenSize? screenSize}) {
    return values[screenSize ?? getScreenSize(deviceWidth: deviceWidth)]!;
  }

  @override
  double getBreakPointFromScreenSize(ScreenSize screenSize) {
    return values[screenSize]!;
  }

  @override
  ScreenSize getScreenSize({required double deviceWidth}) {
    for (final entry in values.entries) {
      if (deviceWidth >= entry.value) {
        return entry.key;
      }
    }

    return ScreenSize.watch; // Default to the smallest size if none match
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
