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

    Widget child;
    if (state.data == SuperHeroDataModel.empty) {
      child = const Material(
        child: Center(
          child: CircularProgressIndicator(),
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
        mobile: (context, constraints) {
          return const FrameConfig();
        },
        // tablet: (context) {
        //   return FrameConfig(
        //     // leftEnd: const Menu(),
        //     // rightEnd: const Statistics(),
        //     dimensions: const DimensionsConfig(
        //       rightEndFillVertical: false,
        //       rightEndMaxWidth: 350,
        //       rightEndMinWidth: 250,
        //       // bodyAlignment: Alignment.topCenter,
        //     ),
        //     body: ConstrainedBox(
        //       constraints: const BoxConstraints(maxWidth: 800),
        //       child: const Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Flexible(child: SuperHeroOverview()),
        //           Flexible(child: Statistics()),
        //         ],
        //       ),
        //     ),
        //   );
        // },
        desktop: (context, constraints) {
          return const FrameConfig(
            leftEnd: Menu(),
            rightEnd: Statistics(),
            dimensions: DimensionsConfig(
              rightEndFillVertical: false,
              rightEndMaxWidth: 280,
              rightEndMinWidth: 280,
              leftEndMaxWidth: 250,

              // bodyAlignment: Alignment.topCenter,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SuperHeroOverview(),
            ),
          );
        },
        desktopLarge: (context, constraints) {
          return FrameConfig(
            leftEnd: const Menu(),
            rightEnd: const Statistics(),
            dimensions: const DimensionsConfig(
              rightEndFillVertical: false,
              rightEndMaxWidth: 280,
              rightEndMinWidth: 280,
              leftEndMaxWidth: 250,
              bodyMaxWidth: 900,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 300),
                      child: const SuperHeroOverview(),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 16)),
                  const Flexible(
                    flex: 2,
                    child: Statistics(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return AppAnimatedSwitcherSlideFade(child: child);
  }
}
