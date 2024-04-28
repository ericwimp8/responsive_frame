import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:with_value/with_value.dart';

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
        final routerState = GoRouterState.of(context);
        final location =
            getRouteLocation(SuperheroeDashboardLocation.values, routerState);

        final state = WithValueUpdate.of<SuperheroState>(context);

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
              // bodyTop: Header(),
            ),
            mobile: (context) {
              return FrameConfig(
                bodyTop: location != SuperheroeDashboardLocation.overview
                    ? const Header()
                    : null,
                rightEnd: location == SuperheroeDashboardLocation.overview
                    ? const SuperheroMenuList()
                    : null,
                leftEnd: const Menu(),
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 280,
                  rightEndMinWidth: 280,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: double.infinity,
                ),
                body: const DesktopLargeBody(),
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
            desktop: (context) {
              return FrameConfig(
                bodyTop: location != SuperheroeDashboardLocation.overview
                    ? const Header()
                    : null,
                leftEnd: const Menu(),
                rightEnd: location == SuperheroeDashboardLocation.overview
                    ? const SuperheroMenuList()
                    : null,
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 280,
                  rightEndMinWidth: 280,
                  leftEndMaxWidth: 250,

                  // bodyAlignment: Alignment.topCenter,
                ),
                body: const DesktopBody(),
              );
            },
            desktopLarge: (context) {
              return FrameConfig(
                bodyTop: location != SuperheroeDashboardLocation.overview
                    ? const Header()
                    : null,
                rightEnd: location == SuperheroeDashboardLocation.overview
                    ? const SuperheroMenuList()
                    : null,
                leftEnd: const Menu(),
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: 1200,
                ),
                body: const DesktopLargeBody(),
              );
            },
          );
        }
      },
    );
  }
}

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  Widget _buildBody(SuperheroeDashboardLocation location) => switch (location) {
        SuperheroeDashboardLocation.all => const SuperheroList(
            crossAxisCount: 4,
            key: ValueKey(SuperheroeDashboardLocation.all),
          ),
        SuperheroeDashboardLocation.villains => const SuperheroList(
            crossAxisCount: 4,
            key: ValueKey(SuperheroeDashboardLocation.villains),
          ),
        SuperheroeDashboardLocation.superheroes => const SuperheroList(
            crossAxisCount: 4,
            key: ValueKey(SuperheroeDashboardLocation.superheroes),
          ),
        SuperheroeDashboardLocation.masterMinds => const SuperheroList(
            crossAxisCount: 4,
            key: ValueKey(SuperheroeDashboardLocation.masterMinds),
          ),
        SuperheroeDashboardLocation.battleHardened => const SuperheroList(
            crossAxisCount: 4,
            key: ValueKey(SuperheroeDashboardLocation.battleHardened),
          ),
        _ => const SuperheroDesktopOverviewBody(),
      };

  SuperheroeDashboardLocation? currentLocation;

  @override
  void didChangeDependencies() {
    final routeState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);
    if (location != currentLocation) {
      currentLocation = location;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppAnimatedSwitcherScale(
      duration: kDefaultAnimationDurationLong,
      reverseDuration: kDefaultAnimationDurationLong,
      begin: 0.9,
      child: _buildBody(currentLocation!),
    );
  }
}

class DesktopLargeBody extends StatefulWidget {
  const DesktopLargeBody({super.key});

  @override
  State<DesktopLargeBody> createState() => _DesktopLargeBodyState();
}

class _DesktopLargeBodyState extends State<DesktopLargeBody> {
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
        _ => const SuperheroDesktopLargeOverviewBody(),
      };

  SuperheroeDashboardLocation? currentLocation;

  @override
  void didChangeDependencies() {
    final routeState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);
    if (location != currentLocation) {
      currentLocation = location;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppAnimatedSwitcherScale(
      duration: kDefaultAnimationDurationLong,
      reverseDuration: kDefaultAnimationDurationLong,
      begin: 0.9,
      child: _buildBody(currentLocation!),
    );
  }
}
