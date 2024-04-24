import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class HeroesHome extends StatelessWidget {
  const HeroesHome({
    required this.location,
    super.key,
  });
  final HeroesHomeLocation location;
  @override
  Widget build(BuildContext context) {
    return const SuperheroDashboard();
  }
}
