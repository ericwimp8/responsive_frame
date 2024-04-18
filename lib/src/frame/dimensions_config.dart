import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

@immutable
class DimensionsConfig {
  const DimensionsConfig({
    this.topHeight = kDefaultVerticalEndHeight,
    this.bodyTopHeight = kDefaultVerticalEndHeight,
    this.bodyMaxWidth = kDefaultBodyMaxWidth,
    this.bodyMinWidth = kDefaultBodyMinWidth,
    this.leftEndMaxWidth = kDefaultHorizontalEndWidth,
    this.leftEndMinWidth = kDefaultHorizontalEndWidth,
    this.leftEndFillVertical = true,
    this.leftEndTopHeight = kDefaultVerticalEndHeight,
    this.rightEndMaxWidth = kDefaultHorizontalEndWidth,
    this.rightEndMinWidth = kDefaultHorizontalEndWidth,
    this.rightEndFillVertical = true,
    this.rightEndTopHeight = kDefaultVerticalEndHeight,
    this.bodyBottomHeight = kDefaultVerticalEndHeight,
    this.bottomHeight = kDefaultVerticalEndHeight,
    this.bodyAlignment = Alignment.topCenter,
  });
  final double topHeight;
  final double bodyTopHeight;
  final double bodyMaxWidth;
  final double bodyMinWidth;
  final double leftEndMaxWidth;
  final double leftEndMinWidth;
  final bool leftEndFillVertical;
  final double leftEndTopHeight;
  final double rightEndMaxWidth;
  final double rightEndMinWidth;
  final bool rightEndFillVertical;
  final double rightEndTopHeight;
  final double bodyBottomHeight;
  final double bottomHeight;
  final Alignment bodyAlignment;

  static const defaultValues = DimensionsConfig();

  DimensionsConfig merge(PersistentDimensionsConfig config) {
    return DimensionsConfig(
      topHeight: config.topHeight ?? topHeight,
      bodyTopHeight: config.bodyTopHeight ?? bodyTopHeight,
      bodyMaxWidth: config.bodyMaxWidth ?? bodyMaxWidth,
      bodyMinWidth: config.bodyMinWidth ?? bodyMinWidth,
      leftEndMaxWidth: config.leftEndMaxWidth ?? leftEndMaxWidth,
      leftEndMinWidth: config.leftEndMinWidth ?? leftEndMinWidth,
      leftEndFillVertical: config.leftEndFillVertical ?? leftEndFillVertical,
      leftEndTopHeight: config.leftEndTopHeight ?? leftEndTopHeight,
      rightEndMaxWidth: config.rightEndMaxWidth ?? rightEndMaxWidth,
      rightEndMinWidth: config.rightEndMinWidth ?? rightEndMinWidth,
      rightEndFillVertical: config.rightEndFillVertical ?? rightEndFillVertical,
      rightEndTopHeight: config.rightEndTopHeight ?? rightEndTopHeight,
      bodyBottomHeight: config.bodyBottomHeight ?? bodyBottomHeight,
      bottomHeight: config.bottomHeight ?? bottomHeight,
      bodyAlignment: config.bodyAlignment ?? bodyAlignment,
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
