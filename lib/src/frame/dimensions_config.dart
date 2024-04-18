import 'package:flutter/material.dart';

@immutable
class DimensionsConfig {
  const DimensionsConfig({
    this.topMaxHeight,
    this.topMinHeight,
    this.bodyTopMaxHeight,
    this.bodyTopMinHeight,
    this.bodyMaxWidth,
    this.bodyMinWidth,
    this.leftEndMaxWidth,
    this.leftEndMinWidth,
    this.leftEndFillVertical,
    this.leftEndTopMinHeight,
    this.leftEndTopMaxHeight,
    this.rightEndMaxWidth,
    this.rightEndMinWidth,
    this.rightEndFillVertical,
    this.rightEndTopMaxHeight,
    this.rightEndTopMinHeight,
    this.bodyBottomMaxHeight,
    this.bodyBottomMinHeight,
    this.bottomMaxHeight,
    this.bottomMinHeight,
    this.bodyAlignment,
  });
  final double? topMaxHeight;
  final double? topMinHeight;
  final double? bodyTopMaxHeight;
  final double? bodyTopMinHeight;
  final double? bodyMaxWidth;
  final double? bodyMinWidth;
  final double? leftEndMaxWidth;
  final double? leftEndMinWidth;
  final bool? leftEndFillVertical;
  final double? leftEndTopMaxHeight;
  final double? leftEndTopMinHeight;
  final double? rightEndMaxWidth;
  final double? rightEndMinWidth;
  final bool? rightEndFillVertical;
  final double? rightEndTopMaxHeight;
  final double? rightEndTopMinHeight;
  final double? bodyBottomMaxHeight;
  final double? bodyBottomMinHeight;
  final double? bottomMaxHeight;
  final double? bottomMinHeight;
  final Alignment? bodyAlignment;

  static const empty = DimensionsConfig();

  // uses pesistent value if local one is not set
  // persistent values can be overriden
  DimensionsConfig merge(DimensionsConfig? config) {
    return DimensionsConfig(
      topMaxHeight: topMaxHeight ?? config?.topMaxHeight,
      topMinHeight: topMinHeight ?? config?.topMinHeight,
      bodyTopMaxHeight: bodyTopMaxHeight ?? config?.bodyTopMaxHeight,
      bodyTopMinHeight: bodyTopMinHeight ?? config?.bodyTopMinHeight,
      bodyMaxWidth: bodyMaxWidth ?? config?.bodyMaxWidth,
      bodyMinWidth: bodyMinWidth ?? config?.bodyMinWidth,
      leftEndMaxWidth: leftEndMaxWidth ?? config?.leftEndMaxWidth,
      leftEndMinWidth: leftEndMinWidth ?? config?.leftEndMinWidth,
      leftEndFillVertical: leftEndFillVertical ?? config?.leftEndFillVertical,
      leftEndTopMaxHeight: leftEndTopMaxHeight ?? config?.leftEndTopMaxHeight,
      leftEndTopMinHeight: leftEndTopMinHeight ?? config?.leftEndTopMinHeight,
      rightEndMaxWidth: rightEndMaxWidth ?? config?.rightEndMaxWidth,
      rightEndMinWidth: rightEndMinWidth ?? config?.rightEndMinWidth,
      rightEndFillVertical:
          rightEndFillVertical ?? config?.rightEndFillVertical,
      rightEndTopMaxHeight:
          rightEndTopMaxHeight ?? config?.rightEndTopMaxHeight,
      rightEndTopMinHeight:
          rightEndTopMinHeight ?? config?.rightEndTopMinHeight,
      bodyBottomMaxHeight: bodyBottomMaxHeight ?? config?.bodyBottomMaxHeight,
      bodyBottomMinHeight: bodyBottomMinHeight ?? config?.bodyBottomMinHeight,
      bottomMaxHeight: bottomMaxHeight ?? config?.bottomMaxHeight,
      bottomMinHeight: bottomMinHeight ?? config?.bottomMinHeight,
      bodyAlignment: bodyAlignment ?? config?.bodyAlignment,
    );
  }
}
