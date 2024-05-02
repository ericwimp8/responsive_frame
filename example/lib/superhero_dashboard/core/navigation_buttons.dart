import 'package:example/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:with_value/with_value.dart';

class NavigationButtons extends StatefulWidget {
  const NavigationButtons({super.key});

  @override
  State<NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  void navigate(BuildContext context, HeroFilter? location) {
    if (location != null) {
      GoRouter.of(context).go(
        '${RoutePaths.superHeroDashBoard}/${location.name}${RoutePaths.noIndex}',
      );
    }
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

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoSlidingSegmentedControl<HeroFilter>(
      padding: EdgeInsets.zero,
      backgroundColor: theme.colorScheme.surfaceTint,
      thumbColor: theme.colorScheme.primary,
      groupValue: filter,
      onValueChanged: (value) => navigate(context, value),
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
    );
  }
}

class _SegmentButton extends StatefulWidget {
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

  @override
  State<_SegmentButton> createState() => _SegmentButtonState();
}

class _SegmentButtonState extends State<_SegmentButton> {
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ImageIcon(
            AssetImage(widget.iconPath),
            size: 20,
            color: widget.groupValue == widget.value
                ? theme.colorScheme.onPrimary
                : null,
          ),
          const Gap(4),
          Row(
            children: [
              Expanded(
                child: TextNoOverflow(
                  widget.label,
                  style: textStyle(
                    theme,
                    widget.value,
                    widget.groupValue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
