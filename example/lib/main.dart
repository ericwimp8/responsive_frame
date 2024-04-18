import 'package:example/dashboard/dashboard.dart';
import 'package:example/dashboard/dashboard_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  timeDilation = 10;
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
      themeMode: ThemeMode.light,
      theme: DashboardTheme.light(),
      darkTheme: DashboardTheme.dark(),
      home: const Dashboard(),
    );
  }
}
