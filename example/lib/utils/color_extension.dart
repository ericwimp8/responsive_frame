import 'package:flutter/material.dart';

extension ColorUtils on Color {
  /// Lightens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color lighten([int amount = 10]) {
    return Color.lerp(this, Colors.white, amount / 100)!;
  }

  /// Darkens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color darken([int amount = 10]) {
    return Color.lerp(this, Colors.black, amount / 100)!;
  }
}
