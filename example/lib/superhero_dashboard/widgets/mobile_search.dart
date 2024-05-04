import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:with_value/with_value.dart';

class MobileSearchOverlay extends StatefulWidget {
  const MobileSearchOverlay({
    this.onTap,
    super.key,
  });
  final VoidCallback? onTap;
  @override
  State<MobileSearchOverlay> createState() => _MobileSearchOverlayState();
}

class _MobileSearchOverlayState extends State<MobileSearchOverlay> {
  final LayerLink layerLink = LayerLink();
  int? heroId;
  Superhero? superhero;
  int focusedHeroId = 0;
  final controller = TextEditingController();

  @override
  void dispose() {
    if (portalController.isShowing) {
      hideSearchList();
    }
    controller.dispose();
    super.dispose();
  }

  void selectHero(int id) {
    hideSearchList();
    GoRouter.of(context).go(
      '${RoutePaths.superHeroDashBoard}/${SuperheroeDashboardLocation.overview.name}/$id',
    );
  }

  void updateFocusHeroId(int id) {
    setState(() {
      focusedHeroId = id;
    });
  }

  void onEscapePressed() {
    controller.clear();
  }

  void buildPortal() {}

  final portalController = OverlayPortalController();
  void showSearchList() {
    portalController.show();
  }

  void hideSearchList() {
    portalController.hide();
  }

  void searchOnChanged(String value) {
    if (!portalController.isShowing) {
      showSearchList();
    }
  }

  @override
  void didChangeDependencies() {
    final routerState = GoRouterState.of(context);
    heroId = getParamIndex(routerState);
    final superhero =
        WithValueUpdate.of<SuperheroState>(context).getHeroFromID(heroId!);

    if (this.superhero != superhero) {
      this.superhero = superhero;
    }
    super.didChangeDependencies();
  }

  final heroListKey = GlobalKey();

  void clearSearch() {
    hideSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Builder(
        builder: (context) {
          return CompositedTransformTarget(
            link: layerLink,
            child: KeyboardListNavigation(
              key: heroListKey,
              upPressed: FocusScope.of(context).previousFocus,
              downPressed: FocusScope.of(context).nextFocus,
              enterPressed: () => selectHero(focusedHeroId),
              escapePressed: hideSearchList,
              child: OverlayPortal(
                controller: portalController,
                overlayChildBuilder: (context) {
                  final renderBox = heroListKey.currentContext!
                      .findRenderObject()! as RenderBox;
                  final size = renderBox.size;
                  return _HeroListOverlay(
                    size: size,
                    layerLink: layerLink,
                    superhero: superhero,
                    onChanged: selectHero,
                    onFocus: updateFocusHeroId,
                  );
                },
                child: HeroSearch(
                  onClear: hideSearchList,
                  onChanged: searchOnChanged,
                  controller: controller,
                  onTap: showSearchList,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeroListOverlay extends StatelessWidget {
  const _HeroListOverlay({
    required this.size,
    required this.layerLink,
    required this.superhero,
    required this.onChanged,
    required this.onFocus,
  });

  final Size size;
  final LayerLink layerLink;
  final Superhero? superhero;
  final ValueChanged<int> onChanged;
  final ValueChanged<int> onFocus;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: size.width,
        child: CompositedTransformFollower(
          offset: Offset(0, size.height + 8),
          link: layerLink,
          showWhenUnlinked: false,
          child: SuperheroList(
            onChanged: onChanged,
            onFocus: onFocus,
            selectedHero: superhero!,
            isFiltered: true,
          ),
        ),
      ),
    );
  }
}
