import 'package:example/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void navigate(SuperheroeDashboardLocation? location) {
    if (location != null) {
      GoRouter.of(context)
          .go('${RoutePaths.superHeroDashBoard}${location.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filter = getRouteLocation(
      SuperheroeDashboardLocation.values,
      GoRouterState.of(context),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoSlidingSegmentedControl<SuperheroeDashboardLocation>(
            backgroundColor: theme.colorScheme.surfaceTint,
            thumbColor: theme.colorScheme.primary,
            groupValue: filter,
            onValueChanged: navigate,
            children: <SuperheroeDashboardLocation, Widget>{
              SuperheroeDashboardLocation.all: _SegmentButton(
                label: 'All',
                value: SuperheroeDashboardLocation.all,
                groupValue: filter,
              ),
              SuperheroeDashboardLocation.superheroes: _SegmentButton(
                label: 'Superheroes',
                value: SuperheroeDashboardLocation.superheroes,
                groupValue: filter,
              ),
              SuperheroeDashboardLocation.villains: _SegmentButton(
                label: 'Villains',
                value: SuperheroeDashboardLocation.villains,
                groupValue: filter,
              ),
              SuperheroeDashboardLocation.masterMinds: _SegmentButton(
                label: 'Maste Minds',
                value: SuperheroeDashboardLocation.masterMinds,
                groupValue: filter,
              ),
              SuperheroeDashboardLocation.battleHardened: _SegmentButton(
                label: 'Battle Hardened',
                value: SuperheroeDashboardLocation.battleHardened,
                groupValue: filter,
              ),
            },
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
  final SuperheroeDashboardLocation value;
  final SuperheroeDashboardLocation groupValue;
  TextStyle textStyle(
    ThemeData theme,
    SuperheroeDashboardLocation filter,
    SuperheroeDashboardLocation location,
  ) {
    return theme.textTheme.titleMedium!.copyWith(
      color: filter == location ? theme.colorScheme.onPrimary : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
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
