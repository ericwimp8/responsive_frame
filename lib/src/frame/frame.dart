// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

class Frame extends StatelessWidget {
  const Frame({
    required this.body,
    this.animations = true,
    this.top,
    this.topHeight = kDefaultVerticalEndHeight,
    this.bodyTop,
    this.bodyTopHeight = kDefaultVerticalEndHeight,
    this.bodyAlignment = Alignment.topCenter,
    this.bodyMaxWidth = 950,
    this.bodyMinWidth = 0,
    this.leftEnd,
    this.leftEndTop,
    this.leftEndMaxWidth = kDefaultHorizontalEndWidth,
    this.leftEndMinWidth = kDefaultHorizontalEndWidth,
    this.leftEndTopHeight = kDefaultVerticalEndHeight,
    this.leftEndFillVertical = true,
    this.rightEnd,
    this.rightEndTop,
    this.rightEndMaxWidth = kDefaultHorizontalEndWidth,
    this.rightEndMinWidth = kDefaultHorizontalEndWidth,
    this.rightEndTopHeight = kDefaultVerticalEndHeight,
    this.rightEndFillVertical = true,
    this.bodyBottom,
    this.bodyBottomHeight = kDefaultVerticalEndHeight,
    this.bottom,
    this.bottomHeight = kDefaultVerticalEndHeight,
    super.key,
  });
  final bool animations;
  final List<FrameBodyListChild> body;
  final Widget? top;
  final double topHeight;
  final Widget? bodyTop;
  final double bodyTopHeight;
  final Alignment bodyAlignment;
  final double bodyMaxWidth;
  final double bodyMinWidth;
  final Widget? leftEnd;
  final Widget? leftEndTop;
  final double leftEndMaxWidth;
  final double leftEndMinWidth;
  final bool leftEndFillVertical;
  final double leftEndTopHeight;
  final Widget? rightEnd;
  final Widget? rightEndTop;
  final double rightEndMaxWidth;
  final double rightEndMinWidth;
  final bool rightEndFillVertical;
  final double rightEndTopHeight;
  final Widget? bodyBottom;
  final double bodyBottomHeight;
  final Widget? bottom;
  final double bottomHeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AnimatedShowHide(
            animate: animations,
            child: top != null
                ? FrameVerticalEnd(
                    height: topHeight,
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
                  child: leftEnd != null && leftEndFillVertical ||
                          leftEnd != null && leftEndTop != null
                      ? FrameHorizontalEnd(
                          body: AnimatedShowHide(
                            animate: animations,
                            axis: Axis.horizontal,
                            child: leftEnd != null && leftEndFillVertical ||
                                    leftEnd != null && leftEndTop != null
                                ? leftEnd
                                : null,
                          ),
                          top: AnimatedShowHide(
                            animate: animations,
                            axis: Axis.horizontal,
                            child: leftEnd != null && leftEndFillVertical ||
                                    leftEnd != null && leftEndTop != null
                                ? FrameVerticalEnd(child: leftEndTop!)
                                : null,
                          ),
                          maxWidth: leftEndMaxWidth,
                          minWidth: leftEndMinWidth,
                          fillVertical: leftEndFillVertical,
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
                                height: bodyTopHeight,
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
                                      !leftEndFillVertical
                                  ? FrameHorizontalEnd(
                                      body: leftEnd!,
                                      top: leftEndTop,
                                      maxWidth: leftEndMaxWidth,
                                      minWidth: leftEndMinWidth,
                                      fillVertical: leftEndFillVertical,
                                    )
                                  : null,
                            ),
                            Expanded(
                              child: AnimatedShowHide(
                                axis: Axis.horizontal,
                                animate: animations,
                                child: FrameBody(
                                  isInit: animations,
                                  bodyAlignment: bodyAlignment,
                                  maxWidth: bodyMaxWidth,
                                  minWidth: bodyMinWidth,
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
                                      !rightEndFillVertical
                                  ? FrameHorizontalEnd(
                                      body: rightEnd!,
                                      top: rightEndTop,
                                      maxWidth: rightEndMaxWidth,
                                      minWidth: rightEndMinWidth,
                                      fillVertical: rightEndFillVertical,
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
                                height: bodyBottomHeight,
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
                  child: rightEnd != null && rightEndFillVertical ||
                          rightEnd != null && rightEndTop != null
                      ? FrameHorizontalEnd(
                          body: rightEnd!,
                          top: rightEndTop,
                          maxWidth: rightEndMaxWidth,
                          minWidth: rightEndMinWidth,
                          fillVertical: rightEndFillVertical,
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
                    height: bottomHeight,
                    child: bottom!,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
