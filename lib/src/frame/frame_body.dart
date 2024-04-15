import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class FrameBody extends StatelessWidget {
  const FrameBody({
    required this.model,
    super.key,
  });

  final BodyModel model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: model.bodyAlignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 950),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final i in model.children)
              Flexible(flex: i.flex + 1, child: i.child),
          ],
        ),
      ),
    );
  }
}
