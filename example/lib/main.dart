import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ScreenSizeLayoutGranular(
        mobileNormal: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text('Mobile')),
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Textbox(),
            ),
          );
        },
        tabletNormal: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text('tabletNormal')),
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Textbox(),
            ),
          );
        },
        tabletSmall: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text('tabletSmall')),
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Textbox(),
            ),
          );
        },
      ),
    );
  }
}
