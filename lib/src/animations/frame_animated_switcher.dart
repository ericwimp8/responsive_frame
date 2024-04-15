import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

// TODO(ericwimp):'remove this'
class FrameAnimatedSwitcher extends StatelessWidget {
  const FrameAnimatedSwitcher({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 180),
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
  });
  final Duration duration;
  final Widget child;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Axis axis;
  final double axisAlignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (child, animation) {
        return SizeFadeTransition(
          axisAlignment: axisAlignment,
          axis: axis,
          animation: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
