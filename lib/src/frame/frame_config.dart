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
      rightEnd: rightEnd ?? other.rightEndTop,
      bodyBottom: bodyBottom ?? other.bodyBottom,
      bottom: bottom ?? other.bodyBottom,
      dimensions: dimensions?.merge(other.dimensions),
    );
  }

  FrameConfig copyWith({
    ValueGetter<Widget?>? body,
    ValueGetter<Widget?>? top,
    ValueGetter<Widget?>? bodyTop,
    ValueGetter<Widget?>? leftEnd,
    ValueGetter<Widget?>? leftEndTop,
    ValueGetter<Widget?>? rightEnd,
    ValueGetter<Widget?>? rightEndTop,
    ValueGetter<Widget?>? bodyBottom,
    ValueGetter<Widget?>? bottom,
    ValueGetter<DimensionsConfig?>? dimensions,
  }) {
    return FrameConfig(
      body: body != null ? body() : this.body,
      top: top != null ? top() : this.top,
      bodyTop: bodyTop != null ? bodyTop() : this.bodyTop,
      leftEnd: leftEnd != null ? leftEnd() : this.leftEnd,
      leftEndTop: leftEndTop != null ? leftEndTop() : this.leftEndTop,
      rightEnd: rightEnd != null ? rightEnd() : this.rightEnd,
      rightEndTop: rightEndTop != null ? rightEndTop() : this.rightEndTop,
      bodyBottom: bodyBottom != null ? bodyBottom() : this.bodyBottom,
      bottom: bottom != null ? bottom() : this.bottom,
      dimensions: dimensions != null ? dimensions() : this.dimensions,
    );
  }

  @override
  String toString() {
    return 'FrameConfig(body: $body, top: $top, bodyTop: $bodyTop, leftEnd: $leftEnd, leftEndTop: $leftEndTop, rightEnd: $rightEnd, rightEndTop: $rightEndTop, bodyBottom: $bodyBottom, bottom: $bottom, dimensions: $dimensions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FrameConfig &&
        other.body == body &&
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
}
