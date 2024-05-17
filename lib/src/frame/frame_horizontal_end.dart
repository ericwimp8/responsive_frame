import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that constrains a child widget to a horizontal end, used in [Frame].
///
/// The [FrameHorizontalEnd] widget constrains its child widget to a horizontal
/// end. This is useful for rendering widgets that should fill the horizontal
/// space of the frame, such as a side bar.
///
/// The [maxWidth] and [minWidth] properties can be used to control the maximum
/// and minimum width of the child widget. The [top] property can be used to
/// render a widget at the top of the constrained area. The [topMaxHeight] and
/// [topMinHeight] properties can be used to control the maximum and minimum
/// height of the top widget.
///
/// {@tool snippet}
/// This example shows how to use the [FrameHorizontalEnd] widget to constrain a
/// child widget to a horizontal end.
///
/// ```dart
/// FrameHorizontalEnd(
///   child: const Text('Side Bar'),
///   maxWidth: 200,
///   minWidth: 100,
///   top: const Text('Header'),
///   topMaxHeight: 50,
///   topMinHeight: 25,
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Frame]
///  * [FrameVerticalEnd]
class FrameHorizontalEnd extends StatelessWidget {
  /// Creates a new [FrameHorizontalEnd] widget.
  ///
  /// The [child] property is the widget to be constrained. The [maxWidth] and
  /// [minWidth] properties can be used to control the maximum and minimum
  /// width of the child widget. The [top] property can be used to render a
  /// widget at the top of the constrained area. The [topMaxHeight] and
  /// [topMinHeight] properties can be used to control the maximum and minimum
  /// height of the top widget.
  const FrameHorizontalEnd({
    required this.child,
    this.top,
    this.maxWidth = kDefaultHorizontalEndWidth,
    this.minWidth = kDefaultHorizontalEndWidth,
    this.topMaxHeight = kDefaultVerticalMaxHeight,
    this.topMinHeight = kDefaultVerticalMinHeight,
    super.key,
  });

  /// The widget to render at the top of the constrained area.
  final Widget? top;

  /// The widget to be constrained.
  final Widget child;

  /// The maximum width of the child widget.
  final double? maxWidth;

  /// The minimum width of the child widget.
  final double? minWidth;

  /// The minimum height of the top widget.
  final double? topMinHeight;

  /// The maximum height of the top widget.
  final double? topMaxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? kDefaultHorizontalEndWidth,
        minWidth: minWidth ?? kDefaultHorizontalEndWidth,
      ),
      child: Column(
        children: [
          if (top != null)
            AnimatedConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: topMaxHeight ?? kDefaultVerticalMaxHeight,
                minHeight: topMinHeight ?? kDefaultVerticalMinHeight,
              ),
              child: top,
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
