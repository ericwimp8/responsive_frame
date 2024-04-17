import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class FrameConfig {
  const FrameConfig({
    required this.body,
    this.animations = true,
    this.top,
    this.topHeight = kDefaultVerticalEndHeight,
    this.bodyTop,
    this.bodyTopHeight = kDefaultVerticalEndHeight,
    this.bodyAlignment = Alignment.topCenter,
    this.bodyMaxWidth = 950,
    this.bodyMinWidth = 0,
    this.leftEnd,
    this.leftEndTop,
    this.leftEndMaxWidth = kDefaultHorizontalEndWidth,
    this.leftEndMinWidth = kDefaultHorizontalEndWidth,
    this.leftEndTopHeight = kDefaultVerticalEndHeight,
    this.leftEndFillVertical = true,
    this.rightEnd,
    this.rightEndTop,
    this.rightEndMaxWidth = kDefaultHorizontalEndWidth,
    this.rightEndMinWidth = kDefaultHorizontalEndWidth,
    this.rightEndTopHeight = kDefaultVerticalEndHeight,
    this.rightEndFillVertical = true,
    this.bodyBottom,
    this.bodyBottomHeight = kDefaultVerticalEndHeight,
    this.bottom,
    this.bottomHeight = kDefaultVerticalEndHeight,
  });
  final bool animations;
  final List<FrameBodyListChild> body;
  final Widget? top;
  final double topHeight;
  final Widget? bodyTop;
  final double bodyTopHeight;
  final Alignment bodyAlignment;
  final double bodyMaxWidth;
  final double bodyMinWidth;
  final Widget? leftEnd;
  final Widget? leftEndTop;
  final double leftEndMaxWidth;
  final double leftEndMinWidth;
  final bool leftEndFillVertical;
  final double leftEndTopHeight;
  final Widget? rightEnd;
  final Widget? rightEndTop;
  final double rightEndMaxWidth;
  final double rightEndMinWidth;
  final bool rightEndFillVertical;
  final double rightEndTopHeight;
  final Widget? bodyBottom;
  final double bodyBottomHeight;
  final Widget? bottom;
  final double bottomHeight;
}
