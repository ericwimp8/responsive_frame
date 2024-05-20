import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_frame/responsive_frame.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveFrameLayout(
      extraLarge: (context) => FrameConfig(
        top: Container(child: const Align(child: Text('Responsive Layout'))),
        leftEnd: const HomeMenu(),
        rightEnd: const Text('Extra large layout right end'),
        body: const Text('Extra large layout body'),
      ),
    );
  }
}
