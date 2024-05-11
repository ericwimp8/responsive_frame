import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

@immutable
class FrameConfig {
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

  final Widget? body;
  final Widget? top;
  final Widget? bodyTop;
  final Widget? leftEnd;
  final Widget? leftEndTop;
  final Widget? rightEnd;
  final Widget? rightEndTop;
  final Widget? bodyBottom;
  final Widget? bottom;
  final DimensionsConfig? dimensions;

  static const empty = FrameConfig();

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
