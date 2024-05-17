import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Provides the configuration for a [Frame].
///
/// Dimensions configuration for a [Frame].
/// see [FrameConfig.dimensions]
///
/// ##Example
/// ```dart
///   DimensionsConfig frameDimensions = DimensionsConfig(
///     topMaxHeight: 100.0,
///     topMinHeight: 50.0,
///     bodyTopMaxHeight: 200.0,
///     bodyTopMinHeight: 100.0,
///     bodyMaxWidth: 500.0,
///     bodyMinWidth: 300.0,
///     leftEndMaxWidth: 150.0,
///     leftEndMinWidth: 100.0,
///     leftEndFillVertical: true,
///     leftEndTopMaxHeight: 150.0,
///     leftEndTopMinHeight: 100.0,
///     rightEndMaxWidth: 150.0,
///     rightEndMinWidth: 100.0,
///     rightEndFillVertical: true,
///     rightEndTopMaxHeight: 150.0,
///     rightEndTopMinHeight: 100.0,
///     bodyBottomMaxHeight: 200.0,
///     bodyBottomMinHeight: 100.0,
///     bottomMaxHeight: 100.0,
///     bottomMinHeight: 50.0,
///     bodyAlignment: Alignment.center,
///  );
/// ```

@immutable
class DimensionsConfig {
  /// Constructs a DimensionsConfig with the provided dimensions.
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
    this.leftEndTopMaxHeight,
    this.leftEndTopMinHeight,
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

  /// The maximum height of the widget at the top of the frame.
  final double? topMaxHeight;

  /// The minimum height of the widget at the top of the frame.
  final double? topMinHeight;

  /// The maximum height of the widget at the top of the body.
  final double? bodyTopMaxHeight;

  /// The minimum height of the widget at the top of the body.
  final double? bodyTopMinHeight;

  /// The maximum width of the body widget.
  final double? bodyMaxWidth;

  /// The minimum width of the body widget.
  final double? bodyMinWidth;

  /// The maximum width of the left end widget.
  final double? leftEndMaxWidth;

  /// The minimum width of the left end widget.
  final double? leftEndMinWidth;

  /// Whether the left end widget should fill the vertical space.
  final bool? leftEndFillVertical;

  /// The maximum height of the widget at the top of the left end.
  final double? leftEndTopMaxHeight;

  /// The minimum height of the widget at the top of the left end.
  final double? leftEndTopMinHeight;

  /// The maximum width of the right end widget.
  final double? rightEndMaxWidth;

  /// The minimum width of the right end widget.
  final double? rightEndMinWidth;

  /// Whether the right end widget should fill the vertical space.
  final bool? rightEndFillVertical;

  /// The maximum height of the widget at the top of the right end.
  final double? rightEndTopMaxHeight;

  /// The minimum height of the widget at the top of the right end.
  final double? rightEndTopMinHeight;

  /// The maximum height of the widget at the bottom of the body.
  final double? bodyBottomMaxHeight;

  /// The minimum height of the widget at the bottom of the body.
  final double? bodyBottomMinHeight;

  /// The maximum height of the widget at the bottom of the frame.
  final double? bottomMaxHeight;

  /// The minimum height of the widget at the bottom of the frame.
  final double? bottomMinHeight;

  /// The alignment of the body widget within the frame.
  final Alignment? bodyAlignment;

  static const empty = DimensionsConfig();

  /// Merges the current DimensionsConfig with another one.
  /// Uses local values if not null, otherwise uses values from the provided config.
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

  /// Creates a copy of the DimensionsConfig with provided dimensions overridden.
  DimensionsConfig copyWith({
    double? topMaxHeight,
    double? topMinHeight,
    double? bodyTopMaxHeight,
    double? bodyTopMinHeight,
    double? bodyMaxWidth,
    double? bodyMinWidth,
    double? leftEndMaxWidth,
    double? leftEndMinWidth,
    bool? leftEndFillVertical,
    double? leftEndTopMaxHeight,
    double? leftEndTopMinHeight,
    double? rightEndMaxWidth,
    double? rightEndMinWidth,
    bool? rightEndFillVertical,
    double? rightEndTopMaxHeight,
    double? rightEndTopMinHeight,
    double? bodyBottomMaxHeight,
    double? bodyBottomMinHeight,
    double? bottomMaxHeight,
    double? bottomMinHeight,
    Alignment? bodyAlignment,
  }) {
    return DimensionsConfig(
      topMaxHeight: topMaxHeight ?? this.topMaxHeight,
      topMinHeight: topMinHeight ?? this.topMinHeight,
      bodyTopMaxHeight: bodyTopMaxHeight ?? this.bodyTopMaxHeight,
      bodyTopMinHeight: bodyTopMinHeight ?? this.bodyTopMinHeight,
      bodyMaxWidth: bodyMaxWidth ?? this.bodyMaxWidth,
      bodyMinWidth: bodyMinWidth ?? this.bodyMinWidth,
      leftEndMaxWidth: leftEndMaxWidth ?? this.leftEndMaxWidth,
      leftEndMinWidth: leftEndMinWidth ?? this.leftEndMinWidth,
      leftEndFillVertical: leftEndFillVertical ?? this.leftEndFillVertical,
      leftEndTopMaxHeight: leftEndTopMaxHeight ?? this.leftEndTopMaxHeight,
      leftEndTopMinHeight: leftEndTopMinHeight ?? this.leftEndTopMinHeight,
      rightEndMaxWidth: rightEndMaxWidth ?? this.rightEndMaxWidth,
      rightEndMinWidth: rightEndMinWidth ?? this.rightEndMinWidth,
      rightEndFillVertical: rightEndFillVertical ?? this.rightEndFillVertical,
      rightEndTopMaxHeight: rightEndTopMaxHeight ?? this.rightEndTopMaxHeight,
      rightEndTopMinHeight: rightEndTopMinHeight ?? this.rightEndTopMinHeight,
      bodyBottomMaxHeight: bodyBottomMaxHeight ?? this.bodyBottomMaxHeight,
      bodyBottomMinHeight: bodyBottomMinHeight ?? this.bodyBottomMinHeight,
      bottomMaxHeight: bottomMaxHeight ?? this.bottomMaxHeight,
      bottomMinHeight: bottomMinHeight ?? this.bottomMinHeight,
      bodyAlignment: bodyAlignment ?? this.bodyAlignment,
    );
  }

  @override
  String toString() {
    return 'DimensionsConfig(topMaxHeight: $topMaxHeight, topMinHeight: $topMinHeight, bodyTopMaxHeight: $bodyTopMaxHeight, bodyTopMinHeight: $bodyTopMinHeight, bodyMaxWidth: $bodyMaxWidth, bodyMinWidth: $bodyMinWidth, leftEndMaxWidth: $leftEndMaxWidth, leftEndMinWidth: $leftEndMinWidth, leftEndFillVertical: $leftEndFillVertical, leftEndTopMaxHeight: $leftEndTopMaxHeight, leftEndTopMinHeight: $leftEndTopMinHeight, rightEndMaxWidth: $rightEndMaxWidth, rightEndMinWidth: $rightEndMinWidth, rightEndFillVertical: $rightEndFillVertical, rightEndTopMaxHeight: $rightEndTopMaxHeight, rightEndTopMinHeight: $rightEndTopMinHeight, bodyBottomMaxHeight: $bodyBottomMaxHeight, bodyBottomMinHeight: $bodyBottomMinHeight, bottomMaxHeight: $bottomMaxHeight, bottomMinHeight: $bottomMinHeight, bodyAlignment: $bodyAlignment)';
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
        other.bodyMinWidth == bodyMinWidth &&
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
        bodyMinWidth.hashCode ^
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
