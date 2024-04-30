// import 'package:flutter/material.dart';
// import 'package:responsive_frame/responsive_frame.dart';

// class ResponsiveFrameLayoutGranular extends StatefulWidget {
//   const ResponsiveFrameLayoutGranular({
//     required this.mobileNormal,
//     this.breakpoints = Breakpoints.defaultBreakpointsGranular,
//     this.animations = true,
//     super.key,
//     this.desktopExtraLarge,
//     this.desktopLarge,
//     this.desktopNormal,
//     this.desktopSmall,
//     this.tabletExtraLarge,
//     this.tabletLarge,
//     this.tabletNormal,
//     this.tabletSmall,
//     this.mobileExtraLarge,
//     this.mobileLarge,
//     this.mobileSmall,
//     this.persistentConfig = FrameConfig.empty,
//     this.watch,
//   });
//   final FrameConfig Function(BuildContext context) mobileNormal;
//   final FrameConfig Function(BuildContext context)? desktopExtraLarge;
//   final FrameConfig Function(BuildContext context)? desktopLarge;
//   final FrameConfig Function(BuildContext context)? desktopNormal;
//   final FrameConfig Function(BuildContext context)? desktopSmall;
//   final FrameConfig Function(BuildContext context)? tabletExtraLarge;
//   final FrameConfig Function(BuildContext context)? tabletLarge;
//   final FrameConfig Function(BuildContext context)? tabletNormal;
//   final FrameConfig Function(BuildContext context)? tabletSmall;
//   final FrameConfig Function(BuildContext context)? mobileExtraLarge;
//   final FrameConfig Function(BuildContext context)? mobileLarge;
//   final FrameConfig Function(BuildContext context)? mobileSmall;
//   final FrameConfig Function(BuildContext context)? watch;
//   final Breakpoints<ScreenSizeGranular> breakpoints;
//   final bool animations;
//   final FrameConfig persistentConfig;

//   @override
//   State<ResponsiveFrameLayoutGranular> createState() =>
//       _ResponsiveFrameLayoutState();
// }

// class _ResponsiveFrameLayoutState extends State<ResponsiveFrameLayoutGranular> {

//   bool _isInit = true;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setInitStatus(false);
//     });
//     super.initState();
//   }

//   void setInitStatus(bool isInit) {
//     _isInit = isInit;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final config = controller
//             .breakpointCallback(context)
//             .merge(widget.persistentConfig);
//         return Frame(
//           dimensions: config.dimensions,
//           animations: !_isInit && widget.animations,
//           body: config.body ?? const SizedBox(),
//           top: config.top,
//           bodyTop: config.bodyTop,
//           leftEnd: config.leftEnd,
//           leftEndTop: config.leftEndTop,
//           rightEnd: config.rightEnd,
//           rightEndTop: config.rightEndTop,
//           bodyBottom: config.bodyBottom,
//           bottom: config.bottom,
//         );
//       },
//     );
//   }
// }
