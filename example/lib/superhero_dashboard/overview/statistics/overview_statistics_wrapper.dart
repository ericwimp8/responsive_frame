import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class OverviewStatisticsStateWrapper extends StatefulWidget {
  const OverviewStatisticsStateWrapper({
    required this.child,
    super.key,
  });
  final Widget Function(
    BuildContext context,
    OverviewStatisticsState powerStatsState,
  ) child;

  @override
  State<OverviewStatisticsStateWrapper> createState() =>
      _OverviewStatisticsStateWrapperState();
}

class _OverviewStatisticsStateWrapperState
    extends State<OverviewStatisticsStateWrapper> {
  @override
  Widget build(BuildContext context) {
    final state = WithValue.of<Superhero>(context);
    return WithValueUpdate(
      shouldNotify: (oldWidget, newWidget) {
        return oldWidget.notifier?.powerStats != newWidget.notifier?.powerStats;
      },
      notifier: OverviewStatisticsState(
        initialPowerStats: state.powerstats,
        initialSelectedPowerStat: PowerStatEnum.intelligence,
      ),
      child: Builder(
        builder: (context) {
          final powerStatsState =
              WithValueUpdate.of<OverviewStatisticsState>(context);
          return widget.child(context, powerStatsState);
        },
      ),
    );
  }
}
