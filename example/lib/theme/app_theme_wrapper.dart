import 'package:example/theme/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

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
    return WithValueUpdate<AppThemeState>(
      notifier: AppThemeState(initialValue),
      child: Builder(builder: child),
    );
  }
}
