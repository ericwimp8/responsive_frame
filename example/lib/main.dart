import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppThemeWrapper(
      initialValue: AppThemeData(
        appTheme: AppTheme.dashboard,
        themeMode: ThemeMode.dark,
        light: DashboardTheme.light(),
        dark: DashboardTheme.dark(),
      ),
      child: (context) {
        final theme = AppThemeDataData.of(context);

        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: theme.data.themeMode,
          theme: theme.data.light,
          darkTheme: theme.data.dark,
          home: const Dashboard(),
        );
      },
    );
  }
}
