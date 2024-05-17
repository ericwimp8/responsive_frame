import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides a consistent frame structure for responsive layouts.
///
/// The [Frame] widget provides a consistent frame structure for responsive
/// layouts. It allows you to define different widgets to render in each of the
/// frame's slots, such as the top, left end, body, right end, and bottom slots.
///
/// The [Frame] widget also supports animations for changes to the layout. You can
/// customize the animation using the [animations] property.
///
/// The [dimensions] property can be used to define the dimensions of each slot.
/// You can use this property to control the maximum height and width of each slot,
/// as well as whether the left end and right end slots should fill the vertical
/// space of the frame.
///
/// {@tool snippet}
/// This example shows how to use the [Frame] widget to create a frame structure
/// with different widgets in each slot.
///
/// ```dart
/// Frame(
///   body: const Text('Body'),
///   top: const Text('Top'),
///   leftEnd: const Text('Left End'),
///   rightEnd: const Text('Right End'),
///   bottom: const Text('Bottom'),
///   dimensions: DimensionsConfig(
///     leftEndMaxWidth: 200,
///     rightEndMaxWidth: 200,
///     bodyMaxWidth: 600,
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [FrameConfig]
///  * [DimensionsConfig]
///  * [FrameVerticalEnd]
///  * [FrameHorizontalEnd]
///  * [ResponsiveFrameLayout]
class Frame extends StatelessWidget {
  /// Creates a new [Frame] widget.
  ///
  /// The [body] property is the widget to render in the body slot. The
  /// [top], [leftEnd], [rightEnd], and [bottom] properties are the widgets to
  /// render in the corresponding slots. The [dimensions] property can be used to
  /// define the dimensions of each slot. The [animations] property can be used
  /// to disable animations for changes to the layout.
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

  /// Whether to animate changes to the layout.
  final bool animations;

  /// The widget to render in the body slot.
  final Widget body;

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

  /// The background color of the frame.
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
                            kDefaultFillVertical)
                    ? FrameHorizontalEnd(
                        maxWidth: dimensions?.leftEndMaxWidth,
                        minWidth: dimensions?.leftEndMinWidth,
                        topMaxHeight: dimensions?.leftEndTopMaxHeight,
                        topMinHeight: dimensions?.leftEndTopMinHeight,
                        top: leftEndTop != null &&
                                (dimensions?.leftEndFillVertical ??
                                    kDefaultFillVertical)
                            ? leftEndTop!
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
                                    !(dimensions?.leftEndFillVertical ??
                                        kDefaultFillVertical)
                                ? FrameHorizontalEnd(
                                    top: leftEndTop != null &&
                                            !(dimensions?.leftEndFillVertical ??
                                                kDefaultFillVertical)
                                        ? leftEndTop
                                        : null,
                                    maxWidth: dimensions?.leftEndMaxWidth,
                                    minWidth: dimensions?.leftEndMinWidth,
                                    topMaxHeight:
                                        dimensions?.leftEndTopMaxHeight,
                                    topMinHeight:
                                        dimensions?.leftEndTopMinHeight,
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
                                  minWidth: dimensions?.bodyMinWidth ?? 0.0,
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
                                    !(dimensions?.rightEndFillVertical ??
                                        kDefaultFillVertical)
                                ? FrameHorizontalEnd(
                                    top: rightEndTop != null &&
                                            !(dimensions
                                                    ?.rightEndFillVertical ??
                                                kDefaultFillVertical)
                                        ? rightEndTop
                                        : null,
                                    topMaxHeight:
                                        dimensions?.rightEndTopMaxHeight,
                                    topMinHeight:
                                        dimensions?.rightEndTopMinHeight,
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
                child: (dimensions?.rightEndFillVertical ??
                            kDefaultFillVertical) &&
                        rightEnd != null
                    ? FrameHorizontalEnd(
                        top: (dimensions?.rightEndFillVertical ??
                                    kDefaultFillVertical) &&
                                rightEndTop != null
                            ? rightEndTop
                            : null,
                        maxWidth: dimensions?.rightEndMaxWidth,
                        minWidth: dimensions?.rightEndMinWidth,
                        topMaxHeight: dimensions?.rightEndTopMaxHeight,
                        topMinHeight: dimensions?.rightEndTopMinHeight,
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
