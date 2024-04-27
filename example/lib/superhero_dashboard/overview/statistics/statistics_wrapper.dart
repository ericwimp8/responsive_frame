import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class StatisticsStateWrapper extends StatefulWidget {
  const StatisticsStateWrapper({
    required this.child,
    super.key,
  });
  final Widget Function(
    BuildContext context,
    StatisticsState powerStatsState,
  ) child;

  @override
  State<StatisticsStateWrapper> createState() => _StatisticsStateWrapperState();
}

class _StatisticsStateWrapperState extends State<StatisticsStateWrapper> {
  @override
  Widget build(BuildContext context) {
    final state = WithValue.of<Superhero>(context);
    return WithValueUpdate(
      shouldNotify: (oldWidget, newWidget) {
        return oldWidget.notifier?.powerStats != newWidget.notifier?.powerStats;
      },
      notifier: StatisticsState(
        initialPowerStats: state.powerstats,
        initialSelectedPowerStat: PowerStatEnum.intelligence,
      ),
      child: Builder(
        builder: (context) {
          final powerStatsState = WithValueUpdate.of<StatisticsState>(context);
          return widget.child(context, powerStatsState);
        },
      ),
    );
  }
}
