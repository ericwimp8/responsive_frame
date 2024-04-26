import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class SuperheroListWrapper extends StatelessWidget {
  const SuperheroListWrapper({
    required this.builder,
    super.key,
    this.isFiltered = false,
  });
  final ValueWidgetBuilder<List<Superhero>> builder;
  final bool isFiltered;
  @override
  Widget build(BuildContext context) {
    return Selector<WithUpdate<SuperheroState>, List<Superhero>>(
      builder: builder,
      selector: (
        context,
        value,
      ) {
        if (isFiltered) {
          return value.notifier!.data.superheroListFiltered;
        }
        return value.notifier!.data.superheroList;
      },
    );
  }
}