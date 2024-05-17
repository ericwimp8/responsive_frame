import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/animations/animation_constants.dart';

/// A widget that animates the constraints of a child widget.
///
/// The [AnimatedConstrainedBox] widget uses an [AnimationController] to animate the
/// constraints of its child widget. The animation is controlled by the
/// [duration] property.
///
/// The animation is applied to the [constraints] property. The [child] property
/// is the widget to be constrained.
///
/// {@tool snippet}
/// This example shows how to use the [AnimatedConstrainedBox] widget to animate the
/// constraints of a child widget.
///
/// ```dart
/// AnimatedConstrainedBox(
///   child: show ? const Text('Hello World!'): null,
///   constraints: BoxConstraints(
///     maxHeight: 100,
///     maxWidth: 200,
///   ),
///   duration: const Duration(seconds: 1),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ConstrainedBox]
///  * [AnimatedWidget]
class AnimatedConstrainedBox extends ImplicitlyAnimatedWidget {
  /// Creates a new [AnimatedConstrainedBox] widget.
  ///
  /// The [child] property is the widget to be constrained. The [constraints]
  /// property is the box constraints to be applied to the child widget. The
  /// [duration] property is the duration of the animation.
  AnimatedConstrainedBox({
    required this.child,
    required this.constraints,
    super.duration = kDefaultAnimationDuration,
    super.key,
  }) : assert(constraints.debugAssertIsValid(), '');

  /// The widget to be constrained.
  final Widget? child;

  /// The box constraints to be applied to the child widget.
  final BoxConstraints constraints;

  @override
  AnimatedWidgetBaseState<AnimatedConstrainedBox> createState() =>
      _AnimatedConstraintsState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(
      DiagnosticsProperty<BoxConstraints>(
        'constraints',
        constraints,
        defaultValue: null,
        showName: false,
      ),
    );
  }
}

class _AnimatedConstraintsState
    extends AnimatedWidgetBaseState<AnimatedConstrainedBox> {
  late BoxConstraintsTween _constraints;

  @override
  void initState() {
    _constraints = BoxConstraintsTween(
      begin: widget.constraints,
      end: widget.constraints,
    );
    super.initState();
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _constraints = visitor(
      _constraints,
      widget.constraints,
      (dynamic value) => BoxConstraintsTween(begin: value as BoxConstraints),
    )! as BoxConstraintsTween;
  }

  @override
  Widget build(BuildContext context) {
    final animation = this.animation;
    return ConstrainedBox(
      constraints: _constraints.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);

    description.add(
      DiagnosticsProperty<BoxConstraintsTween>(
        'constraints',
        _constraints,
        showName: false,
        defaultValue: null,
      ),
    );
  }
}
