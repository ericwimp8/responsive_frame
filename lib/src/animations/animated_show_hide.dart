import 'package:flutter/material.dart';

/// A function that is used to build a custom transition widget for an [AnimatedShowHide] widget.
///
/// This function is called with the current animation and the child widget and is responsible
/// for building a widget that will be used to animate the child widget.
///
/// The [context] parameter is the build context for the widget. The [animation] parameter is the animation
/// that will be used to animate the child widget. The [child] parameter is the widget being animated.
typedef AnimatedShowHideTransitionBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Widget? child,
);

/// A widget that animates the showing and hiding of its child with configurable animation parameters.
///
/// The [AnimatedShowHide] widget provides options for animation duration, curve, axis of animation,
/// axis alignment, and a custom transition builder function.
///
/// It can be used to smoothly animate the appearance and disappearance of a child widget within a parent widget.
///
/// ## Example
///
/// ```dart
/// AnimatedShowHide(
///   child: Text('Hello, World!'),
///   duration: Duration(seconds: 1),
///   curve: Curves.easeInOut,
///   axis: Axis.vertical,
///   axisAlignment: 0.5,
///   transitionBuilder: (context, animation, child) {
///     return FadeTransition(
///       opacity: animation,
///       child: child,
///     );
///   },
/// )
/// ```
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

  /// The child widget to animate.
  final Widget? child;

  /// Whether to animate the showing and hiding of the child.
  ///
  /// Defaults to `true`.
  final bool animate;

  /// The duration of the animation.
  ///
  /// Defaults to `180` milliseconds.
  final Duration duration;

  /// The curve to use for the animation.
  ///
  /// Defaults to [Curves.ease].
  final Curve curve;

  /// The axis along which the child widget will animate.
  ///
  /// Defaults to [Axis.vertical].
  final Axis axis;

  /// The alignment of the child widget along the animation axis.
  ///
  /// Default value is -1, which means center alignment.
  final double axisAlignment;

  /// The custom transition builder function for more advanced animations.
  final AnimatedShowHideTransitionBuilder? transitionBuilder;

  Widget buildAnimationWidget(BuildContext context) {
    return _AnimatedShowHide(
      transitionBuilder: transitionBuilder,
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
    this.transitionBuilder,
    super.key, // ignore: unused_element
  });

  final Widget? child;
  final Duration duration;
  final Curve curve;
  final Axis axis;
  final double axisAlignment;
  final AnimatedShowHideTransitionBuilder? transitionBuilder;

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
    super.didUpdateWidget(oldWidget);
    animatedOnChanges(oldWidget);
  }

  // This method manages the changes in the animated widget and ensures the appropriate actions are taken based on the properties of the current and previous widgets.
  //
  // If the `transitionBuilder` property of the current widget is null, it checks the `child` property of the previous widget. If the previous child is not null, it sets `_outGoingChild` to the previous child; otherwise, it sets it to `SizedBox()`.
  //
  // If the `child` property of the current widget is null, it calls `reverse()` on `_controller`; otherwise, it calls `forward()`.
  //
  // If the `transitionBuilder` property is not null, it checks and sets `_outGoingChild` based on the transition builder's call with the context, animation, and child properties. It then decides whether to call `reverse()` or `forward()` on `_controller` based on the transition builder's call result.
  void animatedOnChanges(covariant _AnimatedShowHide oldWidget) {
    if (widget.transitionBuilder == null) {
      if (oldWidget.child != null) {
        _outGoingChild = oldWidget.child ?? const SizedBox();
      }
      if (widget.child == null) {
        _controller?.reverse();
      } else {
        _controller?.forward();
      }
    } else {
      if (oldWidget.transitionBuilder
              ?.call(context, _animation, widget.child) !=
          null) {
        _outGoingChild = oldWidget.transitionBuilder
                ?.call(context, _animation, widget.child) ??
            const SizedBox();
      }
      if (widget.transitionBuilder?.call(context, _animation, widget.child) ==
          null) {
        _controller?.reverse();
      } else {
        _controller?.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transitionBuilder != null) {
      return widget.transitionBuilder!(
        context,
        _animation,
        widget.child,
      );
    }
    return SizeTransition(
      sizeFactor: _animation,
      axisAlignment: widget.axisAlignment,
      axis: widget.axis,
      child: widget.child ?? _outGoingChild,
    );
  }
}
