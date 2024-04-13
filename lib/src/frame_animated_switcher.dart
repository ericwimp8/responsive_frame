import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class FrameAnimatedSwitcher extends StatelessWidget {
  const FrameAnimatedSwitcher({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 180),
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
    this.axis = Axis.vertical,
  });
  final Duration duration;
  final Widget child;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (child, animation) {
        return SizeFadeTransition(
          axis: axis,
          animation: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
