abstract class BaseBreakpoints<T> {
  const BaseBreakpoints();

  Map<T, double> get values;

  double getBreakpointFromWidth(double deviceWidth, {T screenSize});

  double getBreakPointFromScreenSize(T screenSize);

  dynamic getScreenSize({required double deviceWidth});

  @override
  String toString();
}
