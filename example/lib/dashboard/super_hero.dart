import 'package:flutter/foundation.dart';

@immutable
class SuperHero {
  const SuperHero({
    required this.id,
    required this.name,
    required this.slug,
    required this.powerstats,
    required this.appearance,
    required this.biography,
    required this.work,
    required this.connections,
    required this.images,
  });

  factory SuperHero.fromJson(Map<String, dynamic> json) {
    return SuperHero(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      powerstats:
          PowerStats.fromJson(json['powerstats'] as Map<String, dynamic>),
      appearance:
          Appearance.fromJson(json['appearance'] as Map<String, dynamic>),
      biography: Biography.fromJson(json['biography'] as Map<String, dynamic>),
      work: Work.fromJson(json['work'] as Map<String, dynamic>),
      connections:
          Connections.fromJson(json['connections'] as Map<String, dynamic>),
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
    );
  }
  final int id;
  final String name;
  final String slug;
  final PowerStats powerstats;
  final Appearance appearance;
  final Biography biography;
  final Work work;
  final Connections connections;
  final Images images;

  @override
  String toString() {
    return 'SuperHero(id: $id, name: $name, slug: $slug, powerstats: $powerstats, appearance: $appearance, biography: $biography, work: $work, connections: $connections, images: $images)';
  }

  SuperHero copyWith({
    int? id,
    String? name,
    String? slug,
    PowerStats? powerstats,
    Appearance? appearance,
    Biography? biography,
    Work? work,
    Connections? connections,
    Images? images,
  }) {
    return SuperHero(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      powerstats: powerstats ?? this.powerstats,
      appearance: appearance ?? this.appearance,
      biography: biography ?? this.biography,
      work: work ?? this.work,
      connections: connections ?? this.connections,
      images: images ?? this.images,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuperHero &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.powerstats == powerstats &&
        other.appearance == appearance &&
        other.biography == biography &&
        other.work == work &&
        other.connections == connections &&
        other.images == images;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        slug.hashCode ^
        powerstats.hashCode ^
        appearance.hashCode ^
        biography.hashCode ^
        work.hashCode ^
        connections.hashCode ^
        images.hashCode;
  }
}

@immutable
class PowerStats {
  const PowerStats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory PowerStats.fromJson(Map<String, dynamic> json) {
    return PowerStats(
      intelligence: json['intelligence'] as int,
      strength: json['strength'] as int,
      speed: json['speed'] as int,
      durability: json['durability'] as int,
      power: json['power'] as int,
      combat: json['combat'] as int,
    );
  }
  final int intelligence;
  final int strength;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  Map<PowerStatsEnum, int> get values => {
        PowerStatsEnum.intelligence: intelligence,
        PowerStatsEnum.strength: strength,
        PowerStatsEnum.speed: speed,
        PowerStatsEnum.durability: durability,
        PowerStatsEnum.power: power,
        PowerStatsEnum.combat: combat,
      };

  PowerStats copyWith({
    int? intelligence,
    int? strength,
    int? speed,
    int? durability,
    int? power,
    int? combat,
  }) {
    return PowerStats(
      intelligence: intelligence ?? this.intelligence,
      strength: strength ?? this.strength,
      speed: speed ?? this.speed,
      durability: durability ?? this.durability,
      power: power ?? this.power,
      combat: combat ?? this.combat,
    );
  }

  @override
  String toString() {
    return 'PowerStats(intelligence: $intelligence, strength: $strength, speed: $speed, durability: $durability, power: $power, combat: $combat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PowerStats &&
        other.intelligence == intelligence &&
        other.strength == strength &&
        other.speed == speed &&
        other.durability == durability &&
        other.power == power &&
        other.combat == combat;
  }

  @override
  int get hashCode {
    return intelligence.hashCode ^
        strength.hashCode ^
        speed.hashCode ^
        durability.hashCode ^
        power.hashCode ^
        combat.hashCode;
  }
}

enum PowerStatsEnum {
  intelligence('Intelligence'),
  strength('Strength'),
  speed('Speed'),
  durability('Durability'),
  power('Power'),
  combat('Combat');

  const PowerStatsEnum(this.label);
  final String label;
}

@immutable
class Appearance {
  const Appearance({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      gender: json['gender'] as String,
      race: json['race'] as String? ?? '-',
      height: List<String>.from(json['height'] as List<dynamic>),
      weight: List<String>.from(json['weight'] as List<dynamic>),
      eyeColor: json['eyeColor'] as String,
      hairColor: json['hairColor'] as String,
    );
  }
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;

  Appearance copyWith({
    String? gender,
    String? race,
    List<String>? height,
    List<String>? weight,
    String? eyeColor,
    String? hairColor,
  }) {
    return Appearance(
      gender: gender ?? this.gender,
      race: race ?? this.race,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      eyeColor: eyeColor ?? this.eyeColor,
      hairColor: hairColor ?? this.hairColor,
    );
  }

  @override
  String toString() {
    return 'Appearance(gender: $gender, race: $race, height: $height, weight: $weight, eyeColor: $eyeColor, hairColor: $hairColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appearance &&
        other.gender == gender &&
        other.race == race &&
        listEquals(other.height, height) &&
        listEquals(other.weight, weight) &&
        other.eyeColor == eyeColor &&
        other.hairColor == hairColor;
  }

  @override
  int get hashCode {
    return gender.hashCode ^
        race.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        eyeColor.hashCode ^
        hairColor.hashCode;
  }
}

@immutable
class Biography {
  const Biography({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['fullName'] as String? ?? '-',
      alterEgos: json['alterEgos'] as String? ?? '-',
      aliases: List<String>.from(json['aliases'] as List<dynamic>),
      placeOfBirth: json['placeOfBirth'] as String? ?? '-',
      firstAppearance: json['firstAppearance'] as String? ?? '-',
      publisher: json['publisher'] as String? ?? '-',
      alignment: json['alignment'] as String? ?? '-',
    );
  }
  final String fullName;
  final String alterEgos;
  final List<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Biography &&
        other.fullName == fullName &&
        other.alterEgos == alterEgos &&
        listEquals(other.aliases, aliases) &&
        other.placeOfBirth == placeOfBirth &&
        other.firstAppearance == firstAppearance &&
        other.publisher == publisher &&
        other.alignment == alignment;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        alterEgos.hashCode ^
        aliases.hashCode ^
        placeOfBirth.hashCode ^
        firstAppearance.hashCode ^
        publisher.hashCode ^
        alignment.hashCode;
  }

  @override
  String toString() {
    return 'Biography(fullName: $fullName, alterEgos: $alterEgos, aliases: $aliases, placeOfBirth: $placeOfBirth, firstAppearance: $firstAppearance, publisher: $publisher, alignment: $alignment)';
  }

  Biography copyWith({
    String? fullName,
    String? alterEgos,
    List<String>? aliases,
    String? placeOfBirth,
    String? firstAppearance,
    String? publisher,
    String? alignment,
  }) {
    return Biography(
      fullName: fullName ?? this.fullName,
      alterEgos: alterEgos ?? this.alterEgos,
      aliases: aliases ?? this.aliases,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      firstAppearance: firstAppearance ?? this.firstAppearance,
      publisher: publisher ?? this.publisher,
      alignment: alignment ?? this.alignment,
    );
  }
}

@immutable
class Work {
  const Work({
    required this.occupation,
    required this.base,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      occupation: json['occupation'] as String,
      base: json['base'] as String,
    );
  }
  final String occupation;
  final String base;

  Work copyWith({
    String? occupation,
    String? base,
  }) {
    return Work(
      occupation: occupation ?? this.occupation,
      base: base ?? this.base,
    );
  }

  @override
  String toString() => 'Work(occupation: $occupation, base: $base)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Work &&
        other.occupation == occupation &&
        other.base == base;
  }

  @override
  int get hashCode => occupation.hashCode ^ base.hashCode;
}

@immutable
class Connections {
  const Connections({
    required this.groupAffiliation,
    required this.relatives,
  });

  factory Connections.fromJson(Map<String, dynamic> json) {
    return Connections(
      groupAffiliation: json['groupAffiliation'] as String,
      relatives: json['relatives'] as String,
    );
  }
  final String groupAffiliation;
  final String relatives;

  Connections copyWith({
    String? groupAffiliation,
    String? relatives,
  }) {
    return Connections(
      groupAffiliation: groupAffiliation ?? this.groupAffiliation,
      relatives: relatives ?? this.relatives,
    );
  }

  @override
  String toString() =>
      'Connections(groupAffiliation: $groupAffiliation, relatives: $relatives)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Connections &&
        other.groupAffiliation == groupAffiliation &&
        other.relatives == relatives;
  }

  @override
  int get hashCode => groupAffiliation.hashCode ^ relatives.hashCode;
}

@immutable
class Images {
  const Images({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      xs: json['xs'] as String,
      sm: json['sm'] as String,
      md: json['md'] as String,
      lg: json['lg'] as String,
    );
  }
  final String xs;
  final String sm;
  final String md;
  final String lg;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Images &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg;
  }

  @override
  int get hashCode {
    return xs.hashCode ^ sm.hashCode ^ md.hashCode ^ lg.hashCode;
  }

  Images copyWith({
    String? xs,
    String? sm,
    String? md,
    String? lg,
  }) {
    return Images(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  String toString() {
    return 'Images(xs: $xs, sm: $sm, md: $md, lg: $lg)';
  }
}
