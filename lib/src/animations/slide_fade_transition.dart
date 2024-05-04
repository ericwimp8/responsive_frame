import 'package:flutter/material.dart';
import 'package:responsive_frame/src/animations/animation_constants.dart';

class SlideFadeTransition extends StatelessWidget {
  const SlideFadeTransition({
    required this.child,
    required this.animation,
    this.fadeBegin = kDefaultAnimationBeign,
    this.fadeEnd = kDefaultAnimationEnd,
    this.fadeCurve = kDefaultAnimationCurve,
    this.slideBegin = const Offset(0, 0.3),
    this.slideEnd = Offset.zero,
    this.slideCurve = kDefaultAnimationCurve,
    super.key,
  });

  final Widget child;
  final Animation<double> animation;
  final Offset slideBegin;
  final Offset slideEnd;
  final double fadeBegin;
  final double fadeEnd;
  final Curve fadeCurve;
  final Curve slideCurve;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: fadeBegin,
        end: fadeEnd,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: fadeCurve,
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: slideBegin,
          end: slideEnd,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: slideCurve,
          ),
        ),
        child: child,
      ),
    );
  }
}
