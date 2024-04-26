import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuperheroWrapper extends StatelessWidget {
  const SuperheroWrapper({
    required this.superhero,
    required this.child,
    super.key,
  });
  final Superhero superhero;
  final WidgetBuilder child;

  @override
  Widget build(BuildContext context) {
    return With<Superhero>(
      value: superhero,
      child: Builder(builder: child),
    );
  }
}

class SuperheroOverviewBody extends StatefulWidget {
  const SuperheroOverviewBody({super.key});

  @override
  State<SuperheroOverviewBody> createState() => _SuperheroOverviewBodyState();
}

class _SuperheroOverviewBodyState extends State<SuperheroOverviewBody> {
  GoRouterState? routerState;
  int? heroId;
  Superhero? superhero;

  @override
  void didChangeDependencies() {
    routerState = GoRouterState.of(context);
    heroId = getParamIndex(routerState!);
    final superhero =
        WithUpdate.of<SuperheroState>(context).getHeroFromID(heroId!);

    if (this.superhero != superhero) {
      this.superhero = superhero;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SuperheroWrapper(
      superhero: superhero!,
      child: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: DashboardCard(
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: const SuperHeroOverview(),
                  ),
                ),
                VerticalDivider(
                  width: 80,
                  endIndent: 10,
                  indent: 10,
                  color: theme.colorScheme.onSurface.withOpacity(0.07),
                ),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: const Statistics(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
