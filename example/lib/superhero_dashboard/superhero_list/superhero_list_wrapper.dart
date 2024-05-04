import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class SuperheroListWrapper extends StatefulWidget {
  const SuperheroListWrapper({
    required this.builder,
    super.key,
    this.isFiltered = false,
  });
  final Widget Function(List<Superhero> items) builder;
  final bool isFiltered;

  @override
  State<SuperheroListWrapper> createState() => _SuperheroListWrapperState();
}

class _SuperheroListWrapperState extends State<SuperheroListWrapper> {
  @override
  Widget build(BuildContext context) {
    return Selector<WithValueUpdate<SuperheroState>, List<Superhero>>(
      builder: (__, value, _) => widget.builder(value),
      selector: (
        context,
        value,
      ) {
        if (widget.isFiltered) {
          return value.notifier!.data.superheroListFiltered;
        }
        return value.notifier!.data.superheroList;
      },
    );
  }
}
