import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/animations/animation_constants.dart';

class AnimatedConstrainedBox extends ImplicitlyAnimatedWidget {
  /// Creates a container that animates its parameters implicitly.
  AnimatedConstrainedBox({
    required this.child,
    required this.constraints,
    super.duration = kDefaultAnimationDuration,
    super.key,
  }) : assert(constraints.debugAssertIsValid(), '');

  final Widget? child;
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
