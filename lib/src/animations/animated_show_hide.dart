import 'package:flutter/material.dart';

class AnimatedShowHide extends StatefulWidget {
  const AnimatedShowHide({
    required this.child,
    this.show = true,
    this.duration = const Duration(milliseconds: 180),
    this.switchInCurve = Curves.linear,
    this.switchOutCurve = Curves.linear,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
    super.key,
  });
  final bool show;
  final Duration duration;
  final Widget? child;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Axis axis;
  final double axisAlignment;

  @override
  State<AnimatedShowHide> createState() => _AnimatedShowHideState();
}

class _AnimatedShowHideState extends State<AnimatedShowHide>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = _controller!.drive(Tween<double>(begin: 0, end: 1));
    _controller!.forward();
    super.initState();
  }

  Widget? _outGoingChild;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedShowHide oldWidget) {
    _outGoingChild = oldWidget.child;
    if (widget.child == null) {
      _controller?.reverse();
    } else {
      _controller?.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: widget.axisAlignment,
      axis: widget.axis,
      sizeFactor: _animation,
      child: widget.child ?? _outGoingChild,
    );
  }
}
