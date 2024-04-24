import 'dart:convert';

import 'package:example/barrel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List<Superhero> _parseHeroes(String superHeroes) {
  return (jsonDecode(superHeroes) as List)
      .map((e) => Superhero.fromJson(e as Map<String, dynamic>))
      .toList();
}

@immutable
class SuperheroDataModel {
  const SuperheroDataModel({
    required this.superheroList,
    required this.selectedHero,
    required this.selectedPowerStat,
    required this.heroFilter,
  });
  final List<Superhero> superheroList;
  final Superhero selectedHero;
  final PowerStatsEnum selectedPowerStat;
  final HeroFilter heroFilter;

  List<Superhero> filteredList() {
    return switch (heroFilter) {
      HeroFilter.all => superheroList,
      HeroFilter.superHeroes => [
          ...superheroList
              .where((element) => element.biography.alignment == 'good'),
        ],
      HeroFilter.villans => [
          ...superheroList
              .where((element) => element.biography.alignment == 'bad'),
        ],
      HeroFilter.masterMinds => [
          ...superheroList
              .where((element) => element.powerstats.intelligence > 95),
        ],
      HeroFilter.battleHardened => [
          ...superheroList.where(
            (element) =>
                element.powerstats.durability >= 85 &&
                element.powerstats.combat >= 85 &&
                element.powerstats.power >= 85,
          ),
        ],
    };
  }

  static const empty = SuperheroDataModel(
    heroFilter: HeroFilter.all,
    superheroList: [],
    selectedHero: Superhero(
      id: -1,
      name: '',
      slug: '',
      powerstats: PowerStats(
        intelligence: -1,
        strength: -1,
        speed: -1,
        durability: -1,
        power: -1,
        combat: -1,
      ),
      appearance: Appearance(
        gender: '',
        race: '',
        heightImperial: '',
        heightMetric: '',
        weightImperial: '',
        weightMetric: '',
        eyeColor: '',
        hairColor: '',
      ),
      biography: Biography(
        fullName: '',
        alterEgos: '',
        aliases: [],
        placeOfBirth: '',
        firstAppearance: '',
        publisher: '',
        alignment: '',
      ),
      work: Work(occupation: '', base: ''),
      connections: Connections(groupAffiliation: '', relatives: ''),
      images: Images(xs: '', sm: '', md: '', lg: ''),
    ),
    selectedPowerStat: PowerStatsEnum.intelligence,
  );

  SuperheroDataModel copyWith({
    List<Superhero>? superheroList,
    Superhero? selectedHero,
    PowerStatsEnum? selectedPowerStat,
    HeroFilter? heroFilter,
  }) {
    return SuperheroDataModel(
      superheroList: superheroList ?? this.superheroList,
      selectedHero: selectedHero ?? this.selectedHero,
      selectedPowerStat: selectedPowerStat ?? this.selectedPowerStat,
      heroFilter: heroFilter ?? this.heroFilter,
    );
  }

  @override
  String toString() {
    return 'SuperHeroDataModel(superheroList: $superheroList, selectedHero: $selectedHero, selectedPowerStat: $selectedPowerStat, heroFilter: $heroFilter)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuperheroDataModel &&
        listEquals(other.superheroList, superheroList) &&
        other.selectedHero == selectedHero &&
        other.selectedPowerStat == selectedPowerStat &&
        other.heroFilter == heroFilter;
  }

  @override
  int get hashCode {
    return superheroList.hashCode ^
        selectedHero.hashCode ^
        selectedPowerStat.hashCode ^
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
      heroFilter: HeroFilter.all,
      superheroList: heroList,
      selectedHero: heroList.first,
      selectedPowerStat: PowerStatsEnum.intelligence,
    );
    notifyListeners();
  }

  SuperheroDataModel _data = SuperheroDataModel.empty;
  SuperheroDataModel get data => _data;

  void setSelectedHero(Superhero value) {
    _data = _data.copyWith(selectedHero: value);
    notifyListeners();
  }

  void setSelectedPowerStat(PowerStatsEnum value) {
    _data = _data.copyWith(selectedPowerStat: value);
    notifyListeners();
  }

  void updateHeroFilter(HeroFilter filter) {
    _data = _data.copyWith(heroFilter: filter);
    notifyListeners();
  }
}

class SuperheroData extends InheritedNotifier<SuperheroState> {
  const SuperheroData({
    required SuperheroState super.notifier,
    required super.child,
    super.key,
  });

  static SuperheroState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<SuperheroData>();
    if (result == null) {
      throw FlutterError(
        'SuperHeroData was not found in the widget tree. Make sure to wrap your widget tree with a SuperHeroData.',
      );
    }
    return result.notifier!;
  }

  @override
  bool updateShouldNotify(SuperheroData oldWidget) {
    return oldWidget.notifier?.data != notifier?.data;
  }
}
