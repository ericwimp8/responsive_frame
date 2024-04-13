import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class AnimatedShowHide extends StatelessWidget {
  const AnimatedShowHide({
    required this.child,
    required this.show,
    this.duration = const Duration(milliseconds: 180),
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
    super.key,
  });

  final Duration duration;
  final Widget child;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Axis axis;
  final double axisAlignment;
  final bool show;
  @override
  Widget build(BuildContext context) {
    return FrameAnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      axis: axis,
      axisAlignment: axisAlignment,
      child: show ? child : const SizedBox(),
    );
  }
}
