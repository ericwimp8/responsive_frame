import 'package:flutter/material.dart';

class AppHeading extends StatelessWidget {
  const AppHeading({required this.label, super.key});
  final String label;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
