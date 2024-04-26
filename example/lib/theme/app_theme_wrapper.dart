import 'package:example/app_state/with.dart';
import 'package:example/theme/app_theme_data.dart';
import 'package:flutter/material.dart';

class AppThemeWrapper extends StatelessWidget {
  const AppThemeWrapper({
    required this.child,
    required this.initialValue,
    super.key,
  });
  final WidgetBuilder child;
  final AppThemeData initialValue;
  @override
  Widget build(BuildContext context) {
    return WithUpdate<AppThemeState>(
      notifier: AppThemeState(initialValue),
      child: Builder(builder: child),
    );
  }
}
