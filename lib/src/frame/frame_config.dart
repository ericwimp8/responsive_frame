import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A configuration for a [Frame] widget.
///
/// The [FrameConfig] class defines the widgets to render in each of the
/// [Frame]'s slots, as well as the dimensions of each slot.
///
/// You can use the [FrameConfig] class to create different layouts for different
/// screen sizes. For example, you could create a [FrameConfig] for a small
/// screen size that only renders the body widget, and a [FrameConfig] for a
/// large screen size that renders the body widget, as well as the top, left end,
/// and right end widgets.
///
/// {@macro responsive_frame_layout}
///
/// See also:
///
///  * [Frame]
///  * [ResponsiveFrameLayout]
@immutable
class FrameConfig {
  /// Creates a new [FrameConfig] object.
  ///
  /// The [body], [top], [bodyTop], [leftEnd], [leftEndTop], [rightEnd],
  /// [rightEndTop], [bodyBottom], and [bottom] properties define the widgets to
  /// render in each of the [Frame]'s slots. The [dimensions] property defines
  /// the dimensions of each slot.
  const FrameConfig({
    this.body,
    this.top,
    this.bodyTop,
    this.leftEnd,
    this.leftEndTop,
    this.rightEnd,
    this.rightEndTop,
    this.bodyBottom,
    this.bottom,
    this.dimensions = DimensionsConfig.empty,
  });

  /// The widget to render in the body slot.
  final Widget? body;

  /// The widget to render in the top slot.
  final Widget? top;

  /// The widget to render in the body top slot.
  final Widget? bodyTop;

  /// The widget to render in the left end slot.
  final Widget? leftEnd;

  /// The widget to render in the left end top slot.
  final Widget? leftEndTop;

  /// The widget to render in the right end slot.
  final Widget? rightEnd;

  /// The widget to render in the right end top slot.
  final Widget? rightEndTop;

  /// The widget to render in the body bottom slot.
  final Widget? bodyBottom;

  /// The widget to render in the bottom slot.
  final Widget? bottom;

  /// The dimensions of each slot.
  final DimensionsConfig? dimensions;

  /// An empty [FrameConfig] object.
  static const empty = FrameConfig();

  /// Merges this [FrameConfig] object with another [FrameConfig] object.
  ///
  /// The [other] parameter is the [FrameConfig] object to merge with. The
  /// merged object will contain the values of this object, with any null values
  /// replaced with the corresponding values from the [other] object.
  FrameConfig merge(FrameConfig other) {
    return FrameConfig(
      body: body ?? other.body,
      top: top ?? other.top,
      bodyTop: bodyTop ?? other.bodyTop,
      leftEnd: leftEnd ?? other.leftEnd,
      leftEndTop: leftEndTop ?? other.leftEndTop,
      rightEnd: rightEnd ?? other.rightEnd,
      rightEndTop: rightEndTop ?? other.rightEndTop,
      bodyBottom: bodyBottom ?? other.bodyBottom,
      bottom: bottom ?? other.bottom,
      dimensions: dimensions?.merge(other.dimensions),
    );
  }

  /// Creates a copy of this [FrameConfig] object with the given properties
  /// replaced.
  ///
  /// The [body], [top], [bodyTop], [leftEnd], [leftEndTop], [rightEnd],
  /// [rightEndTop], [bodyBottom], [bottom], and [dimensions] parameters can be
  /// used to replace the corresponding properties of this object.
  FrameConfig copyWith({
    Widget? body,
    Widget? top,
    Widget? bodyTop,
    Widget? leftEnd,
    Widget? leftEndTop,
    Widget? rightEnd,
    Widget? rightEndTop,
    Widget? bodyBottom,
    Widget? bottom,
    DimensionsConfig? dimensions,
  }) {
    return FrameConfig(
      body: body ?? this.body,
      top: top ?? this.top,
      bodyTop: bodyTop ?? this.bodyTop,
      leftEnd: leftEnd ?? this.leftEnd,
      leftEndTop: leftEndTop ?? this.leftEndTop,
      rightEnd: rightEnd ?? this.rightEnd,
      rightEndTop: rightEndTop ?? this.rightEndTop,
      bodyBottom: bodyBottom ?? this.bodyBottom,
      bottom: bottom ?? this.bottom,
      dimensions: dimensions ?? this.dimensions,
    );
  }

  @override
  String toString() {
    return 'FrameConfig(body: $body, top: $top, bodyTop: $bodyTop, leftEnd: $leftEnd, leftEndTop: $leftEndTop, rightEnd: $rightEnd, rightEndTop: $rightEndTop, bodyBottom: $bodyBottom, bottom: $bottom, dimensions: $dimensions)';
  }
}
