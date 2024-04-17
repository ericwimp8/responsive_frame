import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

const kDefaultHorizontalEndWidth = 200.0;

class FrameHorizontalEnd extends StatelessWidget {
  const FrameHorizontalEnd({
    required this.body,
    this.top,
    this.maxWidth = kDefaultHorizontalEndWidth,
    this.minWidth = kDefaultHorizontalEndWidth,
    this.topHeight = kDefaultVerticalEndHeight,
    this.fillVertical = true,
    super.key,
  });
  final Widget? top;
  final Widget body;
  final bool fillVertical;
  final double maxWidth;
  final double minWidth;
  final double topHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minWidth: maxWidth,
      ),
      child: Column(
        children: [
          if (top != null)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: topHeight,
                minHeight: topHeight,
                minWidth: double.infinity,
              ),
              child: top,
            ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
