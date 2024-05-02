import 'package:example/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_frame/barrel.dart';
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
  final key = const ValueKey('testket');
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
                bodyBottomMaxHeight: double.infinity,
                bodyBottomMinHeight: 0,
                bodyMaxWidth: double.infinity,
              ),
            ),
            mobile: (context) {
              return FrameConfig(
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: double.infinity,
                ),
                bodyTop: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        MenuDrawerButton(key: key),
                        const Gap(8),
                        const Flexible(child: HeroSearch()),
                      ],
                    ),
                  ),
                ),

                // leftEnd: const Menu(),
                body: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Body(crossAxisCount: 2),
                ),
                // bodyBottom: Padding(
                //   padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                //   child: NavigationButtons(),
                // ),
              );
            },
            tablet: (context) {
              return FrameConfig(
                bodyTop: location != SuperheroeDashboardLocation.overview
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: HeroSearch(),
                      )
                    : null,
                bodyBottom: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        MenuDrawerButton(key: key),
                        const Gap(8),
                        const Flexible(
                          child: NavigationButtons(),
                        ),
                      ],
                    ),
                  ),
                ),
                rightEnd: location == SuperheroeDashboardLocation.overview
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: SuperheroMenuList(),
                      )
                    : null,
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,

                  // bodyAlignment: Alignment.topCenter,
                ),
                body: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Body(crossAxisCount: 4),
                ),
              );
            },
            desktop: (context) {
              return FrameConfig(
                bodyTop: location != SuperheroeDashboardLocation.overview
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: HeroSearch(),
                      )
                    : null,
                leftEnd: const Menu(),
                rightEnd: location == SuperheroeDashboardLocation.overview
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                        child: SuperheroMenuList(),
                      )
                    : null,
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,

                  // bodyAlignment: Alignment.topCenter,
                ),
                body: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Body(crossAxisCount: 4),
                ),
              );
            },
            desktopLarge: (context) {
              return FrameConfig(
                bodyTop: location != SuperheroeDashboardLocation.overview
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: HeroSearch(),
                      )
                    : null,
                rightEnd: location == SuperheroeDashboardLocation.overview
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                        child: SuperheroMenuList(),
                      )
                    : null,
                leftEnd: const Menu(),
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: 1200,
                ),
                body: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Body(crossAxisCount: 5),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    required this.crossAxisCount,
    super.key,
  });
  final int crossAxisCount;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget _buildBody(SuperheroeDashboardLocation location) => switch (location) {
        SuperheroeDashboardLocation.all => SuperheroList(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.all),
          ),
        SuperheroeDashboardLocation.villains => SuperheroList(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.villains),
          ),
        SuperheroeDashboardLocation.superheroes => SuperheroList(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.superheroes),
          ),
        SuperheroeDashboardLocation.masterMinds => SuperheroList(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.masterMinds),
          ),
        SuperheroeDashboardLocation.battleHardened => SuperheroList(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.battleHardened),
          ),
        _ => widget.crossAxisCount == 5
            ? const SuperheroDesktopLargeOverviewBody()
            : const SuperheroOverviewBodySmall(),
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
