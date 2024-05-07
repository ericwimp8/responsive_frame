import 'dart:ui';

import 'package:animated_switcher_wrapper/animated_switcher_wrapper.dart';
import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:with_value/with_value.dart';

class SuperheroGrid extends StatefulWidget {
  const SuperheroGrid({super.key, this.crossAxisCount = 5});
  final int crossAxisCount;
  @override
  State<SuperheroGrid> createState() => _SuperheroGridState();
}

class _SuperheroGridState extends State<SuperheroGrid> {
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
    final theme = Theme.of(context);
    return SuperheroListWrapper(
      isFiltered: true,
      builder: (value) => Material(
        child: AnimatedSwitcherScaleFade(
          scaleBegin: 0.9,
          child: GridView.builder(
            key: ValueKey(value.length),
            itemCount: value.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final superhero = value[index];
              return GestureDetector(
                onTap: () => selectHero(superhero.id),
                child: _ProfileImage(
                  theme: theme,
                  provider: AssetImage(superhero.images.sm),
                  superhero: superhero,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({
    required this.theme,
    required this.provider,
    required this.superhero,
    // ignore: unused_element
    super.key,
  });

  final ThemeData theme;
  final AssetImage? provider;
  final Superhero superhero;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        side: BorderSide(
          width: 3,
          color: theme.colorScheme.surface.withOpacity(0.5),
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
            image: provider!,
          ),
        ),
        child: BackdropFilter(
          blendMode: BlendMode.src,
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Align(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
              child: Column(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 20,
                      shadowColor: Colors.black,
                      clipBehavior: Clip.antiAlias,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          color: theme.colorScheme.surface.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Image(
                          fit: BoxFit.cover,
                          image: provider!,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(6)),
                  TextNoOverflow(
                    superhero.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      height: 0,
                      fontSize: 15,
                      fontFamily: 'JosefinSans',
                      fontVariations: <FontVariation>[
                        FontVariation('wght', 400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
