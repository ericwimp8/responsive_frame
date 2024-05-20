import 'package:animated_switcher_wrapper/animated_switcher_wrapper.dart';
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
                bodyMaxWidth: double.infinity,
              ),
            ),
            small: (context) {
              return FrameConfig(
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: double.infinity,
                ),
                bodyTop: const SearchHeader(),
                body: Padding(
                  padding: const EdgeInsets.all(8),
                  child: location == SuperheroeDashboardLocation.overview
                      ? const OverviewBodySmall()
                      : const SuperheroGrid(),
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
                body: Padding(
                  padding: const EdgeInsets.all(8),
                  child: location == SuperheroeDashboardLocation.overview
                      ? const OverviewBodySmall()
                      : const SuperheroGrid(),
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
                leftEnd: const SuperheroMenu(),
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
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: location == SuperheroeDashboardLocation.overview
                      ? const OverviewBodySmall()
                      : const SuperheroGrid(),
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
                leftEnd: const SuperheroMenu(),
                dimensions: const DimensionsConfig(
                  rightEndFillVertical: false,
                  rightEndMaxWidth: 230,
                  rightEndMinWidth: 230,
                  leftEndMaxWidth: 250,
                  bodyMaxWidth: 1200,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: location == SuperheroeDashboardLocation.overview
                      ? const OverviewBodyLarge()
                      : const SuperheroGrid(),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class BodyLarge extends StatelessWidget {
  const BodyLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BodySmall extends StatelessWidget {
  const BodySmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Body extends StatefulWidget {
  const Body({
    required this.isLarge,
    super.key,
  });
  final bool isLarge;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget buildBody(SuperheroeDashboardLocation location) => switch (location) {
        SuperheroeDashboardLocation.overview =>
          Overview(isLarge: widget.isLarge),
        _ => const SuperheroGrid(),
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
      child: buildBody(currentLocation!),
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
              extraSmall: true,
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
