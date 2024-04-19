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
          Powerstats.fromJson(json['powerstats'] as Map<String, dynamic>),
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
  final Powerstats powerstats;
  final Appearance appearance;
  final Biography biography;
  final Work work;
  final Connections connections;
  final Images images;
}

class Powerstats {
  const Powerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory Powerstats.fromJson(Map<String, dynamic> json) {
    return Powerstats(
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
}

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
}

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
}

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
}

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
}

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
}
