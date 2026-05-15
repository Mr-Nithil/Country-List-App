import 'package:country_app/features/country/data/models/country.dart';
import 'package:country_app/features/country/data/repositories/country_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_view_model.g.dart';

@riverpod
class CountryViewModel extends _$CountryViewModel {
  late CountryRepository _countryRepository;

  @override
  Future<List<Country>> build() async {
    _countryRepository = ref.watch(countryRepositoryProvider);
    final res = await _countryRepository.fetchCountries();
    return res.fold((l) => throw Exception(l.message), (r) => r);
  }
}
