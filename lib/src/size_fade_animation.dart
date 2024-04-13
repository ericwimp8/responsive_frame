import 'package:flutter/material.dart';

class SizeFadeTransition extends StatelessWidget {
  const SizeFadeTransition({
    required this.animation,
    required this.child,
    super.key,
    this.axis = Axis.vertical,
  });
  final Animation<double> animation;
  final Widget child;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: -1,
      sizeFactor: animation,
      axis: axis,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
