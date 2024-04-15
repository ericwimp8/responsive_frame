import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class FrameVerticalEnd extends StatelessWidget {
  const FrameVerticalEnd({
    required this.child,
    super.key,
  });
  final VerticalEndModel child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: child.height,
        minHeight: child.height,
      ),
      child: child.child,
    );
  }
}
