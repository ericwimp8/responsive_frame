import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

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
  final Widget? top;
  final Widget child;
  final double? maxWidth;
  final double? minWidth;
  final double? topMinHeight;
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: topMaxHeight ?? kDefaultVerticalMaxHeight,
                minHeight: topMinHeight ?? kDefaultVerticalMinHeight,
              ),
              child: AnimatedShowHide(child: top),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
