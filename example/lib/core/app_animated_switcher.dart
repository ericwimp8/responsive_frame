import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class AppAnimatedSwitcherSizeFade extends StatelessWidget {
  const AppAnimatedSwitcherSizeFade({
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
        return AppSizeFadeTransition(
          axis: axis,
          animation: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}

class AppAnimatedSwitcherSlideFade extends StatelessWidget {
  const AppAnimatedSwitcherSlideFade({
    required this.child,
    super.key,
    this.duration = kDefaultAnimationDuration,
    this.reverseDuration = kDefaultAnimationDuration,
    this.begin = const Offset(0, 0.3),
    this.end = Offset.zero,
  });
  final Widget? child;
  final Duration duration;
  final Duration reverseDuration;
  final Offset begin;
  final Offset end;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      reverseDuration: const Duration(milliseconds: 180),
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
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: end,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class AppAnimatedSwitcherScale extends StatelessWidget {
  const AppAnimatedSwitcherScale({
    required this.child,
    super.key,
    this.duration = kDefaultAnimationDuration,
    this.reverseDuration = kDefaultAnimationDuration,
    this.begin = 0.97,
    this.end = 1,
    this.scaleAlignment = Alignment.center,
  });
  final Widget? child;
  final Duration duration;
  final Duration reverseDuration;
  final double begin;
  final double end;
  final Alignment scaleAlignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.3, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.ease,
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: begin,
              end: end,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
