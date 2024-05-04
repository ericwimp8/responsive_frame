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
                bodyMaxWidth: double.infinity,
              ),
            ),
            small: (context) {
              return const FrameConfig(
                dimensions: DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: double.infinity,
                ),
                bodyTop: SearchHeader(),
                body: Padding(
                  padding: EdgeInsets.all(8),
                  child: Body(crossAxisCount: 2),
                ),
              );
            },
            medium: (context) {
              return FrameConfig(
                bodyTop: location != SuperheroeDashboardLocation.overview
                    ? const SearchHeader()
                    : null,
                bodyBottom: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        MenuDrawerButton(key: key),
                        const Gap(8),
                        const Expanded(
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
            large: (context) {
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
            extraLarge: (context) {
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
        SuperheroeDashboardLocation.all => SuperheroGrid(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.all),
          ),
        SuperheroeDashboardLocation.villains => SuperheroGrid(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.villains),
          ),
        SuperheroeDashboardLocation.superheroes => SuperheroGrid(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.superheroes),
          ),
        SuperheroeDashboardLocation.masterMinds => SuperheroGrid(
            crossAxisCount: widget.crossAxisCount,
            key: const ValueKey(SuperheroeDashboardLocation.masterMinds),
          ),
        SuperheroeDashboardLocation.battleHardened => SuperheroGrid(
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
    return AnimatedSwitcherScaleFade(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      scaleBegin: 0.9,
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
        SuperheroeDashboardLocation.all => const SuperheroGrid(
            key: ValueKey(SuperheroeDashboardLocation.all),
          ),
        SuperheroeDashboardLocation.villains => const SuperheroGrid(
            key: ValueKey(SuperheroeDashboardLocation.villains),
          ),
        SuperheroeDashboardLocation.superheroes => const SuperheroGrid(
            key: ValueKey(SuperheroeDashboardLocation.superheroes),
          ),
        SuperheroeDashboardLocation.masterMinds => const SuperheroGrid(
            key: ValueKey(SuperheroeDashboardLocation.masterMinds),
          ),
        SuperheroeDashboardLocation.battleHardened => const SuperheroGrid(
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
    return AnimatedSwitcherScaleFade(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      scaleBegin: 0.9,
      child: _buildBody(currentLocation!),
    );
  }
}

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final routerState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routerState);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            ResponsiveWidget(
              small: true,
              child: const Row(
                children: [
                  MenuDrawerButton(),
                  Gap(8),
                ],
              ),
            ),
            if (location != SuperheroeDashboardLocation.overview)
              const Flexible(child: HeroSearch())
            else
              const Flexible(child: MobileSearchOverlay()),
          ],
        ),
      ),
    );
  }
}
