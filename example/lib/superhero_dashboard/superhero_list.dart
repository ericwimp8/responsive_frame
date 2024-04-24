import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_frame/responsive_frame.dart';

class SuperHeroList extends StatefulWidget {
  const SuperHeroList({super.key});

  @override
  State<SuperHeroList> createState() => _SuperHeroListState();
}

class _SuperHeroListState extends State<SuperHeroList> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String searchFilter = '';
  void _filterList(String newFilter) {
    setState(() {
      searchFilter = newFilter;
    });
  }

  void selectHero(Superhero value, SuperheroState state) {
    state.setSelectedHero(value);
  }

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = SuperheroData.of(context);
    final superheroList = state.data
        .filteredList()
        .where((element) => element.name.toLowerCase().contains(searchFilter))
        .toList();

    final selectedHero = state.data.selectedHero;

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
                selectHero(superheroList[selectedIndex], state);
              },
              const SingleActivator(LogicalKeyboardKey.escape):
                  controller.clear,
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Search(
                      controller: controller,
                      onChanged: _filterList,
                      clear: () => _filterList(''),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ClipRRect(
                        borderRadius: kDefaultBorderRadius,
                        child: AppAnimatedSwitcherSlideFade(
                          begin: const Offset(0, 0.03),
                          duration: const Duration(milliseconds: 300),
                          child: _SuperHeroList(
                            onIndexChanged: updateSelectedIndex,
                            selectedIndex: selectedIndex,
                            key: ValueKey(superheroList.length),
                            superheroList: superheroList,
                            selectedHero: selectedHero,
                            onChanged: (value) => selectHero(value, state),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SuperHeroList extends StatelessWidget {
  const _SuperHeroList({
    required this.superheroList,
    required this.onChanged,
    required this.selectedHero,
    required this.selectedIndex,
    required this.onIndexChanged,
    super.key,
  });

  final List<Superhero> superheroList;
  final Superhero selectedHero;
  final ValueChanged<Superhero> onChanged;
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  void onFocusChange(bool value, int index) {
    if (value) {
      onIndexChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: ListView.builder(
        itemCount: superheroList.length,
        itemBuilder: (context, index) {
          final superHero = superheroList[index];
          final selected = superHero == selectedHero;
          return SuperHeroTile(
            superHero: superHero,
            selected: selected,
            index: index,
            theme: theme,
            onChanged: onChanged,
            onFocusChanged: onFocusChange,
          );
        },
      ),
    );
  }
}

class SuperHeroTile extends StatefulWidget {
  const SuperHeroTile({
    required this.superHero,
    required this.selected,
    required this.index,
    required this.theme,
    required this.onChanged,
    required this.onFocusChanged,
    super.key,
  });
  final Superhero superHero;
  final bool selected;
  final int index;
  final ThemeData theme;
  final ValueChanged<Superhero> onChanged;
  final void Function(bool focus, int index) onFocusChanged;

  @override
  State<SuperHeroTile> createState() => _SuperHeroTileState();
}

class _SuperHeroTileState extends State<SuperHeroTile> {
  bool hasFocus = false;

  void onFocus(bool value) {
    setState(() {
      hasFocus = value;
    });
    widget.onFocusChanged(value, widget.index);
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
      onTap: () => widget.onChanged(widget.superHero),
      shape: const RoundedRectangleBorder(),
      title: Text(widget.superHero.name),
    );
  }
}