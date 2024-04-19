import 'package:example/barrel.dart';

import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SuperHeroData(
      notifier: SuperHeroState(),
      child: const _DashBoard(),
    );
  }
}

class _DashBoard extends StatelessWidget {
  const _DashBoard();

  @override
  Widget build(BuildContext context) {
    final state = SuperHeroData.of(context);
    print('build');
    Widget child;
    if (state.data == SuperHeroDataModel.empty) {
      child = Material(
        child: Center(
          child: ElevatedButton(
            onPressed: () => state.setSelectedPowerStat(PowerStatsEnum.combat),
            child: const Text('fdafd'),
          ),
        ),
      );
    } else {
      child = ResponsiveFrameLayout(
        persistentFrameConfig: const FrameConfig(
          dimensions: DimensionsConfig(
            bodyTopMaxHeight: double.infinity,
            bodyTopMinHeight: 0,
            leftEndMinWidth: 200,
            leftEndMaxWidth: 300,
          ),
          bodyTop: Header(),
        ),
        mobile: (context) {
          return const FrameConfig();
        },
        tablet: (context) {
          return const FrameConfig(
            leftEnd: Menu(),
            rightEnd: Statistics(),
            dimensions: DimensionsConfig(
              rightEndFillVertical: false,
              rightEndMaxWidth: 350,
              rightEndMinWidth: 250,
            ),
          );
        },
      );
    }

    return AppAnimatedSwitcherSlideFade(child: child);
  }
}
