import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class OverviewBodyLarge extends StatelessWidget {
  const OverviewBodyLarge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DashboardCard(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: const OverviewProfile(),
              ),
            ),
            VerticalDivider(
              width: 80,
              endIndent: 10,
              indent: 10,
              color: theme.colorScheme.onSurface.withOpacity(0.07),
            ),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: const OverviewStatistics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
