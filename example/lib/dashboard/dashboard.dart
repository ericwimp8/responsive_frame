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
    final theme = Theme.of(context);
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
            bodyMaxWidth: double.infinity,
          ),
          bodyTop: Header(),
        ),
        mobile: (context) {
          return FrameConfig(
            leftEnd: const Menu(),
            rightEnd: const SuperHeroList(),
            dimensions: const DimensionsConfig(
              rightEndFillVertical: false,
              rightEndMaxWidth: 280,
              rightEndMinWidth: 280,
              leftEndMaxWidth: 250,
              bodyMaxWidth: double.infinity,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: DashboardCard(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
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
            ),
          );
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
        // desktop: (context) {
        //   return const FrameConfig(
        //     leftEnd: Menu(),
        //     rightEnd: Statistics(),
        //     dimensions: DimensionsConfig(
        //       rightEndFillVertical: false,
        //       rightEndMaxWidth: 280,
        //       rightEndMinWidth: 280,
        //       leftEndMaxWidth: 250,

        //       // bodyAlignment: Alignment.topCenter,
        //     ),
        //     body: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 16),
        //       child: SingleChildScrollView(
        //         child: SuperHeroOverview(),
        //       ),
        //     ),
        //   );
        // },
        // desktopLarge: (context) {
        //   return FrameConfig(
        //     leftEnd: const Menu(),
        //     rightEnd: const SuperHeroList(),
        //     dimensions: const DimensionsConfig(
        //       rightEndFillVertical: false,
        //       rightEndMaxWidth: 280,
        //       rightEndMinWidth: 280,
        //       leftEndMaxWidth: 250,
        //       bodyMaxWidth: double.infinity,
        //     ),
        //     body: Container(
        //       color: Colors.red,
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 16),
        //         child: SingleChildScrollView(
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Flexible(
        //                 flex: 3,
        //                 child: ConstrainedBox(
        //                   constraints: const BoxConstraints(minWidth: 300),
        //                   child: const SuperHeroOverview(),
        //                 ),
        //               ),
        //               const Padding(padding: EdgeInsets.only(left: 16)),
        //               const Flexible(
        //                 flex: 2,
        //                 child: Statistics(),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   );
        // },
      );
    }

    return AppAnimatedSwitcherSlideFade(child: child);
  }
}
