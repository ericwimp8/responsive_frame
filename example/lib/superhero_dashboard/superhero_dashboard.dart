import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_frame/responsive_frame.dart';

class SuperheroDashboard extends StatefulWidget {
  const SuperheroDashboard({super.key});

  @override
  State<SuperheroDashboard> createState() => _SuperheroDashboardState();
}

class _SuperheroDashboardState extends State<SuperheroDashboard> {
  @override
  Widget build(BuildContext context) {
    return const _Dashboard();
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard();

  @override
  Widget build(BuildContext context) {
    return SuperheroDataWrapper(
      child: (context) {
        final state = SuperheroData.of(context);

        if (state.data == SuperheroDataModel.empty) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ResponsiveFrameLayout(
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
              return const FrameConfig(
                leftEnd: Menu(),
                rightEnd: SuperheroMenuList(),
                dimensions: DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 280,
                  rightEndMinWidth: 280,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: double.infinity,
                ),
                body: DesktopBody(),
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
      },
    );
  }
}

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  Widget _buildBody(SuperheroeDashboardLocation location) => switch (location) {
        SuperheroeDashboardLocation.all => const SuperheroList(
            key: ValueKey(SuperheroeDashboardLocation.all),
          ),
        SuperheroeDashboardLocation.villains => const SuperheroList(
            key: ValueKey(SuperheroeDashboardLocation.villains),
          ),
        SuperheroeDashboardLocation.superheroes => const SuperheroList(
            key: ValueKey(SuperheroeDashboardLocation.superheroes),
          ),
        SuperheroeDashboardLocation.masterMinds => const SuperheroList(
            key: ValueKey(SuperheroeDashboardLocation.masterMinds),
          ),
        SuperheroeDashboardLocation.battleHardened => const SuperheroList(
            key: ValueKey(SuperheroeDashboardLocation.battleHardened),
          ),
      };

  @override
  Widget build(BuildContext context) {
    final routeState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);

    return AppAnimatedSwitcherScale(
      duration: kDefaultAnimationDurationLong,
      reverseDuration: kDefaultAnimationDurationLong,
      begin: 0.9,
      child: _buildBody(location),
    );
  }
}
