import 'package:flutter/material.dart';

class AnimatedShowHide extends StatelessWidget {
  const AnimatedShowHide({
    this.child,
    this.animate = true,
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.ease,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
    this.transitionBuilder,
    super.key,
  });
  final bool animate;
  final Duration duration;
  final Widget? child;
  final Curve curve;
  final Axis axis;
  final double axisAlignment;
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  )? transitionBuilder;

  Widget buildAnimationWidget(BuildContext context) {
    return _AnimatedShowHide(
      transiationBuilder: transitionBuilder,
      duration: duration,
      curve: curve,
      axis: axis,
      axisAlignment: axisAlignment,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (animate) {
      return buildAnimationWidget(context);
    }
    return child ?? const SizedBox();
  }
}

class _AnimatedShowHide extends StatefulWidget {
  const _AnimatedShowHide({
    this.child,
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.ease,
    this.axis = Axis.vertical,
    this.axisAlignment = -1,
    this.transiationBuilder,
    super.key, // ignore: unused_element
  });

  final Duration duration;
  final Widget? child;
  final Curve curve;
  final Axis axis;
  final double axisAlignment;
  final Widget? Function(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  )? transiationBuilder;

  @override
  State<_AnimatedShowHide> createState() => _AnimatedShowHideState();
}

class _AnimatedShowHideState extends State<_AnimatedShowHide>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;

  void _listener() {
    if (_controller?.isDismissed ?? false) {
      setState(() {
        _outGoingChild = const SizedBox();
      });
    }
  }

  Widget _outGoingChild = const SizedBox();

  @override
  void initState() {
    _controller ??= AnimationController(vsync: this, duration: widget.duration);
    _controller!.addListener(_listener);
    _animation = CurvedAnimation(
      parent: _controller!.drive(Tween<double>(begin: 0, end: 1)),
      curve: widget.curve,
    );
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _AnimatedShowHide oldWidget) {
    if (widget.transiationBuilder == null) {
      if (oldWidget.child != null) {
        _outGoingChild = oldWidget.child ?? const SizedBox();
      }
      if (widget.child == null) {
        _controller?.reverse();
      } else {
        _controller?.forward();
      }
    } else {
      if (oldWidget.transiationBuilder
              ?.call(context, _animation, widget.child) !=
          null) {
        _outGoingChild = oldWidget.transiationBuilder
                ?.call(context, _animation, widget.child) ??
            const SizedBox();
      }
      if (widget.transiationBuilder?.call(context, _animation, widget.child) ==
          null) {
        _controller?.reverse();
      } else {
        _controller?.forward();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transiationBuilder != null) {
      return widget.transiationBuilder!(
            context,
            _animation,
            widget.child,
          ) ??
          _outGoingChild;
    }
    return SizeTransition(
      sizeFactor: _animation,
      axisAlignment: widget.axisAlignment,
      axis: widget.axis,
      child: widget.child ?? _outGoingChild,
    );
  }
}
