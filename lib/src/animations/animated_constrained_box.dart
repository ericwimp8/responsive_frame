import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/animations/animation_constants.dart';

/// A widget that animates its constraints implicitly.
///
/// The `AnimatedConstrainedBox` widget allows you to animate the constraints
/// of its child widget over a given duration. It takes a [BoxConstraints] object
/// as its constraints parameter, which defines the constraints to be applied to
/// the child widget.
/// ## Example
///
/// ```dart
/// class AnimateConstraints extends StatefulWidget {
///   const AnimateConstraints({super.key});
///
///   @override
///   State<AnimateConstraints> createState() => _AnimateConstraintsState();
/// }
///
/// class _AnimateConstraintsState extends State<AnimateConstraints> {
///   bool grow = true;
///
///   double maxHeight = 200;
///   double maxWidth = 200;
///   void toggle() {
///     setState(() {
///       grow = !grow;
///       maxHeight = grow ? 400 : 200;
///       maxWidth = grow ? 400 : 200;
///     });
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       children: [
///         ElevatedButton(onPressed: toggle, child: const Text('Toggle')),
///         AnimatedConstrainedBox(
///           constraints: BoxConstraints(
///             minWidth: double.infinity,
///             maxHeight: maxHeight,
///           ),
///           child: const ColoredBox(
///             color: Colors.lightBlue,
///             child: Align(
///               child: Text('Hello world'),
///             ),
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ```
class AnimatedConstrainedBox extends ImplicitlyAnimatedWidget {
  /// A widget that animates its constraints implicitly.
  AnimatedConstrainedBox({
    required this.child,
    required this.constraints,
    super.duration = kDefaultAnimationDuration,
    super.key,
  }) : assert(constraints.debugAssertIsValid(), '');

  /// The child widget to animate.
  final Widget? child;

  /// The constraints to apply to the child widget.
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
