import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// Represents the configuration for a [Frame].
///
///```dart
/// // Create a new FrameConfig instance with some values
/// FrameConfig config = FrameConfig(
///   body: Container(color: Colors.blue),
///   top: Text('Top Widget'),
///   leftEnd: MyMenu(),
///   dimensions: MyDimensions,
/// );
/// ```
/// see [Frame], [ResponsiveFrameLayout], [ResponsiveFrameLayoutGranular]
@immutable
class FrameConfig {
  /// Creates a new [FrameConfig] instance. to be used in [Frame]
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

  /// The main content of the frame.
  final Widget? body;

  /// The widget to be displayed at the top of the frame.
  final Widget? top;

  /// The widget to be displayed at the top of the body.
  final Widget? bodyTop;

  /// The widget to be displayed at the left end of the frame.
  final Widget? leftEnd;

  /// The widget to be displayed at the top of the left end of the frame.
  final Widget? leftEndTop;

  /// The widget to be displayed at the right end of the frame.
  final Widget? rightEnd;

  /// The widget to be displayed at the top of the right end of the frame.
  final Widget? rightEndTop;

  /// The widget to be displayed at the bottom of the body.
  final Widget? bodyBottom;

  /// The widget to be displayed at the bottom of the frame.
  final Widget? bottom;

  /// The dimensions configuration of the frame.
  final DimensionsConfig? dimensions;

  static const empty = FrameConfig();

  /// Merges the current FrameConfig with another one.
  /// Uses local values if not null, otherwise uses values from the provided config.
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

  /// Creates a copy of the current FrameConfig with optional new values provided.
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
