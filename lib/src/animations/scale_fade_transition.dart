import 'package:flutter/material.dart';
import 'package:responsive_frame/src/animations/animation_constants.dart';

class ScaleFadeTransition extends StatelessWidget {
  const ScaleFadeTransition({
    required this.animation,
    required this.child,
    this.scaleAlignment = Alignment.center,
    this.fadeBegin = kDefaultAnimationBeign,
    this.fadeEnd = kDefaultAnimationEnd,
    this.fadeCurve = kDefaultAnimationCurve,
    this.scaleBegin = kDefaultAnimationBeign,
    this.scaleEnd = kDefaultAnimationEnd,
    this.scaleCurve = kDefaultAnimationCurve,
    super.key,
  });

  final Animation<double> animation;
  final Widget child;
  final Alignment scaleAlignment;
  final double fadeBegin;
  final double fadeEnd;
  final Curve fadeCurve;
  final double scaleBegin;
  final double scaleEnd;
  final Curve scaleCurve;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: fadeBegin,
        end: fadeEnd,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: scaleCurve,
        ),
      ),
      child: ScaleTransition(
        alignment: scaleAlignment,
        scale: Tween<double>(
          begin: scaleBegin,
          end: scaleEnd,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: fadeCurve,
          ),
        ),
        child: child,
      ),
    );
  }
}
