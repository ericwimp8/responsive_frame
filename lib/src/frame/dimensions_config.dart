import 'package:flutter/material.dart';

@immutable
class DimensionsConfig {
  const DimensionsConfig({
    this.topHeight,
    this.bodyTopHeight,
    this.bodyMaxWidth,
    this.bodyMinWidth,
    this.leftEndMaxWidth,
    this.leftEndMinWidth,
    this.leftEndFillVertical,
    this.leftEndTopHeight,
    this.rightEndMaxWidth,
    this.rightEndMinWidth,
    this.rightEndFillVertical,
    this.rightEndTopHeight,
    this.bodyBottomHeight,
    this.bottomHeight,
    this.bodyAlignment,
  });
  final double? topHeight;
  final double? bodyTopHeight;
  final double? bodyMaxWidth;
  final double? bodyMinWidth;
  final double? leftEndMaxWidth;
  final double? leftEndMinWidth;
  final bool? leftEndFillVertical;
  final double? leftEndTopHeight;
  final double? rightEndMaxWidth;
  final double? rightEndMinWidth;
  final bool? rightEndFillVertical;
  final double? rightEndTopHeight;
  final double? bodyBottomHeight;
  final double? bottomHeight;
  final Alignment? bodyAlignment;

  static const empty = DimensionsConfig();

  // uses pesistent value if local one is not set
  // persistent values can be overriden
  DimensionsConfig merge(DimensionsConfig? config) {
    return DimensionsConfig(
      topHeight: topHeight ?? config?.topHeight,
      bodyTopHeight: bodyTopHeight ?? config?.bodyTopHeight,
      bodyMaxWidth: bodyMaxWidth ?? config?.bodyMaxWidth,
      bodyMinWidth: bodyMinWidth ?? config?.bodyMinWidth,
      leftEndMaxWidth: leftEndMaxWidth ?? config?.leftEndMaxWidth,
      leftEndMinWidth: leftEndMinWidth ?? config?.leftEndMinWidth,
      leftEndFillVertical: leftEndFillVertical ?? config?.leftEndFillVertical,
      leftEndTopHeight: leftEndTopHeight ?? config?.leftEndTopHeight,
      rightEndMaxWidth: rightEndMaxWidth ?? config?.rightEndMaxWidth,
      rightEndMinWidth: rightEndMinWidth ?? config?.rightEndMinWidth,
      rightEndFillVertical:
          rightEndFillVertical ?? config?.rightEndFillVertical,
      rightEndTopHeight: rightEndTopHeight ?? config?.rightEndTopHeight,
      bodyBottomHeight: bodyBottomHeight ?? config?.bodyBottomHeight,
      bottomHeight: bottomHeight ?? config?.bottomHeight,
      bodyAlignment: bodyAlignment ?? config?.bodyAlignment,
    );
  }

  DimensionsConfig copyWith({
    double? topHeight,
    double? bodyTopHeight,
    double? bodyMaxWidth,
    double? bodyMinWidth,
    double? leftEndMaxWidth,
    double? leftEndMinWidth,
    bool? leftEndFillVertical,
    double? leftEndTopHeight,
    double? rightEndMaxWidth,
    double? rightEndMinWidth,
    bool? rightEndFillVertical,
    double? rightEndTopHeight,
    double? bodyBottomHeight,
    double? bottomHeight,
    Alignment? bodyAlignment,
  }) {
    return DimensionsConfig(
      topHeight: topHeight ?? this.topHeight,
      bodyTopHeight: bodyTopHeight ?? this.bodyTopHeight,
      bodyMaxWidth: bodyMaxWidth ?? this.bodyMaxWidth,
      bodyMinWidth: bodyMinWidth ?? this.bodyMinWidth,
      leftEndMaxWidth: leftEndMaxWidth ?? this.leftEndMaxWidth,
      leftEndMinWidth: leftEndMinWidth ?? this.leftEndMinWidth,
      leftEndFillVertical: leftEndFillVertical ?? this.leftEndFillVertical,
      leftEndTopHeight: leftEndTopHeight ?? this.leftEndTopHeight,
      rightEndMaxWidth: rightEndMaxWidth ?? this.rightEndMaxWidth,
      rightEndMinWidth: rightEndMinWidth ?? this.rightEndMinWidth,
      rightEndFillVertical: rightEndFillVertical ?? this.rightEndFillVertical,
      rightEndTopHeight: rightEndTopHeight ?? this.rightEndTopHeight,
      bodyBottomHeight: bodyBottomHeight ?? this.bodyBottomHeight,
      bottomHeight: bottomHeight ?? this.bottomHeight,
      bodyAlignment: bodyAlignment ?? this.bodyAlignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DimensionsConfig &&
        other.topHeight == topHeight &&
        other.bodyTopHeight == bodyTopHeight &&
        other.bodyMaxWidth == bodyMaxWidth &&
        other.bodyMinWidth == bodyMinWidth &&
        other.leftEndMaxWidth == leftEndMaxWidth &&
        other.leftEndMinWidth == leftEndMinWidth &&
        other.leftEndFillVertical == leftEndFillVertical &&
        other.leftEndTopHeight == leftEndTopHeight &&
        other.rightEndMaxWidth == rightEndMaxWidth &&
        other.rightEndMinWidth == rightEndMinWidth &&
        other.rightEndFillVertical == rightEndFillVertical &&
        other.rightEndTopHeight == rightEndTopHeight &&
        other.bodyBottomHeight == bodyBottomHeight &&
        other.bottomHeight == bottomHeight &&
        other.bodyAlignment == bodyAlignment;
  }

  @override
  int get hashCode {
    return topHeight.hashCode ^
        bodyTopHeight.hashCode ^
        bodyMaxWidth.hashCode ^
        bodyMinWidth.hashCode ^
        leftEndMaxWidth.hashCode ^
        leftEndMinWidth.hashCode ^
        leftEndFillVertical.hashCode ^
        leftEndTopHeight.hashCode ^
        rightEndMaxWidth.hashCode ^
        rightEndMinWidth.hashCode ^
        rightEndFillVertical.hashCode ^
        rightEndTopHeight.hashCode ^
        bodyBottomHeight.hashCode ^
        bottomHeight.hashCode ^
        bodyAlignment.hashCode;
  }

  @override
  String toString() {
    return 'DimensionsConfig(topHeight: $topHeight, bodyTopHeight: $bodyTopHeight, bodyMaxWidth: $bodyMaxWidth, bodyMinWidth: $bodyMinWidth, leftEndMaxWidth: $leftEndMaxWidth, leftEndMinWidth: $leftEndMinWidth, leftEndFillVertical: $leftEndFillVertical, leftEndTopHeight: $leftEndTopHeight, rightEndMaxWidth: $rightEndMaxWidth, rightEndMinWidth: $rightEndMinWidth, rightEndFillVertical: $rightEndFillVertical, rightEndTopHeight: $rightEndTopHeight, bodyBottomHeight: $bodyBottomHeight, bottomHeight: $bottomHeight, bodyAlignment: $bodyAlignment)';
  }
}
