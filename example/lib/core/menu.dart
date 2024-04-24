import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  void navigate(BuildContext context, SuperheroeDashboardLocation location) {
    GoRouter.of(context).go('${RoutePaths.superHeroDashBoard}${location.name}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routeState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);

    return Material(
      color: theme.colorScheme.surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const MenuHeader(),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
                    child:
                        Text('DASHBOARDS', style: theme.textTheme.titleSmall),
                  ),
                  MenuTile(
                    selected: true,
                    title: const Text('Overview'),
                    leading: const Icon(Symbols.overview_key_rounded),
                    onTap: () {},
                  ),
                  MenuTile(
                    selected: location == SuperheroeDashboardLocation.all,
                    onTap: () =>
                        navigate(context, SuperheroeDashboardLocation.all),
                    leading: const Icon(Symbols.send_money_rounded),
                    title: const Text('Heroes'),
                  ),
                  MenuTile(
                    selected: location == SuperheroeDashboardLocation.villans,
                    onTap: () =>
                        navigate(context, SuperheroeDashboardLocation.villans),
                    leading: const Icon(Symbols.ssid_chart_rounded),
                    title: const Text('Villans'),
                  ),
                  MenuTile(
                    selected:
                        location == SuperheroeDashboardLocation.masterMinds,
                    onTap: () => navigate(
                      context,
                      SuperheroeDashboardLocation.masterMinds,
                    ),
                    leading: const Icon(Symbols.groups_rounded),
                    title: const Text('Master Minds'),
                  ),
                  MenuTile(
                    selected:
                        location == SuperheroeDashboardLocation.battleHardened,
                    onTap: () => navigate(
                      context,
                      SuperheroeDashboardLocation.battleHardened,
                    ),
                    leading: const Icon(Symbols.groups_rounded),
                    title: const Text('Battle Hardened'),
                  ),
                  const DarkModeSwitch(),
                  const DynamicThemeSwitch(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.asset(
              height: 100,
              'assets/images/example_icon.png',
            ),
          ),
          const Text(
            'ERIC',
            style: TextStyle(
              height: 0,
              fontSize: 30,
              fontFamily: 'JosefinSans',
              fontVariations: <FontVariation>[
                FontVariation('wght', 400),
              ],
            ),
          ),
          const Text(
            'Wimp',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'JosefinSans',
              fontVariations: <FontVariation>[
                FontVariation('wght', 400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    required this.title,
    required this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    super.key,
  });
  final Widget title;
  final Widget leading;
  final Widget? trailing;
  final bool selected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: !selected
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        titleTextStyle: selected
            ? theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)
            : theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurface,
              ),
        textColor: theme.colorScheme.onSurface,
        selected: selected,
        onTap: onTap,
        leading: leading,
        title: title,
        trailing: trailing,
      ),
    );
  }
}

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  void updateTheme(bool isDark, AppThemeState state) {
    state.updateThemeMode(
      isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppThemeDataData.of(context);
    final isDark = state.isDark;
    return MenuTile(
      onTap: () => updateTheme(!isDark, state),
      leading: const Icon(Symbols.dark_mode_rounded),
      title: const Text('Dark Mode'),
      trailing: Switch(
        value: state.isDark,
        onChanged: (value) => updateTheme(value, state),
      ),
    );
  }
}

class DynamicThemeSwitch extends StatelessWidget {
  const DynamicThemeSwitch({super.key});

  void updateTheme(AppThemeState state, bool isDynamic) {
    state.updateDynamicTheme(isDynamic);
  }

  @override
  Widget build(BuildContext context) {
    final state = AppThemeDataData.of(context);
    final isDynamic = state.data.useDynamicTheme;
    return MenuTile(
      onTap: () => updateTheme(state, !isDynamic),
      leading: const Icon(Symbols.dark_mode_rounded),
      title: const Text('Dynamic Theme'),
      trailing: Switch(
        value: isDynamic,
        onChanged: (value) => updateTheme(state, value),
      ),
    );
  }
}
