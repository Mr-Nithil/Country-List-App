import 'package:country_app/features/country/data/models/country.dart';
import 'package:country_app/features/country/data/repositories/country_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_view_model.g.dart';

@riverpod
class CountryViewModel extends _$CountryViewModel {
  late CountryRepository _countryRepository;
  List<Country> _allCountries = const [];
  String _query = '';

  @override
  Future<List<Country>> build() async {
    _countryRepository = ref.watch(countryRepositoryProvider);
    final res = await _countryRepository.fetchCountries();
    _allCountries = res.fold((l) => throw Exception(l.message), (r) => r);
    return _applyFilter();
  }

  void setQuery(String value) {
    _query = value;
    final current = state;
    if (current is AsyncData<List<Country>>) {
      state = AsyncValue.data(_applyFilter());
    }
  }

  List<Country> _applyFilter() {
    final normalizedQuery = _query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return _allCountries;
    }
    return _allCountries
        .where(
          (country) => country.name.toLowerCase().contains(normalizedQuery),
        )
        .toList();
  }
}
