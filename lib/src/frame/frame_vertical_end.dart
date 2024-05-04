// ignore_for_file: lines_longer_than_80_chars, cascade_invocations, prefer_asserts_with_message

import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

class FrameVerticalEnd extends StatelessWidget {
  const FrameVerticalEnd({
    required this.child,
    super.key,
    this.maxHeight = kDefaultVerticalMaxHeight,
    this.minHeight = kDefaultVerticalMinHeight,
  });
  final Widget child;
  final double? maxHeight;
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
