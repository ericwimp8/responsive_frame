import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuperheroList extends StatelessWidget {
  const SuperheroList({super.key});

  @override
  Widget build(BuildContext context) {
    final routeState = GoRouterState.of(context);
    final location =
        getRouteLocation(SuperheroeDashboardLocation.values, routeState);
    final superHeroDataState = SuperheroData.of(context);
    final superheroList = superHeroDataState.data.filteredList(location);
    return DashboardCard(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          final superhero = superheroList[index];
          return ListTile(
            title: Text(superhero.name),
          );
        },
      ),
    );
  }
}
