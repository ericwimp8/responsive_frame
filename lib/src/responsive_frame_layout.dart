import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class ResponsiveFrameLayout extends StatelessWidget {
  const ResponsiveFrameLayout({
    required this.small,
    this.extraLarge,
    this.large,
    this.medium,
    this.extraSmall,
    this.breakpoints = Breakpoints.defaultBreakpoints,
    this.animations = true,
    this.persistentFrameConfig = FrameConfig.empty,
    this.backgroundColor,
    super.key,
  });

  final FrameConfig Function(BuildContext context)? extraLarge;
  final FrameConfig Function(BuildContext context)? large;
  final FrameConfig Function(BuildContext context)? medium;
  final FrameConfig Function(BuildContext context) small;
  final FrameConfig Function(BuildContext context)? extraSmall;
  final Breakpoints breakpoints;
  final bool animations;
  final FrameConfig persistentFrameConfig;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BreakpointDataWidget<LayoutSize>(
      initialHandlers: {
        'frameconfig': BreakpointsHandler<FrameConfig Function(BuildContext)>(
          breakpoints: breakpoints,
          extraLarge: extraLarge,
          large: large,
          medium: medium,
          small: small,
          extraSmall: extraSmall,
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
    final handler = ResponsiveData.handlerOf<FrameConfig Function(BuildContext),
        LayoutSize>(
      context,
      'frameconfig',
      MediaQuery.sizeOf(context).width,
    );

    final config = handler.call(context).merge(widget.persistentFrameConfig);

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

class BreakpointDataWidget<K extends Enum> extends StatelessWidget {
  const BreakpointDataWidget({
    required this.child,
    this.initialHandlers = const {},
    super.key,
  });
  final Widget child;
  final Map<String, BreakpointsHandler<Object?>> initialHandlers;
  // ignore: strict_raw_type

  @override
  Widget build(BuildContext context) {
    return ResponsiveData<LayoutSize>(
      notifier: ResponsiveDataChangeNotifier<LayoutSize>(
        breakpoints: Breakpoints.defaultBreakpoints,
        initialHandlers: initialHandlers,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          ResponsiveData.of<LayoutSize>(context);

          return child;
        },
      ),
    );
  }
}
