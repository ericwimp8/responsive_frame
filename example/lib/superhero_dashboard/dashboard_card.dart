import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceTint,
      shape: const RoundedRectangleBorder(borderRadius: kDefaultBorderRadius),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
