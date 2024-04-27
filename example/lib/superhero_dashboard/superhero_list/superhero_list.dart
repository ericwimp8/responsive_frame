import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:with_value/with_value.dart';

class SuperheroList extends StatefulWidget {
  const SuperheroList({super.key});

  @override
  State<SuperheroList> createState() => _SuperheroListState();
}

class _SuperheroListState extends State<SuperheroList> {
  void selectHero(int id) {
    GoRouter.of(context).go(
      '${RoutePaths.superHeroDashBoard}/${SuperheroeDashboardLocation.overview.name}/$id',
    );
  }

  HeroFilter? heroFilter;

  @override
  void didChangeDependencies() {
    if (heroFilter == null) {
      final routerState = GoRouterState.of(context);
      final state = WithValueUpdate.of<SuperheroState>(context);
      final location =
          getRouteLocation(SuperheroeDashboardLocation.values, routerState);
      final heroFilter = state.getFilterFromLocation(location);

      this.heroFilter = heroFilter;
      Future(() {
        state.searchAndFilter(heroFilter: heroFilter);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SuperheroListWrapper(
      isFiltered: true,
      builder: (context, value, child) => Material(
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: value.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final superhero = value[index];
            return ListTile(
              onTap: () => selectHero(superhero.id),
              title: Text(superhero.name),
            );
          },
        ),
      ),
    );
  }
}
