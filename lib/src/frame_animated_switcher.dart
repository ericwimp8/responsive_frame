import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class FrameAnimatedSwitcher extends StatelessWidget {
  const FrameAnimatedSwitcher({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SizeFadeTransition(
          animation: animation,
          child: child,
        );
      },
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}
