import 'package:flutter/material.dart';

class SizeFadeTransition extends StatelessWidget {
  const SizeFadeTransition({
    required this.animation,
    required this.child,
    super.key,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
  });
  final Animation<double> animation;
  final Widget child;
  final Axis axis;
  final double axisAlignment;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: axisAlignment,
      sizeFactor: animation,
      axis: axis,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
