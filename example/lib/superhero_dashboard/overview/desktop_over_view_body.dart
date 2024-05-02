import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class SuperheroOverviewBodySmall extends StatelessWidget {
  const SuperheroOverviewBodySmall({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DashboardCard(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SuperHeroOverview(),
            Divider(
              height: 80,
              endIndent: 10,
              indent: 10,
              color: theme.colorScheme.onSurface.withOpacity(0.07),
            ),
            const Statistics(),
          ],
        ),
      ),
    );
  }
}
