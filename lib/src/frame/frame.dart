// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:responsive_frame/responsive_frame.dart';

class Frame extends StatelessWidget {
  const Frame({
    required this.body,
    this.dimensions = DimensionsConfig.empty,
    this.backgroundColor,
    this.animations = true,
    this.top,
    this.bodyTop,
    this.leftEnd,
    this.leftEndTop,
    this.rightEnd,
    this.rightEndTop,
    this.bodyBottom,
    this.bottom,
    super.key,
  });
  final bool animations;
  final Widget body;
  final Widget? top;
  final Widget? bodyTop;
  final Widget? leftEnd;
  final Widget? leftEndTop;
  final Widget? rightEnd;
  final Widget? rightEndTop;
  final Widget? bodyBottom;
  final Widget? bottom;
  final DimensionsConfig? dimensions;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedShowHide(
          animate: animations,
          child: top != null
              ? FrameVerticalEnd(
                  maxHeight: dimensions?.topMaxHeight,
                  minHeight: dimensions?.topMinHeight,
                  child: top!,
                )
              : null,
        ),
        Expanded(
          child: Row(
            children: [
              AnimatedShowHide(
                axis: Axis.horizontal,
                animate: animations,
                child: leftEnd != null &&
                            (dimensions?.leftEndFillVertical ??
                                kDefaultFillVertical) ||
                        leftEnd != null && leftEndTop != null
                    ? FrameHorizontalEnd(
                        maxWidth: dimensions?.leftEndMaxWidth,
                        minWidth: dimensions?.leftEndMinWidth,
                        top: leftEndTop != null &&
                                    (dimensions?.leftEndFillVertical ??
                                        kDefaultFillVertical) ||
                                leftEndTop != null && leftEndTop != null
                            ? FrameVerticalEnd(
                                maxHeight: dimensions?.leftEndTopMaxHeight,
                                minHeight: dimensions?.leftEndTopMinHeight,
                                child: leftEndTop!,
                              )
                            : null,
                        child: leftEnd!,
                      )
                    : null,
              ),
              Expanded(
                child: Column(
                  children: [
                    AnimatedShowHide(
                      animate: animations,
                      child: bodyTop != null
                          ? FrameVerticalEnd(
                              maxHeight: dimensions?.bodyTopMaxHeight,
                              minHeight: dimensions?.bodyTopMinHeight,
                              child: bodyTop!,
                            )
                          : null,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          AnimatedShowHide(
                            animate: animations,
                            axis: Axis.horizontal,
                            child: leftEnd != null &&
                                    leftEndTop == null &&
                                    !(dimensions?.leftEndFillVertical ??
                                        kDefaultFillVertical)
                                ? FrameHorizontalEnd(
                                    top: leftEndTop,
                                    maxWidth: dimensions?.leftEndMaxWidth,
                                    minWidth: dimensions?.leftEndMinWidth,
                                    child: leftEnd!,
                                  )
                                : null,
                          ),
                          Flexible(
                            child: Align(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: dimensions?.bodyMaxWidth ??
                                      double.infinity,
                                ),
                                child: AnimatedShowHide(
                                  axis: Axis.horizontal,
                                  animate: animations,
                                  child: body,
                                ),
                              ),
                            ),
                          ),
                          AnimatedShowHide(
                            animate: animations,
                            axis: Axis.horizontal,
                            child: rightEnd != null &&
                                    rightEndTop == null &&
                                    !(dimensions?.rightEndFillVertical ??
                                        kDefaultFillVertical)
                                ? FrameHorizontalEnd(
                                    top: rightEndTop,
                                    maxWidth: dimensions?.rightEndMaxWidth,
                                    minWidth: dimensions?.rightEndMinWidth,
                                    child: rightEnd!,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                    AnimatedShowHide(
                      animate: animations,
                      child: bodyBottom != null
                          ? FrameVerticalEnd(
                              maxHeight: dimensions?.bodyBottomMaxHeight,
                              minHeight: dimensions?.bodyBottomMinHeight,
                              child: bodyBottom!,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              AnimatedShowHide(
                animate: animations,
                axis: Axis.horizontal,
                child: rightEnd != null &&
                            (dimensions?.rightEndFillVertical ??
                                kDefaultFillVertical) ||
                        rightEnd != null && rightEndTop != null
                    ? FrameHorizontalEnd(
                        top: rightEndTop,
                        maxWidth: dimensions?.rightEndMaxWidth,
                        minWidth: dimensions?.rightEndMinWidth,
                        child: rightEnd!,
                      )
                    : null,
              ),
            ],
          ),
        ),
        AnimatedShowHide(
          animate: animations,
          child: bottom != null
              ? FrameVerticalEnd(
                  maxHeight: dimensions?.bottomMaxHeight,
                  minHeight: dimensions?.bottomMinHeight,
                  child: bottom!,
                )
              : null,
        ),
      ],
    );
  }
}
