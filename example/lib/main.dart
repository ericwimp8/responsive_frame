import 'package:example/dashboard/dashboard.dart';
import 'package:example/dashboard/dashboard_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: DashboardTheme.light(),
      darkTheme: DashboardTheme.dark(),
      home: const Dashboard(),
    );
  }
}
