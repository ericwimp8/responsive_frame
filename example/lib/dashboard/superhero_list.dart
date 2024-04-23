import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class SuperHeroList extends StatefulWidget {
  const SuperHeroList({super.key});

  @override
  State<SuperHeroList> createState() => _SuperHeroListState();
}

class _SuperHeroListState extends State<SuperHeroList> {
  String searchFilter = '';
  void _filterList(String newFilter) {
    setState(() {
      searchFilter = newFilter;
    });
  }

  void selecteHero(SuperHero value, SuperHeroState state) {
    state.setSelectedHero(value);
  }

  @override
  Widget build(BuildContext context) {
    final state = SuperHeroData.of(context);
    final superheroList = state.data.superheroList
        .where((element) => element.name.toLowerCase().contains(searchFilter))
        .toList();
    final selectedHero = state.data.selectedHero;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Search(
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
                    key: ValueKey(superheroList.length),
                    superheroList: superheroList,
                    selectedHero: selectedHero,
                    onChanged: (value) => selecteHero(value, state),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuperHeroList extends StatelessWidget {
  const _SuperHeroList({
    required this.superheroList,
    required this.onChanged,
    required this.selectedHero,
    super.key,
  });

  final List<SuperHero> superheroList;
  final SuperHero selectedHero;
  final ValueChanged<SuperHero> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: ListView.builder(
        itemCount: superheroList.length,
        itemBuilder: (context, index) {
          final superHero = superheroList[index];
          final selected = superHero == selectedHero;
          return ListTile(
            selected: selected,
            textColor: theme.colorScheme.onSurface,
            onTap: () => onChanged(superHero),
            shape: const RoundedRectangleBorder(),
            title: Text(superHero.name),
          );
        },
      ),
    );
  }
}
