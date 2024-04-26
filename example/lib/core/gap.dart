import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap(
    this.gap, {
    super.key,
  });
  final double gap;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: gap));
  }
}
