import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _animate() {
    setState(() {
      show = !show;
    });
  }

  bool show = true;

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
          return Scaffold(
            appBar: AppBar(
              title: const Text('mobile'),
            ),
          );
        },
      ),
    );
  }
}
