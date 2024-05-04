import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class AnimatedSwitcherScaleFade extends StatelessWidget {
  const AnimatedSwitcherScaleFade({
    required this.child,
    super.key,
    this.duration = kDefaultAnimationDuration,
    this.reverseDuration = kDefaultAnimationDuration,
    this.scaleAlignment = Alignment.center,
    this.fadeBegin = kDefaultAnimationBeign,
    this.fadeEnd = kDefaultAnimationEnd,
    this.fadeCurve = kDefaultAnimationCurve,
    this.scaleBegin = kDefaultAnimationBeign,
    this.scaleEnd = kDefaultAnimationEnd,
    this.scaleCurve = kDefaultAnimationCurve,
  });
  final Widget? child;
  final Duration duration;
  final Duration reverseDuration;
  final Alignment scaleAlignment;
  final double fadeBegin;
  final double fadeEnd;
  final Curve fadeCurve;
  final double scaleBegin;
  final double scaleEnd;
  final Curve scaleCurve;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return ScaleFadeTransition(
          animation: animation,
          fadeBegin: fadeBegin,
          fadeEnd: fadeEnd,
          fadeCurve: fadeCurve,
          scaleBegin: scaleBegin,
          scaleEnd: scaleEnd,
          scaleCurve: scaleCurve,
          child: child,
        );
      },
      child: child,
    );
  }
}
