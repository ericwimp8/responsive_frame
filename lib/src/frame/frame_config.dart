import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  final List<FrameBodyListChild>? body;
  final Widget? top;
  final Widget? bodyTop;
  final Widget? leftEnd;
  final Widget? leftEndTop;
  final Widget? rightEnd;
  final Widget? rightEndTop;
  final Widget? bodyBottom;
  final Widget? bottom;
  final DimensionsConfig dimensions;

  @override
  String toString() {
    return 'FrameConfig(body: $body, top: $top, bodyTop: $bodyTop, leftEnd: $leftEnd, leftEndTop: $leftEndTop, rightEnd: $rightEnd, rightEndTop: $rightEndTop, bodyBottom: $bodyBottom, bottom: $bottom, dimensions: $dimensions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FrameConfig &&
        listEquals(other.body, body) &&
        other.top == top &&
        other.bodyTop == bodyTop &&
        other.leftEnd == leftEnd &&
        other.leftEndTop == leftEndTop &&
        other.rightEnd == rightEnd &&
        other.rightEndTop == rightEndTop &&
        other.bodyBottom == bodyBottom &&
        other.bottom == bottom &&
        other.dimensions == dimensions;
  }

  @override
  int get hashCode {
    return body.hashCode ^
        top.hashCode ^
        bodyTop.hashCode ^
        leftEnd.hashCode ^
        leftEndTop.hashCode ^
        rightEnd.hashCode ^
        rightEndTop.hashCode ^
        bodyBottom.hashCode ^
        bottom.hashCode ^
        dimensions.hashCode;
  }

  FrameConfig copyWith({
    List<FrameBodyListChild>? body,
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
}
