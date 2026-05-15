import 'package:country_app/core/error/failure.dart';
import 'package:country_app/features/country/data/datasources/country_remote_datasource.dart';
import 'package:country_app/features/country/data/models/country.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'country_repository.g.dart';

@riverpod
CountryRepository countryRepository(Ref ref) {
  final countryRemoteDatasource = ref.watch(countryRemoteDatasourceProvider);
  return CountryRepository(countryRemoteDatasource: countryRemoteDatasource);
}

class CountryRepository {
  final CountryRemoteDatasource _countryRemoteDatasource;

  CountryRepository({required CountryRemoteDatasource countryRemoteDatasource})
    : _countryRemoteDatasource = countryRemoteDatasource;

  Future<Either<Failure, List<Country>>> fetchCountries() async {
    try {
      final countries = await _countryRemoteDatasource.fetchCountry();
      return Right(countries);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(Failure(e.toString()));
    }
  }
}
