import 'package:example/barrel.dart';
import 'package:example/dashboard/super_hero.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class SuperHeroDataModel {
  const SuperHeroDataModel({
    required this.heroList,
    required this.selectedHero,
  });
  final List<SuperHero> heroList;
  final SuperHero selectedHero;

  static const empty = SuperHeroDataModel(
    heroList: [],
    selectedHero: SuperHero(
      id: -1,
      name: '',
      slug: '',
      powerstats: Powerstats(
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
        height: [],
        weight: [],
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
  );

  SuperHeroDataModel copyWith({
    List<SuperHero>? heroList,
    SuperHero? selectedHero,
  }) {
    return SuperHeroDataModel(
      heroList: heroList ?? this.heroList,
      selectedHero: selectedHero ?? this.selectedHero,
    );
  }

  @override
  String toString() =>
      'SuperHeroDataModel(heroList: $heroList, selectedHero: $selectedHero)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuperHeroDataModel &&
        listEquals(other.heroList, heroList) &&
        other.selectedHero == selectedHero;
  }

  @override
  int get hashCode => heroList.hashCode ^ selectedHero.hashCode;
}

class SuperHeroState with ChangeNotifier {
  SuperHeroState();

  SuperHeroDataModel _data = SuperHeroDataModel.empty;
  SuperHeroDataModel get state => _data;

  void setSelectedHero(SuperHero value) {
    _data = _data.copyWith(selectedHero: value);
    notifyListeners();
  }
}

class SuperHeroData extends InheritedNotifier<SuperHeroState> {
  const SuperHeroData({
    required this.data,
    required super.child,
    super.key,
  });

  final SuperHeroDataModel data;

  static SuperHeroData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SuperHeroData>();
  }

  static SuperHeroData of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No SuperHeroData found');
    return result!;
  }

  @override
  bool updateShouldNotify(SuperHeroData oldWidget) =>
      !identical(data, oldWidget.data);
}
