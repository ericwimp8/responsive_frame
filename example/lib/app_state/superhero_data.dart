import 'dart:convert';
import 'package:example/barrel.dart';
import 'package:flutter/foundation.dart';

List<Superhero> _parseHeroes(String superHeroes) {
  return (jsonDecode(superHeroes) as List)
      .map((e) => Superhero.fromJson(e as Map<String, dynamic>))
      .toList();
}

// This matches up with SuperheroeDashboardLocation in router.dart
// the names must be equal
enum HeroFilter {
  all,
  villains,
  superheroes,
  masterMinds,
  battleHardened,
}

@immutable
class SuperheroDataModel {
  const SuperheroDataModel({
    required this.superheroList,
    required this.superheroListFiltered,
    required this.search,
    required this.heroFilter,
  });
  final List<Superhero> superheroList;
  final List<Superhero> superheroListFiltered;
  final String search;
  final HeroFilter heroFilter;
  static const empty = SuperheroDataModel(
    heroFilter: HeroFilter.all,
    search: '',
    superheroList: [],
    superheroListFiltered: [],
  );

  SuperheroDataModel copyWith({
    List<Superhero>? superheroList,
    List<Superhero>? superheroListFiltered,
    String? search,
    HeroFilter? heroFilter,
  }) {
    return SuperheroDataModel(
      heroFilter: heroFilter ?? this.heroFilter,
      search: search ?? this.search,
      superheroList: superheroList ?? this.superheroList,
      superheroListFiltered:
          superheroListFiltered ?? this.superheroListFiltered,
    );
  }

  @override
  String toString() {
    return 'SuperheroDataModel(superheroList: $superheroList, superheroListFiltered: $superheroListFiltered, search: $search, heroFilter: $heroFilter)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuperheroDataModel &&
        listEquals(other.superheroList, superheroList) &&
        listEquals(other.superheroListFiltered, superheroListFiltered) &&
        other.search == search &&
        other.heroFilter == heroFilter;
  }

  @override
  int get hashCode {
    return superheroList.hashCode ^
        superheroListFiltered.hashCode ^
        search.hashCode ^
        heroFilter.hashCode;
  }
}

class SuperheroState with ChangeNotifier {
  SuperheroState() {
    init();
  }

// TODO(ericwimp): move this to be an initial value argument where it is passedin and taken from local persistence
  Future<void> init() async {
    final heroList = await compute(_parseHeroes, jsonEncode(superHeroJson));

    _data = SuperheroDataModel(
      search: '',
      heroFilter: HeroFilter.all,
      superheroList: List<Superhero>.unmodifiable(heroList),
      superheroListFiltered: heroList,
    );
    notifyListeners();
  }

  SuperheroDataModel _data = SuperheroDataModel.empty;
  SuperheroDataModel get data => _data;

  Iterable<Superhero> _filter(HeroFilter heroFilter) {
    return switch (heroFilter) {
      HeroFilter.all => _data.superheroList,
      HeroFilter.superheroes => [
          ..._data.superheroList
              .where((element) => element.biography.alignment == 'good'),
        ],
      HeroFilter.villains => [
          ..._data.superheroList
              .where((element) => element.biography.alignment == 'bad'),
        ],
      HeroFilter.masterMinds => [
          ..._data.superheroList
              .where((element) => element.powerstats.intelligence > 95),
        ],
      HeroFilter.battleHardened => [
          ..._data.superheroList.where(
            (element) =>
                element.powerstats.durability >= 85 &&
                element.powerstats.combat >= 85 &&
                element.powerstats.power >= 85,
          ),
        ],
    };
  }

  Iterable<Superhero> _search(String value, Iterable<Superhero> items) {
    if (_data.search.isEmpty) return items;
    return items.where((element) => element.name.toLowerCase().contains(value));
  }

  HeroFilter getFilterFromLocation(
    SuperheroeDashboardLocation location,
  ) {
    return switch (location) {
      SuperheroeDashboardLocation.all => HeroFilter.all,
      SuperheroeDashboardLocation.villains => HeroFilter.villains,
      SuperheroeDashboardLocation.superheroes => HeroFilter.superheroes,
      SuperheroeDashboardLocation.masterMinds => HeroFilter.masterMinds,
      SuperheroeDashboardLocation.battleHardened => HeroFilter.battleHardened,
      SuperheroeDashboardLocation.overview => _data.heroFilter,
    };
  }

  // cache the hero so we have some thing to return when go_router
  late Superhero _hero = _data.superheroList[0];

  Superhero getHeroFromID(int id) {
    if (id == -1 || id == _hero.id) return _hero;
    // ignore: join_return_with_assignment
    _hero = _data.superheroList.firstWhere(
      (element) {
        return element.id == id;
      },
      orElse: () {
        throw Exception('getHeroFromID: no hero with id: $id');
      },
    );
    return _hero;
  }

  void searchAndFilter({
    String? search,
    HeroFilter? heroFilter,
  }) {
    final filtered = _filter(heroFilter ?? _data.heroFilter);
    final searched = _search(search ?? _data.search, filtered);

    _data = _data.copyWith(
      search: search ?? _data.search,
      heroFilter: heroFilter ?? _data.heroFilter,
      superheroListFiltered: searched.toList(),
    );
    notifyListeners();
  }
}
