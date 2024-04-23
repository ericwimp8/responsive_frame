import 'package:flutter/material.dart';

@immutable
class AppThemeData {
  const AppThemeData({
    required this.themeMode,
    required this.light,
    required this.dark,
  });

  final ThemeMode themeMode;
  final ThemeData light;
  final ThemeData dark;

  AppThemeData copyWith({
    ThemeMode? themeMode,
    ThemeData? light,
    ThemeData? dark,
  }) {
    return AppThemeData(
      themeMode: themeMode ?? this.themeMode,
      light: light ?? this.light,
      dark: dark ?? this.dark,
    );
  }

  @override
  String toString() =>
      'AppThemeData(themeMode: $themeMode, light: $light, dark: $dark)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppThemeData &&
        other.themeMode == themeMode &&
        other.light == light &&
        other.dark == dark;
  }

  @override
  int get hashCode => themeMode.hashCode ^ light.hashCode ^ dark.hashCode;
}

class AppThemeState with ChangeNotifier {
  AppThemeState(this.initialValue);
  final AppThemeData initialValue;

  // ignore: prefer_final_fields
  late AppThemeData _data = initialValue;
  AppThemeData get data => _data;
  bool get isDark => _data.themeMode == ThemeMode.dark;

  void updateThemeSeeded(
    Color seededColor,
  ) {
    _data = _data.copyWith(
      dark: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seededColor,
          brightness: Brightness.dark,
        ),
      ),
      light: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seededColor,
        ),
      ),
    );
    notifyListeners();
  }

  // void updateTheme(AppThemeData Function(AppThemeData value) appTheme) {
  //   _data = appTheme(_data.copyWith());
  // }

  void updateThemeMode(ThemeMode themeMode) {
    _data = _data.copyWith(themeMode: themeMode);
    notifyListeners();
  }

  @override
  String toString() =>
      'AppThemeState(initialValue: $initialValue, data: AppThemeState: $_data)';
}

enum AppTheme {
  dashboard,
  seeded,
}

class AppThemeDataData extends InheritedNotifier<AppThemeState> {
  const AppThemeDataData({
    required AppThemeState super.notifier,
    required super.child,
    super.key,
  });

  static AppThemeState of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<AppThemeDataData>();
    if (result == null) {
      throw FlutterError(
        'AppThemeDataData was not found in the widget tree. Make sure to wrap your widget tree with a AppThemeDataData.',
      );
    }
    return result.notifier!;
  }

  @override
  bool updateShouldNotify(AppThemeDataData oldWidget) {
    return oldWidget.notifier?.data != notifier?.data;
  }
}

class AppThemeWidget extends StatelessWidget {
  const AppThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
