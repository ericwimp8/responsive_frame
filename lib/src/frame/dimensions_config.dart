import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A configuration for the dimensions of a [Frame] widget.
///
/// The [DimensionsConfig] class defines the dimensions of each slot in a
/// [Frame] widget. You can use this class to control the maximum height and
/// width of each slot, as well as whether the left end and right end slots
/// should fill the vertical space of the frame.
///
/// The [DimensionsConfig] class can be used to create different layouts for
/// different screen sizes. For example, you could create a [DimensionsConfig]
/// for a small screen size that sets the maximum width of the body slot to
/// 600 pixels, and a [DimensionsConfig] for a large screen size that sets the
/// maximum width of the body slot to 950 pixels.
///
/// {@tool snippet}
/// This example shows how to use the [DimensionsConfig] class to create
/// different layouts for different screen sizes.
///
/// ```dart
/// ResponsiveFrameLayout(
///   small: (context) => FrameConfig(
///     body: const Text('Small layout'),
///     dimensions: DimensionsConfig(
///       bodyMaxWidth: 600,
///     ),
///   ),
///   large: (context) => FrameConfig(
///     body: const Text('Large layout'),
///     dimensions: DimensionsConfig(
///       bodyMaxWidth: 950,
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Frame]
///  * [FrameConfig]
///  * [ResponsiveFrameLayout]
@immutable
class DimensionsConfig {
  /// Creates a new [DimensionsConfig] object.
  ///
  /// The [topMaxHeight], [topMinHeight], [bodyTopMaxHeight],
  /// [bodyTopMinHeight], [bodyMaxWidth], [bodyMinWidth], [leftEndMaxWidth],
  /// [leftEndMinWidth], [leftEndFillVertical], [leftEndTopMaxHeight],
  /// [leftEndTopMinHeight], [rightEndMaxWidth], [rightEndMinWidth],
  /// [rightEndFillVertical], [rightEndTopMaxHeight], [rightEndTopMinHeight],
  /// [bodyBottomMaxHeight], [bodyBottomMinHeight], [bottomMaxHeight],
  /// [bottomMinHeight], and [bodyAlignment] properties define the dimensions
  /// of each slot in a [Frame] widget.
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

  /// The maximum height of the top slot.
  final double? topMaxHeight;

  /// The minimum height of the top slot.
  final double? topMinHeight;

  /// The maximum height of the body top slot.
  final double? bodyTopMaxHeight;

  /// The minimum height of the body top slot.
  final double? bodyTopMinHeight;

  /// The maximum width of the body slot.
  final double? bodyMaxWidth;

  /// The minimum width of the body slot.
  final double? bodyMinWidth;

  /// The maximum width of the left end slot.
  final double? leftEndMaxWidth;

  /// The minimum width of the left end slot.
  final double? leftEndMinWidth;

  /// Whether the left end slot should fill the vertical space of the frame.
  final bool? leftEndFillVertical;

  /// The maximum height of the left end top slot.
  final double? leftEndTopMaxHeight;

  /// The minimum height of the left end top slot.
  final double? leftEndTopMinHeight;

  /// The maximum width of the right end slot.
  final double? rightEndMaxWidth;

  /// The minimum width of the right end slot.
  final double? rightEndMinWidth;

  /// Whether the right end slot should fill the vertical space of the frame.
  final bool? rightEndFillVertical;

  /// The maximum height of the right end top slot.
  final double? rightEndTopMaxHeight;

  /// The minimum height of the right end top slot.
  final double? rightEndTopMinHeight;

  /// The maximum height of the body bottom slot.
  final double? bodyBottomMaxHeight;

  /// The minimum height of the body bottom slot.
  final double? bodyBottomMinHeight;

  /// The maximum height of the bottom slot.
  final double? bottomMaxHeight;

  /// The minimum height of the bottom slot.
  final double? bottomMinHeight;

  /// The alignment of the body slot.
  final Alignment? bodyAlignment;

  /// An empty [DimensionsConfig] object.
  static const empty = DimensionsConfig();

  /// Merges this [DimensionsConfig] object with another [DimensionsConfig]
  /// object.
  ///
  /// The [config] parameter is the [DimensionsConfig] object to merge with.
  /// The merged object will contain the values of this object, with any null
  /// values replaced with the corresponding values from the [config] object.
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

  /// Creates a copy of this [DimensionsConfig] object with the given properties
  /// replaced.
  ///
  /// The [topMaxHeight], [topMinHeight], [bodyTopMaxHeight],
  /// [bodyTopMinHeight], [bodyMaxWidth], [bodyMinWidth], [leftEndMaxWidth],
  /// [leftEndMinWidth], [leftEndFillVertical], [leftEndTopMaxHeight],
  /// [leftEndTopMinHeight], [rightEndMaxWidth], [rightEndMinWidth],
  /// [rightEndFillVertical], [rightEndTopMaxHeight], [rightEndTopMinHeight],
  /// [bodyBottomMaxHeight], [bodyBottomMinHeight], [bottomMaxHeight],
  /// [bottomMinHeight], and [bodyAlignment] parameters can be used to replace
  /// the corresponding properties of this object.
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
