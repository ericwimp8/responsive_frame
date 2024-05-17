import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

/// A widget that represents the end of a vertical frame layout.
class FrameVerticalEnd extends StatelessWidget {
  const FrameVerticalEnd({
    required this.child,
    super.key,
    this.maxHeight = kDefaultVerticalMaxHeight,
    this.minHeight = kDefaultVerticalMinHeight,
  });

  /// The child widget of the `FrameVerticalEnd` widget.
  final Widget child;

  /// The maximum height of the `FrameVerticalEnd` widget.
  ///
  /// Defaults to [kDefaultVerticalMaxHeight].
  final double? maxHeight;

  /// The minimum height of the `FrameVerticalEnd` widget.
  ///
  /// Defaults to [kDefaultVerticalMinHeight].
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
