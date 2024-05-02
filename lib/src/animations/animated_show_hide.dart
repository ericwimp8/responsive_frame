import 'package:flutter/material.dart';

class AnimatedShowHide extends StatefulWidget {
  const AnimatedShowHide({
    required this.child,
    this.animate = true,
    this.duration = const Duration(milliseconds: 180),
    this.switchInCurve = Curves.fastEaseInToSlowEaseOut,
    this.switchOutCurve = Curves.fastEaseInToSlowEaseOut,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
    super.key,
  });
  final bool animate;
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
    _controller!.addListener(_listener);
    _animation = _controller!.drive(Tween<double>(begin: 0, end: 1));
    _controller!.forward();
    super.initState();
  }

  void _listener() {
    if (_controller?.isDismissed ?? false) {
      _outGoingChild = const SizedBox();
    }
  }

  Widget? _outGoingChild;

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedShowHide oldWidget) {
    if (oldWidget.child != null) {
      _outGoingChild = oldWidget.child;
    }

    if (widget.child == null) {
      _controller?.reverse();
    } else {
      _controller?.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      return SizeTransition(
        axisAlignment: widget.axisAlignment,
        axis: widget.axis,
        sizeFactor: _animation,
        child: widget.child ?? _outGoingChild,
      );
    }

    return widget.child ?? const SizedBox();
  }
}
