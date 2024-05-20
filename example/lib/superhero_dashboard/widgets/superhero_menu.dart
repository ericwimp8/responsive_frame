import 'package:animated_switcher_wrapper/animated_switcher_wrapper.dart';
import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class SuperheroMenu extends StatefulWidget {
  const SuperheroMenu({super.key});

  @override
  State<SuperheroMenu> createState() => _SuperheroMenuState();
}

class _SuperheroMenuState extends State<SuperheroMenu> {
  void navigate(BuildContext context, SuperheroeDashboardLocation location) {
    GoRouter.of(context).go(
      '${RoutePaths.superHeroDashBoard}/${location.name}${RoutePaths.noIndex}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routeState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);

    return MenuLayout(
      child: Column(
        children: [
          const MenuHeader(
            imagePath: 'assets/images/example_icon.png',
            subtitle: 'Wimp',
            title: 'Eric',
          ),
          Expanded(
            child: Material(
              type: MaterialType.transparency,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
                    child:
                        Text('DASHBOARDS', style: theme.textTheme.titleSmall),
                  ),
                  AnimatedSwitcherSizeFade(
                    child: location == SuperheroeDashboardLocation.overview
                        ? MenuTile(
                            selected: true,
                            title: const Text('Overview'),
                            leadingWidget:
                                const Icon(Symbols.overview_key_rounded),
                            onTap: () {},
                          )
                        : const SizedBox(),
                  ),
                  MenuTile(
                    selected: location == SuperheroeDashboardLocation.all,
                    onTap: () =>
                        navigate(context, SuperheroeDashboardLocation.all),
                    leading: 'assets/images/all.png',
                    title: const Text('All'),
                  ),
                  MenuTile(
                    selected:
                        location == SuperheroeDashboardLocation.superheroes,
                    onTap: () => navigate(
                      context,
                      SuperheroeDashboardLocation.superheroes,
                    ),
                    leading: 'assets/images/superheroes.png',
                    title: const Text('Superheroes'),
                  ),
                  MenuTile(
                    selected: location == SuperheroeDashboardLocation.villains,
                    onTap: () => navigate(
                      context,
                      SuperheroeDashboardLocation.villains,
                    ),
                    leading: 'assets/images/villains.png',
                    title: const Text('Villains'),
                  ),
                  MenuTile(
                    selected:
                        location == SuperheroeDashboardLocation.masterMinds,
                    onTap: () => navigate(
                      context,
                      SuperheroeDashboardLocation.masterMinds,
                    ),
                    leading: 'assets/images/intelligence.png',
                    title: const Text('Master Minds'),
                  ),
                  MenuTile(
                    selected:
                        location == SuperheroeDashboardLocation.battleHardened,
                    onTap: () => navigate(
                      context,
                      SuperheroeDashboardLocation.battleHardened,
                    ),
                    leading: 'assets/images/combat.png',
                    title: const Text('Battle Hardened'),
                  ),
                  const DarkModeSwitch(),
                  const DynamicThemeSwitch(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
