import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:with_value/with_value.dart';

class SelectedSuperheroWrapper extends StatefulWidget {
  const SelectedSuperheroWrapper({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, Superhero superhero) builder;

  @override
  State<SelectedSuperheroWrapper> createState() =>
      _SelectedSuperheroWrapperState();
}

class _SelectedSuperheroWrapperState extends State<SelectedSuperheroWrapper> {
  Superhero? superhero;

  @override
  void didChangeDependencies() {
    final routerState = GoRouterState.of(context);
    final heroId = getParamIndex(routerState);
    final superhero =
        WithValueUpdate.of<SuperheroState>(context).getHeroFromID(heroId);

    if (this.superhero != superhero) {
      this.superhero = superhero;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WithValue<Superhero>(
      value: superhero!,
      child: Builder(
        builder: (context) {
          final superhero = WithValue.of<Superhero>(context);
          return widget.builder(context, superhero);
        },
      ),
    );
  }
}
