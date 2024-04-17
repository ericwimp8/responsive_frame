import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  // timeDilation = 10;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveFrameLayout(
        mobile: (_) {
          return FrameConfig(
            body: [
              FrameBodyListChild(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('mobile'),
                  ),
                  body: const Textbox(),
                ),
              ),
            ],
          );
        },
        tablet: (_) {
          return const FrameConfig(
            body: [
              FrameBodyListChild(
                child: Textbox(),
              ),
            ],
            leftEnd: Textbox(),
            leftEndTop: Textbox(
              isLong: false,
            ),
            bodyTop: Textbox(isLong: false),
          );
        },
        desktop: (_) {
          return const FrameConfig(
            body: [
              FrameBodyListChild(
                child: Textbox(),
              ),
              FrameBodyListChild(
                flex: 3,
                child: Textbox(),
              ),
            ],
            leftEnd: Textbox(),
            leftEndTop: Textbox(
              isLong: false,
            ),
            top: Textbox(isLong: false),
            bodyTop: Textbox(isLong: false),
          );
        },
      ),
    );
  }
}
