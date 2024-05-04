import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class AnimatedSwitcherSlideFade extends StatelessWidget {
  const AnimatedSwitcherSlideFade({
    required this.child,
    super.key,
    this.duration = kDefaultAnimationDuration,
    this.reverseDuration = kDefaultAnimationDuration,
    this.fadeBegin = kDefaultAnimationBeign,
    this.fadeEnd = kDefaultAnimationEnd,
    this.fadeCurve = kDefaultAnimationCurve,
    this.slideBegin = const Offset(0, 0.3),
    this.slideEnd = Offset.zero,
    this.slideCurve = kDefaultAnimationCurve,
  });
  final Widget? child;
  final Duration duration;
  final Duration reverseDuration;
  final double fadeBegin;
  final double fadeEnd;
  final Curve fadeCurve;
  final Offset slideBegin;
  final Offset slideEnd;
  final Curve slideCurve;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: reverseDuration,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (child, animation) {
        return SlideFadeTransition(
          animation: animation,
          slideBegin: slideBegin,
          slideEnd: slideEnd,
          slideCurve: slideCurve,
          fadeBegin: fadeBegin,
          fadeEnd: fadeEnd,
          fadeCurve: fadeCurve,
          child: child,
        );
      },
      child: child,
    );
  }
}
