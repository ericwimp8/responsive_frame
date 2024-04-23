import 'package:flutter/material.dart';

abstract class DashboardTheme {
  static const Color blue = Color(0xFF2D00F7);
  static const Color electricIndigo = Color(0xFF6A00F4);
  static const Color violet = Color(0xFF8900F2);
  static const Color veronica = Color(0xFFA100F2);
  static const Color veronica2 = Color(0xFFB100E8);
  static const Color electricPurple = Color(0xFFBC00DD);
  static const Color steelPink = Color(0xFFD100D1);
  static const Color steelPink2 = Color(0xFFDB00B6);
  static const Color hollywoodCerise = Color(0xFFE500A4);
  static const Color magenta = Color(0xFFF20089);

  static const orangePeel = Color(0xFFFF9900);
  static const mikadoYellow = Color(0xFFFFC800);
  static const schoolBusYellow = Color(0xFFFFE000);
  static const yellow = Color(0xFFFFF700);
  static const lime = Color(0xFFB8F500);
  static const yellowGreen = Color(0xFF95E214);
  static const sgbusGreen = Color(0xFF72CE27);
  static const pailYellow = Color(0xFFfffef0);

  static ThemeData buildTheme(ColorScheme colorScheme) {
    final listTileTheme = ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: colorScheme.onPrimary.withOpacity(0.1),
        ),
      ),
      selectedColor: colorScheme.onPrimary,
      selectedTileColor: colorScheme.primary,
      tileColor: colorScheme.surfaceTint,
      textColor: colorScheme.onSurface.withOpacity(0.5),
    );

    const inputDecorationThemeBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    final inputDecorationTheme = InputDecorationTheme(
      fillColor: colorScheme.surfaceTint,
      filled: true,
      border: inputDecorationThemeBorder,
      focusedBorder: inputDecorationThemeBorder,
      enabledBorder: inputDecorationThemeBorder,
      errorBorder: inputDecorationThemeBorder,
      disabledBorder: inputDecorationThemeBorder,
    );

    final textSlectionTheme = TextSelectionThemeData(
      cursorColor: colorScheme.onSurface,
    );

    return ThemeData(
      fontFamily: 'Poppins',
      colorScheme: colorScheme,
      listTileTheme: listTileTheme,
      inputDecorationTheme: inputDecorationTheme,
      textSelectionTheme: textSlectionTheme,
    );
  }

  static ThemeData light({ColorScheme? colorScheme}) {
    if (colorScheme != null) {
      return buildTheme(
        colorScheme.copyWith(
          onSecondary: Colors.black,
          onPrimary: Colors.black,
          surfaceTint: Colors.black.withOpacity(0.05),
        ),
      );
    }
    return buildTheme(
      ColorScheme.fromSeed(
        seedColor: yellow,
        primary: yellow,
        primaryContainer: orangePeel,
        secondary: sgbusGreen,
        secondaryContainer: lime,
        onSecondary: Colors.black,
        onPrimary: Colors.black,
        surfaceTint: Colors.black.withOpacity(0.05),
      ),
    );
  }

  static ThemeData dark({ColorScheme? colorScheme}) {
    if (colorScheme != null) {
      return buildTheme(
        colorScheme.copyWith(
          onSecondary: Colors.black,
          onPrimary: Colors.black,
          surfaceTint: Colors.white.withOpacity(0.03),
        ),
      );
    }
    return buildTheme(
      ColorScheme.fromSeed(
        primary: yellow,
        seedColor: yellow,
        primaryContainer: orangePeel,
        secondary: sgbusGreen,
        secondaryContainer: lime,
        onSecondary: Colors.black,
        onPrimary: Colors.black,
        brightness: Brightness.dark,
        surfaceTint: Colors.white.withOpacity(0.03),
      ),
    );
  }
}
