import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

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
                  AppAnimatedSwitcherSizeFade(
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
                    onTap: () =>
                        navigate(context, SuperheroeDashboardLocation.villains),
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
    this.leading,
    this.leadingWidget,
    this.trailing,
    this.onTap,
    this.selected = false,
    super.key,
  })  : assert(
          leadingWidget == null || leading == null,
          'Both leading and leadingWidget cannot be set, one must be null',
        ),
        assert(
          leadingWidget != null || leading != null,
          'leading or leadingWidget must be be not null',
        );
  final Widget title;
  final String? leading;
  final Widget? leadingWidget;
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
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
        textColor: theme.colorScheme.onSurface.withOpacity(0.5),
        selected: selected,
        onTap: onTap,
        leading: leadingWidget ??
            ImageIcon(
              AssetImage(leading!),
              color: selected
                  ? theme.colorScheme.onPrimary
                  : theme.iconTheme.color!.withOpacity(0.5),
            ),
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
    final state = WithUpdate.of<AppThemeState>(context);
    final isDark = state.isDark;
    final theme = Theme.of(context);
    return MenuTile(
      onTap: () => updateTheme(!isDark, state),
      leadingWidget: const Icon(Symbols.dark_mode_rounded),
      title: Text(
        'Dark Mode',
        style: isDark
            ? theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)
            : theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
      ),
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
    final state = WithUpdate.of<AppThemeState>(context);
    final isDynamic = state.data.useDynamicTheme;
    final theme = Theme.of(context);
    return MenuTile(
      onTap: () => updateTheme(state, !isDynamic),
      leadingWidget: const Icon(Symbols.dark_mode_rounded),
      title: Text(
        'Dynamic Theme',
        style: isDynamic
            ? theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)
            : theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
      ),
      trailing: Switch(
        value: isDynamic,
        onChanged: (value) => updateTheme(state, value),
      ),
    );
  }
}
