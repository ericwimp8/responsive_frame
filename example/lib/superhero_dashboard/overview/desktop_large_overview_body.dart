import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class SuperheroDesktopLargeOverviewBody extends StatelessWidget {
  const SuperheroDesktopLargeOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: DashboardCard(
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: const SuperHeroOverview(),
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
                  child: const Statistics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}