import 'dart:convert';

import 'package:country_app/core/error/failure.dart';
import 'package:country_app/features/country/data/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_remote_datasource.g.dart';

@riverpod
CountryRemoteDatasource countryRemoteDatasource(Ref ref) {
  return CountryRemoteDatasource();
}

class CountryRemoteDatasource {
  Future<List<Country>> fetchCountry() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://restcountries.com/v3.1/all?fields=name,flags,capital,population,region,subregion,cca3',
        ),
      );

      if (response.statusCode != 200) {
        throw Failure();
      }
      final decoded = json.decode(response.body) as List<dynamic>;

      return decoded.map((item) {
        final map = item as Map<String, dynamic>;
        final nameMap = map['name'] as Map<String, dynamic>?;
        final flagsMap = map['flags'] as Map<String, dynamic>?;
        final capitalList = map['capital'] as List<dynamic>?;

        return Country(
          name: (nameMap?['common'] as String?) ?? '',
          capital: (capitalList?.isNotEmpty ?? false)
              ? (capitalList!.first as String)
              : '',
          region: (map['region'] as String?) ?? '',
          subRegion: (map['subregion'] as String?) ?? '',
          population: (map['population'] as num?)?.toInt() ?? 0,
          flagUrl: (flagsMap?['png'] as String?) ?? '',
        );
      }).toList();
    } catch (e) {
      throw Failure();
    }
  }
}
