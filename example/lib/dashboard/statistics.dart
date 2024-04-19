import 'package:example/barrel.dart';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:responsive_frame/responsive_frame.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final heroList = SuperHeroData.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Material(
        color: theme.colorScheme.surfaceTint,
        shape: const RoundedRectangleBorder(borderRadius: kDefaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const Chart(),
              const StatsTile(
                selected: true,
                title: Text('Villans Captured'),
                leading: ImageIcon(
                  AssetImage('assets/images/shield.png'),
                  color: Colors.blue,
                ),
                subtitle: Text('Date: 04/01/2024'),
                trailing: Text('247'),
              ),
              StatsTile(
                title: const Text('Bananas Eaten'),
                leading: ImageIcon(
                  const AssetImage('assets/images/banana_icon.png'),
                  color: theme.colorScheme.primary,
                ),
                subtitle: const Text('Date: 03/09/2024'),
                trailing: const Text('9247'),
              ),
              StatsTile(
                title: const Text('Hero Schedule'),
                leading: Icon(
                  Symbols.calendar_today_rounded,
                  fill: 1,
                  grade: 200,
                  weight: 700,
                  opticalSize: 48,
                  color: theme.colorScheme.secondary,
                ),
                subtitle: const Text('Date: 11/09/2024'),
                trailing: const Text(''),
              ),
              const StatsTile(
                title: Text('Villan Convictions'),
                leading: Icon(
                  Symbols.local_police_rounded,
                  fill: 1,
                  grade: 200,
                  weight: 700,
                  opticalSize: 48,
                  color: DashboardTheme.electricPurple,
                ),
                subtitle: Text('Date: 11/09/2024'),
                trailing: Text('246'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsTile extends StatelessWidget {
  const StatsTile({
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.trailing,
    this.selected = false,
    super.key,
  });
  final Widget title;
  final Widget subtitle;
  final Widget leading;
  final Widget trailing;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        titleTextStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        shape: (theme.listTileTheme.shape! as RoundedRectangleBorder).copyWith(
          side: BorderSide(
            width: 2,
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.secondaryContainer.withOpacity(0.1),
          ),
        ),
        leadingAndTrailingTextStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        leading: leading,
        subtitle: subtitle,
        title: title,
        trailing: trailing,
      ),
    );
  }
}

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.1)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Villans Captured'),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('chart here'),
            ),
          ],
        ),
      ),
    );
  }
}
