import 'dart:convert';

class Country {
  final String name;
  final String capital;
  final String region;
  final String subRegion;
  final int population;
  final String flagUrl;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.subRegion,
    required this.population,
    required this.flagUrl,
  });

  Country copyWith({
    String? name,
    String? capital,
    String? region,
    String? subRegion,
    int? population,
    String? flagUrl,
  }) {
    return Country(
      name: name ?? this.name,
      capital: capital ?? this.capital,
      region: region ?? this.region,
      subRegion: subRegion ?? this.subRegion,
      population: population ?? this.population,
      flagUrl: flagUrl ?? this.flagUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'capital': capital,
      'region': region,
      'subRegion': subRegion,
      'population': population,
      'flagUrl': flagUrl,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'] as String,
      capital: map['capital'] as String,
      region: map['region'] as String,
      subRegion: map['subRegion'] as String,
      population: (map['population'] as num?)?.toInt() ?? 0,
      flagUrl: map['flagUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Country(name: $name, capital: $capital, region: $region, subRegion: $subRegion, population: $population, flagUrl: $flagUrl)';
  }

  @override
  bool operator ==(covariant Country other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.capital == capital &&
        other.region == region &&
        other.subRegion == subRegion &&
        other.population == population &&
        other.flagUrl == flagUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        capital.hashCode ^
        region.hashCode ^
        subRegion.hashCode ^
        population.hashCode ^
        flagUrl.hashCode;
  }
}
