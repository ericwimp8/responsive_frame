import 'package:flutter/material.dart';

const kDefaultVerticalEndHeight = 100.0;

class FrameVerticalEnd extends StatelessWidget {
  const FrameVerticalEnd({
    required this.child,
    super.key,
    this.height = kDefaultVerticalEndHeight,
  });
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: height,
        minHeight: height,
      ),
      child: child,
    );
  }
}
