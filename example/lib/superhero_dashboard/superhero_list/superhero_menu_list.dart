import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:with_value/with_value.dart';

class SuperheroMenuList extends StatefulWidget {
  const SuperheroMenuList({super.key});

  @override
  State<SuperheroMenuList> createState() => _SuperheroMenuListState();
}

class _SuperheroMenuListState extends State<SuperheroMenuList> {
  TextEditingController? controller;
  int focusedHeroId = 0;
  GoRouterState? routerState;
  int? heroId;
  Superhero? superhero;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void selectHero(int id) {
    GoRouter.of(context).go(
      '${RoutePaths.superHeroDashBoard}/${SuperheroeDashboardLocation.overview.name}/$id',
    );
  }

  void updateFocusHeroId(int id) {
    setState(() {
      focusedHeroId = id;
    });
  }

  void _search(String search) {
    WithValueUpdate.of<SuperheroState>(context).searchAndFilter(search: search);
  }

  @override
  void didChangeDependencies() {
    if (controller == null) {
      controller = TextEditingController();
      controller?.text =
          WithValueUpdate.of<SuperheroState>(context).data.search;
    }
    routerState = GoRouterState.of(context);
    heroId = getParamIndex(routerState!);

    final superhero =
        WithValueUpdate.of<SuperheroState>(context).getHeroFromID(heroId!);

    if (this.superhero != superhero) {
      this.superhero = superhero;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Builder(
        builder: (context) {
          return CallbackShortcuts(
            bindings: <ShortcutActivator, VoidCallback>{
              const SingleActivator(LogicalKeyboardKey.arrowUp): () {
                FocusScope.of(context).previousFocus();
              },
              const SingleActivator(LogicalKeyboardKey.arrowDown): () {
                FocusScope.of(context).nextFocus();
              },
              const SingleActivator(LogicalKeyboardKey.enter): () {
                selectHero(focusedHeroId);
              },
              const SingleActivator(LogicalKeyboardKey.escape):
                  controller!.clear,
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SearchInput(
                    controller: controller,
                    onChanged: _search,
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: kDefaultBorderRadius,
                    child: SuperheroListWrapper(
                      isFiltered: true,
                      builder: (_, value, __) {
                        return AppAnimatedSwitcherSlideFade(
                          begin: const Offset(0, 0.03),
                          duration: const Duration(milliseconds: 300),
                          child: _SuperheroList(
                            onFocus: updateFocusHeroId,
                            key: ValueKey(value.length),
                            superheroList: value,
                            selectedHero: superhero!,
                            onChanged: selectHero,
                          ),
                        );
                      },
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

class _SuperheroList extends StatelessWidget {
  const _SuperheroList({
    required this.superheroList,
    required this.onChanged,
    required this.onFocus,
    required this.selectedHero,
    super.key,
  });

  final List<Superhero> superheroList;
  final Superhero selectedHero;
  final ValueChanged<int> onChanged;
  final ValueChanged<int> onFocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: ListView.builder(
        itemCount: superheroList.length,
        itemBuilder: (context, index) {
          final superhero = superheroList[index];
          final selected = superhero == selectedHero;
          return SuperheroTile(
            superHero: superhero,
            selected: selected,
            index: index,
            theme: theme,
            onChanged: () => onChanged(superhero.id),
            onFocus: () => onFocus(superhero.id),
          );
        },
      ),
    );
  }
}

class SuperheroTile extends StatefulWidget {
  const SuperheroTile({
    required this.superHero,
    required this.selected,
    required this.index,
    required this.theme,
    required this.onChanged,
    required this.onFocus,
    super.key,
  });
  final Superhero superHero;
  final bool selected;
  final int index;
  final ThemeData theme;
  final VoidCallback onChanged;
  final void Function() onFocus;

  @override
  State<SuperheroTile> createState() => _SuperheroTileState();
}

class _SuperheroTileState extends State<SuperheroTile> {
  bool hasFocus = false;

  void onFocus(bool value) {
    setState(() {
      hasFocus = value;
    });
    if (value) {
      widget.onFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: widget.theme.colorScheme.secondary,
      autofocus: widget.index == 0,
      onFocusChange: onFocus,
      selected: widget.selected,
      textColor: hasFocus
          ? widget.theme.colorScheme.onSecondary
          : widget.theme.colorScheme.onSurface,
      onTap: () => widget.onChanged(),
      shape: const RoundedRectangleBorder(),
      title: TextNoOverflow(
        widget.superHero.name,
        textAlign: TextAlign.left,
      ),
    );
  }
}
