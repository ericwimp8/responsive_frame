import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class FrameHorizontalEnd extends StatelessWidget {
  const FrameHorizontalEnd({
    required this.model,
    super.key,
  });

  final FrameHorizontalEndModel model;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: model.maxWidth,
        minWidth: model.maxWidth,
      ),
      child: Column(
        children: [
          if (model.top != null)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: model.topHeight,
                minHeight: model.topHeight,
                minWidth: double.infinity,
              ),
              child: model.top,
            ),
          Expanded(child: model.body),
        ],
      ),
    );
  }
}
