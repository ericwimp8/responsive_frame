import 'package:flutter/widgets.dart';

const kDefaultVerticalEndHeight = 100.0;
const kDefaultHorizontalEndWidth = 200.0;

class FrameHorizontalEndModel {
  const FrameHorizontalEndModel({
    required this.body,
    this.top,
    this.fillVertical = true,
    this.maxWidth = kDefaultHorizontalEndWidth,
    this.minWidth = kDefaultHorizontalEndWidth,
    this.topHeight = kDefaultVerticalEndHeight,
  });
  final Widget? top;
  final Widget body;
  final bool fillVertical;
  final double maxWidth;
  final double minWidth;
  final double topHeight;
}

class FrameVerticalEndModel {
  FrameVerticalEndModel({
    required this.child,
    this.height = kDefaultVerticalEndHeight,
  });
  final Widget child;
  final double height;
}

class FrameBodyItemModel {
  const FrameBodyItemModel({
    required this.child,
    this.flex = 1,
  });
  final Widget child;
  final int flex;
}

class FrameBodyModel {
  const FrameBodyModel({
    required this.children,
    this.bodyAlignment = Alignment.topCenter,
  });
  final Alignment bodyAlignment;
  final List<FrameBodyItemModel> children;
}
