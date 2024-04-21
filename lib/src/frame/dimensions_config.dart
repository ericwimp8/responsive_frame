import 'package:flutter/material.dart';

@immutable
class DimensionsConfig {
  const DimensionsConfig({
    this.topMaxHeight,
    this.topMinHeight,
    this.bodyTopMaxHeight,
    this.bodyTopMinHeight,
    this.bodyMaxWidth,
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

  @override
  String toString() {
    return 'DimensionsConfig(topMaxHeight: $topMaxHeight, topMinHeight: $topMinHeight, bodyTopMaxHeight: $bodyTopMaxHeight, bodyTopMinHeight: $bodyTopMinHeight, bodyMaxWidth: $bodyMaxWidth, leftEndMaxWidth: $leftEndMaxWidth, leftEndMinWidth: $leftEndMinWidth, leftEndFillVertical: $leftEndFillVertical, leftEndTopMaxHeight: $leftEndTopMaxHeight, leftEndTopMinHeight: $leftEndTopMinHeight, rightEndMaxWidth: $rightEndMaxWidth, rightEndMinWidth: $rightEndMinWidth, rightEndFillVertical: $rightEndFillVertical, rightEndTopMaxHeight: $rightEndTopMaxHeight, rightEndTopMinHeight: $rightEndTopMinHeight, bodyBottomMaxHeight: $bodyBottomMaxHeight, bodyBottomMinHeight: $bodyBottomMinHeight, bottomMaxHeight: $bottomMaxHeight, bottomMinHeight: $bottomMinHeight, bodyAlignment: $bodyAlignment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DimensionsConfig &&
        other.topMaxHeight == topMaxHeight &&
        other.topMinHeight == topMinHeight &&
        other.bodyTopMaxHeight == bodyTopMaxHeight &&
        other.bodyTopMinHeight == bodyTopMinHeight &&
        other.bodyMaxWidth == bodyMaxWidth &&
        other.leftEndMaxWidth == leftEndMaxWidth &&
        other.leftEndMinWidth == leftEndMinWidth &&
        other.leftEndFillVertical == leftEndFillVertical &&
        other.leftEndTopMaxHeight == leftEndTopMaxHeight &&
        other.leftEndTopMinHeight == leftEndTopMinHeight &&
        other.rightEndMaxWidth == rightEndMaxWidth &&
        other.rightEndMinWidth == rightEndMinWidth &&
        other.rightEndFillVertical == rightEndFillVertical &&
        other.rightEndTopMaxHeight == rightEndTopMaxHeight &&
        other.rightEndTopMinHeight == rightEndTopMinHeight &&
        other.bodyBottomMaxHeight == bodyBottomMaxHeight &&
        other.bodyBottomMinHeight == bodyBottomMinHeight &&
        other.bottomMaxHeight == bottomMaxHeight &&
        other.bottomMinHeight == bottomMinHeight &&
        other.bodyAlignment == bodyAlignment;
  }

  @override
  int get hashCode {
    return topMaxHeight.hashCode ^
        topMinHeight.hashCode ^
        bodyTopMaxHeight.hashCode ^
        bodyTopMinHeight.hashCode ^
        bodyMaxWidth.hashCode ^
        leftEndMaxWidth.hashCode ^
        leftEndMinWidth.hashCode ^
        leftEndFillVertical.hashCode ^
        leftEndTopMaxHeight.hashCode ^
        leftEndTopMinHeight.hashCode ^
        rightEndMaxWidth.hashCode ^
        rightEndMinWidth.hashCode ^
        rightEndFillVertical.hashCode ^
        rightEndTopMaxHeight.hashCode ^
        rightEndTopMinHeight.hashCode ^
        bodyBottomMaxHeight.hashCode ^
        bodyBottomMinHeight.hashCode ^
        bottomMaxHeight.hashCode ^
        bottomMinHeight.hashCode ^
        bodyAlignment.hashCode;
  }
}
