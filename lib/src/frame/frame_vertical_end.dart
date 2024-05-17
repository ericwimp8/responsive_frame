import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that constrains a child widget to a vertical end, used in [Frame].
///
/// The [FrameVerticalEnd] widget constrains its child widget to a vertical
/// end. This is useful for rendering widgets that should fill the vertical
/// space of the frame, such as a header or footer.
///
/// The [maxHeight] and [minHeight] properties can be used to control the maximum
/// and minimum height of the child widget.
///
/// {@tool snippet}
/// This example shows how to use the [FrameVerticalEnd] widget to constrain a
/// child widget to a vertical end.
///
/// ```dart
/// FrameVerticalEnd(
///   child: const Text('Header'),
///   maxHeight: 100,
///   minHeight: 50,
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Frame]
///  * [FrameHorizontalEnd]
class FrameVerticalEnd extends StatelessWidget {
  /// Creates a new [FrameVerticalEnd] widget.
  ///
  /// The [child] property is the widget to be constrained. The [maxHeight] and
  /// [minHeight] properties can be used to control the maximum and minimum
  /// height of the child widget.
  const FrameVerticalEnd({
    required this.child,
    super.key,
    this.maxHeight = kDefaultVerticalMaxHeight,
    this.minHeight = kDefaultVerticalMinHeight,
  });

  /// The widget to be constrained.
  final Widget child;

  /// The maximum height of the child widget.
  final double? maxHeight;

  /// The minimum height of the child widget.
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: maxHeight ?? kDefaultVerticalMaxHeight,
        minHeight: minHeight ?? kDefaultVerticalMinHeight,
      ),
      child: child,
    );
  }
}
