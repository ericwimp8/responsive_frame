// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:responsive_frame/responsive_frame.dart';

/// A widget that provides a flexible layout structure for organizing content
/// within a frame.
///
/// The frame is divided into nine sections:
/// - **Top:** The area at the top of the frame.
/// - **Body Top:** The area at the top of the body section.
/// - **Left End:** The area on the left side of the frame.
/// - **Left End Top:** The area at the top of the left end section.
/// - **Body:** The central area of the frame, where the main content is displayed.
/// - **Right End:** The area on the right side of the frame.
/// - **Right End Top:** The area at the top of the right end section.
/// - **Body Bottom:** The area at the bottom of the body section.
/// - **Bottom:** The area at the bottom of the frame.
///
/// Each section can hold a widget, allowing you to arrange content in various
/// configurations. The [Frame] widget provides options for customizing the
/// dimensions and visibility of each section.
///
/// You can control the visibility of each section using the `animations` property.
/// When `animations` is set to `true`, sections can be animated in and out.
///
/// The dimensions of each section can be adjusted using the `dimensions` property,
/// which accepts a [DimensionsConfig] object. This allows you to define minimum and
/// maximum heights and widths for each section.
///
/// The `backgroundColor` property sets the background color of the frame.
///
/// ## Example Usage
///
/// ```dart
/// Frame(
///   animations: true,
///   dimensions: DimensionsConfig(
///     topMinHeight: 50,
///     topMaxHeight: 100,
///     bodyMaxWidth: 800,
///   ),
///   top: Text('Top Section'),
///   body: Container(
///     color: Colors.blue,
///     child: Center(child: Text('Body Section')),
///   ),
///   bottom: Text('Bottom Section'),
/// )
/// ```
///
/// In this example, the `Frame` widget displays a top section with a minimum
/// height of 50 and a maximum height of 100. The body section has a maximum
/// width of 800. The top and bottom sections contain text widgets.
class Frame extends StatelessWidget {
  /// Creates a [Frame] widget.
  ///
  /// The [body] parameter is required and represents the main content of the
  /// frame.
  ///
  /// The other parameters are optional and allow you to customize the layout
  /// and appearance of the frame.
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

  /// Whether to animate the visibility of sections.
  final bool animations;

  /// The main content of the frame.
  final Widget body;

  /// The widget to be displayed at the top of the frame.
  final Widget? top;

  /// The widget to be displayed at the top of the body section.
  final Widget? bodyTop;

  /// The widget to be displayed at the left end of the frame.
  final Widget? leftEnd;

  /// The widget to be displayed at the top of the left end section.
  final Widget? leftEndTop;

  /// The widget to be displayed at the right end of the frame.
  final Widget? rightEnd;

  /// The widget to be displayed at the top of the right end section.
  final Widget? rightEndTop;

  /// The widget to be displayed at the bottom of the body section.
  final Widget? bodyBottom;

  /// The widget to be displayed at the bottom of the frame.
  final Widget? bottom;

  /// The dimensions configuration of the frame.
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
