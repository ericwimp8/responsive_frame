import 'package:animated_switcher_wrapper/animated_switcher_wrapper.dart';
import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class SuperheroList extends StatelessWidget {
  const SuperheroList({
    required this.onChanged,
    required this.onFocus,
    required this.selectedHero,
    required this.isFiltered,
    super.key,
  });

  final Superhero selectedHero;
  final ValueChanged<int> onChanged;
  final ValueChanged<int> onFocus;
  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SuperheroListWrapper(
      isFiltered: isFiltered,
      builder: (items) {
        return Align(
          child: AnimatedSwitcherSlideFade(
            slideBegin: const Offset(0, 0.03),
            duration: const Duration(milliseconds: 300),
            child: Material(
              key: ValueKey(items.length),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final superhero = items[index];
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
            ),
          ),
        );
      },
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
