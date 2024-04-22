import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/breakpoints/base_breakpoints.dart';

class Breakpoints extends BaseBreakpoints<ScreenSize> {
  const Breakpoints({
    super.values = defaultValues,
    super.useShortestSide,
  });

  static const defaultBreakpoints = Breakpoints();

  static const defaultValues = {
    ScreenSize.desktopLarge: 1200.0,
    ScreenSize.desktop: 950.0,
    ScreenSize.tablet: 600.0,
    ScreenSize.mobile: 300.0,
    ScreenSize.watch: 0.0,
  };
}

/// Indicators for screen size at different breakpoints
enum ScreenSize {
  desktopLarge,
  desktop,
  tablet,
  mobile,
  watch,
}
