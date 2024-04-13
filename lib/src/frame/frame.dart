// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

class Frame extends StatelessWidget {
  const Frame({
    required this.frameBody,
    super.key,
    this.bodyTop,
    this.bodyBottom,
    this.leftEnd,
    this.rightEnd,
    this.frameBottom,
    this.frameTop,
  });

  final FrameBodyModel Function(BuildContext) frameBody;
  final FrameHorizontalEndModel? Function(BuildContext)? rightEnd;
  final FrameHorizontalEndModel? Function(BuildContext)? leftEnd;
  final FrameVerticalEndModel? Function(BuildContext)? frameTop;
  final FrameVerticalEndModel? Function(BuildContext)? bodyTop;
  final FrameVerticalEndModel? Function(BuildContext)? frameBottom;
  final FrameVerticalEndModel? Function(BuildContext)? bodyBottom;

  @override
  Widget build(BuildContext context) {
    final _frameBody = frameBody(context);
    final _leftEnd = leftEnd?.call(context);
    final _rightEnd = rightEnd?.call(context);
    final _bodyTop = bodyTop?.call(context);
    final _bodyBottom = bodyBottom?.call(context);
    final _frameTop = frameTop?.call(context);
    final _frameBottom = frameBottom?.call(context);
    return Material(
      child: Column(
        children: [
          if (_frameTop != null) FrameVerticalEnd(child: _frameTop),
          Expanded(
            child: Row(
              children: [
                if (_leftEnd != null && _leftEnd.fillVertical ||
                    _leftEnd != null && _leftEnd.top != null)
                  FrameHorizontalEnd(
                    model: _leftEnd,
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (_bodyTop != null)
                        FrameVerticalEnd(
                          child: _bodyTop,
                        ),
                      Expanded(
                        child: Row(
                          children: [
                            if (_leftEnd != null &&
                                _leftEnd.top == null &&
                                !_leftEnd.fillVertical)
                              FrameHorizontalEnd(
                                model: _leftEnd,
                              ),
                            Expanded(
                              child: FrameBody(
                                model: _frameBody,
                              ),
                            ),
                            if (_rightEnd != null &&
                                _rightEnd.top == null &&
                                !_rightEnd.fillVertical)
                              FrameHorizontalEnd(model: _rightEnd),
                          ],
                        ),
                      ),
                      if (_bodyBottom != null)
                        FrameVerticalEnd(
                          child: _bodyBottom,
                        ),
                    ],
                  ),
                ),
                if (_rightEnd != null && _rightEnd.fillVertical ||
                    _rightEnd != null && _rightEnd.top != null)
                  FrameHorizontalEnd(
                    model: _rightEnd,
                  ),
              ],
            ),
          ),
          if (_frameBottom != null) FrameVerticalEnd(child: _frameBottom),
        ],
      ),
    );
  }
}
