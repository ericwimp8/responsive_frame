import 'package:flutter/widgets.dart';

const kDefaultVerticalEndHeight = 100.0;
const kDefaultHorizontalEndWidth = 200.0;

class HorizontalEndModel {
  const HorizontalEndModel({
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

class VerticalEndModel {
  VerticalEndModel({
    required this.child,
    this.height = kDefaultVerticalEndHeight,
  });
  final Widget child;
  final double height;
}

class BodyItemModel {
  const BodyItemModel({
    required this.child,
    this.flex = 1,
  });
  final Widget child;
  final int flex;
}

class BodyModel {
  const BodyModel({
    required this.children,
    this.bodyAlignment = Alignment.topCenter,
  });
  final Alignment bodyAlignment;
  final List<BodyItemModel> children;
}
