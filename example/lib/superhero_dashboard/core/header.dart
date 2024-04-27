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

  @override
  void initState() {
    setInitialSearchValue();
    super.initState();
  }

  void setInitialSearchValue() {
    Future(() {
      if (mounted) {
        final search = WithValueUpdate.of<SuperheroState>(context).data.search;
        controller.text = search;
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routeState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);
    final filter = WithValueUpdate.of<SuperheroState>(context)
        .getFilterFromLocation(location);
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
                  label: 'All',
                  value: HeroFilter.all,
                  groupValue: filter,
                ),
                HeroFilter.superheroes: _SegmentButton(
                  label: 'Superheroes',
                  value: HeroFilter.superheroes,
                  groupValue: filter,
                ),
                HeroFilter.villains: _SegmentButton(
                  label: 'Villains',
                  value: HeroFilter.villains,
                  groupValue: filter,
                ),
                HeroFilter.masterMinds: _SegmentButton(
                  label: 'Maste Minds',
                  value: HeroFilter.masterMinds,
                  groupValue: filter,
                ),
                HeroFilter.battleHardened: _SegmentButton(
                  label: 'Battle Hardened',
                  value: HeroFilter.battleHardened,
                  groupValue: filter,
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
    // ignore: unused_element
    super.key,
  });
  final String label;
  final HeroFilter value;
  final HeroFilter groupValue;
  TextStyle textStyle(
    ThemeData theme,
    HeroFilter filter,
    HeroFilter location,
  ) {
    return theme.textTheme.titleMedium!.copyWith(
      color: filter == location ? theme.colorScheme.onPrimary : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: TextNoOverflow(
        label,
        style: textStyle(
          theme,
          groupValue,
          value,
        ),
      ),
    );
  }
}
