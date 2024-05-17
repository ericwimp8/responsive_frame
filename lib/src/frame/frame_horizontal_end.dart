import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that represents the end of a horizontal frame layout.
class FrameHorizontalEnd extends StatelessWidget {
  const FrameHorizontalEnd({
    required this.child,
    this.top,
    this.maxWidth = kDefaultHorizontalEndWidth,
    this.minWidth = kDefaultHorizontalEndWidth,
    this.topMaxHeight = kDefaultVerticalMaxHeight,
    this.topMinHeight = kDefaultVerticalMinHeight,
    super.key,
  });

  /// The widget to display at the top of the `FrameHorizontalEnd` widget.
  final Widget? top;

  /// The child widget of the `FrameHorizontalEnd` widget.
  final Widget child;

  /// The maximum width of the `FrameHorizontalEnd` widget.
  ///
  /// Defaults to [kDefaultHorizontalEndWidth].
  final double? maxWidth;

  /// The minimum width of the `FrameHorizontalEnd` widget.
  ///
  /// Defaults to [kDefaultHorizontalEndWidth].
  final double? minWidth;

  /// The minimum height of the widget at the top of the `FrameHorizontalEnd` widget.
  ///
  /// Defaults to [kDefaultVerticalMinHeight].
  final double? topMinHeight;

  /// The maximum height of the widget at the top of the `FrameHorizontalEnd` widget.
  ///
  /// Defaults to [kDefaultVerticalMaxHeight].
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
