import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

class FrameHorizontalEnd extends StatelessWidget {
  const FrameHorizontalEnd({
    required this.body,
    this.top,
    this.maxWidth = kDefaultHorizontalEndWidth,
    this.minWidth = kDefaultHorizontalEndWidth,
    this.topHeight = kDefaultVerticalEndHeight,
    this.fillVertical = true,
    super.key,
  }) : assert(maxWidth >= minWidth, 'maxWidth >= minWidth must be true');
  final Widget? top;
  final Widget body;
  final bool fillVertical;
  final double maxWidth;
  final double minWidth;
  final double topHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minWidth: maxWidth,
      ),
      child: Column(
        children: [
          if (top != null)
            AnimatedConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: topHeight,
                minHeight: topHeight,
                minWidth: minWidth,
                maxWidth: maxWidth,
              ),
              child: top,
            ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
