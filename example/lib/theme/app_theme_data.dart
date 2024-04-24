import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

@immutable
class AppThemeData {
  const AppThemeData({
    required this.themeMode,
    required this.light,
    required this.dark,
    required this.appTheme,
    this.useDynamicTheme = true,
  });

  final ThemeMode themeMode;
  final ThemeData light;
  final ThemeData dark;
  final AppTheme appTheme;
  final bool useDynamicTheme;

  AppThemeData copyWith({
    ThemeMode? themeMode,
    ThemeData? light,
    ThemeData? dark,
    AppTheme? appTheme,
    bool? useDynamicTheme,
  }) {
    return AppThemeData(
      themeMode: themeMode ?? this.themeMode,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      appTheme: appTheme ?? this.appTheme,
      useDynamicTheme: useDynamicTheme ?? this.useDynamicTheme,
    );
  }

  @override
  String toString() {
    return 'AppThemeData(themeMode: $themeMode, light: $light, dark: $dark, appTheme: $appTheme, useDynamicTheme: $useDynamicTheme)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppThemeData &&
        other.themeMode == themeMode &&
        other.light == light &&
        other.dark == dark &&
        other.appTheme == appTheme &&
        other.useDynamicTheme == useDynamicTheme;
  }

  @override
  int get hashCode {
    return themeMode.hashCode ^
        light.hashCode ^
        dark.hashCode ^
        appTheme.hashCode ^
        useDynamicTheme.hashCode;
  }
}

class AppThemeState with ChangeNotifier {
  AppThemeState(this.initialValue);
  final AppThemeData initialValue;

  // ignore: prefer_final_fields
  late AppThemeData _data = initialValue;
  AppThemeData get data => _data;
  bool get isDark => _data.themeMode == ThemeMode.dark;

  void updateThemeMode(ThemeMode themeMode) {
    _data = _data.copyWith(themeMode: themeMode);
    notifyListeners();
  }

  void updateDynamicTheme(bool value) {
    _data = _data.copyWith(useDynamicTheme: value);
    notifyListeners();
  }

  void setDefaultTheme() {
    if (_data.appTheme == AppTheme.dashboard) {
      _data = _data.copyWith(
        dark: DashboardTheme.dark(),
        light: DashboardTheme.light(),
      );
    }

    notifyListeners();
  }

  Future<void> updateThemeFromImage(ImageProvider imageProvider) async {
    if (_data.appTheme == AppTheme.dashboard) {
      final light =
          await ColorScheme.fromImageProvider(provider: imageProvider);
      final dark = await ColorScheme.fromImageProvider(
        provider: imageProvider,
        brightness: Brightness.dark,
      );
      _data = _data.copyWith(
        light: DashboardTheme.light(colorScheme: light),
        dark: DashboardTheme.dark(colorScheme: dark),
      );
    }
    notifyListeners();
  }

  @override
  String toString() =>
      'AppThemeState(initialValue: $initialValue, data: AppThemeState: $_data)';
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

enum AppTheme {
  dashboard,
  seeded,
}
