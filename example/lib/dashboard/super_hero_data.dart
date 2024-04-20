import 'dart:convert';

import 'package:example/barrel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List<SuperHero> _parseHeroes(String superHeroes) {
  return (jsonDecode(superHeroes) as List)
      .map((e) => SuperHero.fromJson(e as Map<String, dynamic>))
      .toList();
}

@immutable
class SuperHeroDataModel {
  const SuperHeroDataModel({
    required this.heroList,
    required this.selectedHero,
    required this.selectedPowerStat,
  });
  final List<SuperHero> heroList;
  final SuperHero selectedHero;
  final PowerStatsEnum selectedPowerStat;

  static const empty = SuperHeroDataModel(
    heroList: [],
    selectedHero: SuperHero(
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

  SuperHeroDataModel copyWith({
    List<SuperHero>? heroList,
    SuperHero? selectedHero,
    PowerStatsEnum? selectedPowerStat,
  }) {
    return SuperHeroDataModel(
      heroList: heroList ?? this.heroList,
      selectedHero: selectedHero ?? this.selectedHero,
      selectedPowerStat: selectedPowerStat ?? this.selectedPowerStat,
    );
  }

  @override
  String toString() =>
      'SuperHeroDataModel(heroList: $heroList, selectedHero: $selectedHero, selectedPowerStat: $selectedPowerStat)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuperHeroDataModel &&
        other.selectedHero == selectedHero &&
        other.selectedPowerStat == selectedPowerStat;
  }

  @override
  int get hashCode => selectedHero.hashCode ^ selectedPowerStat.hashCode;
}

class SuperHeroState with ChangeNotifier {
  SuperHeroState() {
    init();
  }

  Future<void> init() async {
    final heroList = await compute(_parseHeroes, jsonEncode(superHeroJson));

    _data = SuperHeroDataModel(
      heroList: heroList,
      selectedHero: heroList.first,
      selectedPowerStat: PowerStatsEnum.intelligence,
    );
    notifyListeners();
  }

  SuperHeroDataModel _data = SuperHeroDataModel.empty;
  SuperHeroDataModel get data => _data;

  void setSelectedHero(SuperHero value) {
    _data = _data.copyWith(selectedHero: value);
    notifyListeners();
  }

  void setSelectedPowerStat(PowerStatsEnum value) {
    _data = _data.copyWith(selectedPowerStat: value);

    notifyListeners();
  }
}

class SuperHeroData extends InheritedNotifier<SuperHeroState> {
  const SuperHeroData({
    required SuperHeroState super.notifier,
    required super.child,
    super.key,
  });

  static SuperHeroState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<SuperHeroData>();
    if (result == null) {
      throw FlutterError(
        'SuperHeroData was not found in the widget tree. Make sure to wrap your widget tree with a SuperHeroData.',
      );
    }
    return result.notifier!;
  }

  @override
  bool updateShouldNotify(SuperHeroData oldWidget) {
    return oldWidget.notifier?.data != notifier?.data;
  }
}
