import 'dart:math';

import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveFrameLayout extends StatelessWidget {
  const ResponsiveFrameLayout({
    required this.mobile,
    this.desktopLarge,
    this.desktop,
    this.tablet,
    this.watch,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.animations = true,
    this.persistentFrameConfig = FrameConfig.empty,
    this.backgroundColor,
    super.key,
  });

  final FrameConfig Function(BuildContext context) mobile;
  final FrameConfig Function(BuildContext context)? tablet;
  final FrameConfig Function(BuildContext context)? desktop;
  final FrameConfig Function(BuildContext context)? desktopLarge;
  final FrameConfig Function(BuildContext context)? watch;
  final Breakpoints<ScreenSize> breakpoints;
  final bool animations;
  final FrameConfig persistentFrameConfig;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BreakpointDataWidget(
      controllers: {
        'frameconfig': BreakpointsController<FrameConfig, ScreenSize>(
          callbacks: {
            ScreenSize.desktopLarge: desktopLarge,
            ScreenSize.desktop: desktop,
            ScreenSize.tablet: tablet,
            ScreenSize.mobile: mobile,
            ScreenSize.watch: watch,
          },
          breakpoints: Breakpoints.defaultBreakpoints,
          defaultValue: ScreenSize.mobile,
        ),
      },
      child: _Frame(
        persistentFrameConfig: persistentFrameConfig,
        backgroundColor: backgroundColor,
        animations: animations,
      ),
    );
  }
}

class _Frame extends StatefulWidget {
  const _Frame({
    required this.persistentFrameConfig,
    required this.animations,
    this.backgroundColor,
  });
  final Color? backgroundColor;
  final FrameConfig persistentFrameConfig;
  final bool animations;
  @override
  State<_Frame> createState() => _FrameState();
}

class _FrameState extends State<_Frame> {
  bool _isInit = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setInitStatus();
    });
    super.initState();
  }

  void setInitStatus() {
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ResponsiveData.of(context)
        .getController<FrameConfig, ScreenSize>('frameconfig');
    final config = controller
        .breakpointCallback(context)
        .merge(widget.persistentFrameConfig);
    return Material(
      color: widget.backgroundColor,
      child: SafeArea(
        child: Frame(
          dimensions: config.dimensions,
          animations: !_isInit && widget.animations,
          body: config.body ?? const SizedBox(),
          top: config.top,
          bodyTop: config.bodyTop,
          leftEnd: config.leftEnd,
          leftEndTop: config.leftEndTop,
          rightEnd: config.rightEnd,
          rightEndTop: config.rightEndTop,
          bodyBottom: config.bodyBottom,
          bottom: config.bottom,
        ),
      ),
    );
  }
}

class Textbox extends StatefulWidget {
  const Textbox({
    super.key,
    this.isLong = true,
  });
  final bool isLong;

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  late Color color;

  @override
  void initState() {
    color = generateRandomColor();
    super.initState();
  }

  Color generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(widget.isLong ? longtext : 'short text'),
      ),
    );
  }
}

const longtext = """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


Where does it come from?
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.""";

class BreakpointDataWidget extends StatelessWidget {
  const BreakpointDataWidget({
    required this.child,
    this.controllers,
    super.key,
  });
  final Widget child;
  // ignore: strict_raw_type
  final Map<String, BreakpointsController>? controllers;
  @override
  Widget build(BuildContext context) {
    return ResponsiveData(
      notifier: ResponsiveDataChangeNotifier<ScreenSize>(
        controllers: controllers,
        breakpoints: Breakpoints.defaultBreakpoints,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          ResponsiveData.of(context).updateScreenSize();

          return child;
        },
      ),
    );
  }
}
