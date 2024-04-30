import 'package:example/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:with_value/with_value.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final controller = TextEditingController();

  void navigate(HeroFilter? location) {
    if (location != null) {
      GoRouter.of(context).go(
        '${RoutePaths.superHeroDashBoard}/${location.name}${RoutePaths.noIndex}',
      );
    }
  }

  void search(String value) {
    WithValueUpdate.of<SuperheroState>(context).searchAndFilter(search: value);
  }

  HeroFilter? filter;
  SuperheroeDashboardLocation? location;
  @override
  void didChangeDependencies() {
    final routeState = GoRouterState.of(context);
    final newLocation =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);

    if (newLocation != location) {
      location = newLocation;
      filter = WithValueUpdate.of<SuperheroState>(context)
          .getFilterFromLocation(location!);
    }

    controller.text = WithValueUpdate.of<SuperheroState>(context).data.search;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Search(
              onChanged: search,
              controller: controller,
            ),
          ),
          const Gap(16),
          Expanded(
            child: CupertinoSlidingSegmentedControl<HeroFilter>(
              backgroundColor: theme.colorScheme.surfaceTint,
              thumbColor: theme.colorScheme.primary,
              groupValue: filter,
              onValueChanged: navigate,
              children: <HeroFilter, Widget>{
                HeroFilter.all: _SegmentButton(
                  iconPath: 'assets/images/all.png',
                  label: 'All',
                  value: HeroFilter.all,
                  groupValue: filter!,
                ),
                HeroFilter.superheroes: _SegmentButton(
                  iconPath: 'assets/images/superheroes.png',
                  label: 'Superheroes',
                  value: HeroFilter.superheroes,
                  groupValue: filter!,
                ),
                HeroFilter.villains: _SegmentButton(
                  iconPath: 'assets/images/villains.png',
                  label: 'Villains',
                  value: HeroFilter.villains,
                  groupValue: filter!,
                ),
                HeroFilter.masterMinds: _SegmentButton(
                  iconPath: 'assets/images/intelligence.png',
                  label: 'Maste Minds',
                  value: HeroFilter.masterMinds,
                  groupValue: filter!,
                ),
                HeroFilter.battleHardened: _SegmentButton(
                  iconPath: 'assets/images/combat.png',
                  label: 'Battle Hardened',
                  value: HeroFilter.battleHardened,
                  groupValue: filter!,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.iconPath,
    // ignore: unused_element
    super.key,
  });
  final String label;
  final HeroFilter value;
  final HeroFilter groupValue;
  final String iconPath;
  TextStyle textStyle(
    ThemeData theme,
    HeroFilter filter,
    HeroFilter location,
  ) {
    return theme.textTheme.titleSmall!.copyWith(
      color: filter == location ? theme.colorScheme.onPrimary : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              children: [
                ImageIcon(
                  AssetImage(iconPath),
                  color:
                      groupValue == value ? theme.colorScheme.onPrimary : null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextNoOverflow(
                        label,
                        style: textStyle(
                          theme,
                          groupValue,
                          value,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Flexible(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 8),
          //     child: TextNoOverflow(
          //       label,
          //       style: textStyle(
          //         theme,
          //         groupValue,
          //         value,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
