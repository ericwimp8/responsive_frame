import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:with_value/with_value.dart';

class SuperheroMenuList extends StatefulWidget {
  const SuperheroMenuList({super.key});

  @override
  State<SuperheroMenuList> createState() => _SuperheroMenuListState();
}

class _SuperheroMenuListState extends State<SuperheroMenuList> {
  GoRouterState? routerState;
  int? heroId;
  Superhero? superhero;

  TextEditingController controller = TextEditingController();
  int focusedHeroId = 0;

  @override
  void didChangeDependencies() {
    routerState = GoRouterState.of(context);
    heroId = getParamIndex(routerState!);
    final superhero =
        WithValueUpdate.of<SuperheroState>(context).getHeroFromID(heroId!);

    if (this.superhero != superhero) {
      this.superhero = superhero;
    }
    super.didChangeDependencies();
  }

  void selectHero(int id) {
    GoRouter.of(context).go(
      '${RoutePaths.superHeroDashBoard}/${SuperheroeDashboardLocation.overview.name}/$id',
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateFocusHeroId(int id) {
    setState(() {
      focusedHeroId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Builder(
        builder: (context) {
          return KeyboardListNavigation(
            upPressed: FocusScope.of(context).previousFocus,
            downPressed: FocusScope.of(context).nextFocus,
            enterPressed: () => selectHero(focusedHeroId),
            escapePressed: controller.clear,
            child: Column(
              children: [
                HeroSearch(controller: controller),
                const Gap(16),
                Expanded(
                  child: ClipRRect(
                    borderRadius: kDefaultBorderRadius,
                    child: SuperheroList(
                      isFiltered: true,
                      onFocus: updateFocusHeroId,
                      selectedHero: superhero!,
                      onChanged: selectHero,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
