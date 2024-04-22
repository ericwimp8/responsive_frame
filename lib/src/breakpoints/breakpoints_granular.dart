import 'package:responsive_frame/responsive_frame.dart';

class BreakpointsGranular extends BaseBreakpoints<ScreenSizeGranular> {
  const BreakpointsGranular({
    super.values = defaultValuesGranular,
    super.useShortestSide,
  });

  static const defaultBreakpoints = BreakpointsGranular();

  static const defaultValuesGranular = {
    ScreenSizeGranular.desktopExtraLarge: 4096.0,
    ScreenSizeGranular.desktopLarge: 3840.0,
    ScreenSizeGranular.desktopNormal: 2560.0,
    ScreenSizeGranular.desktopSmall: 1920.0,
    ScreenSizeGranular.tabletExtraLarge: 1280.0,
    ScreenSizeGranular.tabletLarge: 1024.0,
    ScreenSizeGranular.tabletNormal: 768.0,
    ScreenSizeGranular.tabletSmall: 568.0,
    ScreenSizeGranular.mobileExtraLarge: 480.0,
    ScreenSizeGranular.mobileLarge: 420.0,
    ScreenSizeGranular.mobileNormal: 306.0,
    ScreenSizeGranular.mobileSmall: 300.0,
    ScreenSizeGranular.watch: 0.0,
  };
}

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
