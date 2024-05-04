import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:responsive_frame/responsive_frame.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
                      selected:
                          location == SuperheroeDashboardLocation.villains,
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
                      selected: location ==
                          SuperheroeDashboardLocation.battleHardened,
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
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    super.key,
  }) : assert(
          leadingWidget == null || leading == null,
          'Both leading and leadingWidget cannot be set, one must be null',
        );

  final Widget title;
  final String? leading;
  final Widget? leadingWidget;
  final Widget? trailing;
  final bool selected;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  Widget? _leadingWidget(ThemeData theme) {
    if (leadingWidget != null) {
      return leadingWidget!;
    } else if (leading != null) {
      return ImageIcon(
        AssetImage(leading!),
        color: selected
            ? theme.colorScheme.onPrimary
            : theme.iconTheme.color!.withOpacity(0.5),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
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
        leading: _leadingWidget(theme),
        title: title,
        trailing: trailing,
      ),
    );
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: const DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 20,
                blurRadius: 20,
              ),
            ],
          ),
          child: Material(child: Menu()),
        ),
      ),
    );
  }
}

class MenuDrawerAnimation extends StatelessWidget {
  const MenuDrawerAnimation({
    required this.begin,
    required this.end,
    required this.primaryAnimation,
    required this.child,
    super.key, // ignore: unused_element
  });

  final Animation<double> primaryAnimation;
  final Offset begin;
  final Offset end;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Opacity(
            opacity: primaryAnimation.value,
            child: const Align(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: SizedBox.expand(),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: end,
            ).animate(
              CurvedAnimation(
                parent: primaryAnimation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class MenuDrawerButton extends StatelessWidget {
  const MenuDrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AppIconButton(
        onPressed: () {
          final state = GoRouterState.of(context);

          GoRouter.maybeOf(context)!.go(
            '${state.uri}/myDrawer',
          );
        },
        icon: const Align(child: Icon(Symbols.menu_open_rounded)),
      ),
    );
  }
}
