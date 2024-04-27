import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

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
        final theme = WithValueUpdate.of<AppThemeState>(context);

        return MaterialApp.router(
          routerConfig: router,
          title: 'Flutter Demo',
          themeMode: theme.data.themeMode,
          theme: theme.data.light,
          darkTheme: theme.data.dark,
        );
      },
    );
  }
}
