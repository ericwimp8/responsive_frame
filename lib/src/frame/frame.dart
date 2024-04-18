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
  final List<FrameBodyListChild> body;
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
                  height: dimensions?.topHeight,
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
                        body: leftEnd!,
                        top: leftEndTop != null &&
                                    (dimensions?.leftEndFillVertical ??
                                        kDefaultFillVertical) ||
                                leftEndTop != null && leftEndTop != null
                            ? FrameVerticalEnd(child: leftEndTop!)
                            : null,
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
                              height: dimensions?.bodyTopHeight,
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
                                    body: leftEnd!,
                                    top: leftEndTop,
                                    maxWidth: dimensions?.leftEndMaxWidth,
                                    minWidth: dimensions?.leftEndMinWidth,
                                  )
                                : null,
                          ),
                          Expanded(
                            child: AnimatedShowHide(
                              axis: Axis.horizontal,
                              animate: animations,
                              child: FrameBody(
                                isInit: animations,
                                bodyAlignment: dimensions?.bodyAlignment,
                                maxWidth: dimensions?.bodyMaxWidth,
                                minWidth: dimensions?.bodyMinWidth,
                                children: body
                                    .map(
                                      (e) => FrameBodyListChild(
                                        flex: e.flex,
                                        child: e.child,
                                      ),
                                    )
                                    .toList(),
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
                                    body: rightEnd!,
                                    top: rightEndTop,
                                    maxWidth: dimensions?.rightEndMaxWidth,
                                    minWidth: dimensions?.rightEndMinWidth,
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
                              height: dimensions?.bodyBottomHeight,
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
                        body: rightEnd!,
                        top: rightEndTop,
                        maxWidth: dimensions?.rightEndMaxWidth,
                        minWidth: dimensions?.rightEndMinWidth,
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
                  height: dimensions?.bottomHeight,
                  child: bottom!,
                )
              : null,
        ),
      ],
    );
  }
}
