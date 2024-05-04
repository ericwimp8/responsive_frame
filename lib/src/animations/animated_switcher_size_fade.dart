import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

class AnimatedSwitcherSizeFade extends StatelessWidget {
  const AnimatedSwitcherSizeFade({
    required this.child,
    super.key,
    this.duration = kDefaultAnimationDuration,
    this.reverseDuration = kDefaultAnimationDuration,
    this.sizeAxis = Axis.vertical,
    this.fadeBegin = kDefaultAnimationBeign,
    this.fadeEnd = kDefaultAnimationEnd,
    this.fadeCurve = kDefaultAnimationCurve,
    this.sizeBegin = kDefaultAnimationBeign,
    this.sizeEnd = kDefaultAnimationEnd,
    this.sizeCurve = kDefaultAnimationCurve,
    this.sizeAxisAlignment = -1,
  });
  final Duration duration;
  final Duration reverseDuration;
  final Widget child;
  final Axis sizeAxis;
  final double fadeBegin;
  final double fadeEnd;
  final Curve fadeCurve;
  final double sizeBegin;
  final double sizeEnd;
  final Curve sizeCurve;
  final double sizeAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      transitionBuilder: (child, animation) {
        return SizeFadeTransition(
          sizeAxis: sizeAxis,
          animation: animation,
          fadeBegin: fadeBegin,
          fadeEnd: fadeEnd,
          fadeCurve: fadeCurve,
          sizeBegin: sizeBegin,
          sizeEnd: sizeEnd,
          sizeCurve: sizeCurve,
          sizeAxisAlignment: sizeAxisAlignment,
          child: child,
        );
      },
      child: child,
    );
  }
}
