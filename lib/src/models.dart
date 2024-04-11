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
  final Widget? child;
  final double height;
  FrameVerticalEndModel({
    this.child,
    this.height = kDefaultVerticalEndHeight,
  });
}

class FrameBodyItemModel {
  final Widget child;
  final int flex;
  const FrameBodyItemModel({
    required this.child,
    this.flex = 1,
  });
}

class FrameBodyModel {
  final Alignment bodyAlignment;
  final List<FrameBodyItemModel> Function(BuildContext) children;
  const FrameBodyModel({
    this.bodyAlignment = Alignment.topCenter,
    required this.children,
  });
}
