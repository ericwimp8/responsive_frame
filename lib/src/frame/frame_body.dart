import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:responsive_frame/src/frame/constants.dart';

class FrameBody extends StatelessWidget {
  const FrameBody({
    required this.children,
    required this.isInit,
    this.bodyAlignment = kDefaultBodyAlignment,
    this.maxWidth = kDefaultBodyMaxWidth,
    this.minWidth = kDefaultBodyMinWidth,
    super.key,
  });
  final List<FrameBodyListChild> children;
  final Alignment bodyAlignment;
  final double maxWidth;
  final double minWidth;
  final bool isInit;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: bodyAlignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          minWidth: minWidth,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalFlex = children.fold(
              0,
              (previousValue, element) => previousValue + element.flex,
            );
            final oneFlex = constraints.maxWidth / totalFlex;
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children
                    .map(
                      (e) => AnimationChild(
                        animations: isInit,
                        width: e.flex * oneFlex,
                        child: e.child,
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AnimationChild extends StatefulWidget {
  const AnimationChild({
    required this.child,
    required this.width,
    required this.animations,
    super.key,
  });
  final Widget child;
  final double width;

  final bool animations;

  @override
  State<AnimationChild> createState() => _AnimationChildState();
}

class _AnimationChildState extends State<AnimationChild>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;
  late final double initialWidth;
  @override
  void initState() {
    initialWidth = widget.width;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _animation = _controller!.drive(Tween<double>(begin: 0, end: widget.width));
    _controller!.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animations) {
      return AnimatedBuilder(
        builder: (context, child) {
          return AnimatedConstrainedBox(
            duration: const Duration(milliseconds: 180),
            constraints: BoxConstraints(
              maxWidth:
                  _controller!.isCompleted ? widget.width : _animation.value,
            ),
            child: child,
          );
        },
        animation: _animation,
        child: widget.child,
      );
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.width,
      ),
      child: widget.child,
    );
  }
}

class FrameBodyListChild {
  const FrameBodyListChild({
    required this.child,
    this.flex = 1,
  });

  final int flex;
  final Widget child;
}
