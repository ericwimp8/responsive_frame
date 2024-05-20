import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  const Overview({
    required this.isLarge,
    super.key,
  });
  final bool isLarge;
  @override
  Widget build(BuildContext context) {
    return isLarge ? const OverviewBodyLarge() : const OverviewBodySmall();
  }
}
