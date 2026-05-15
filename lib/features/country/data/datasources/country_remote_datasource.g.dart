// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_remote_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(countryRemoteDatasource)
final countryRemoteDatasourceProvider = CountryRemoteDatasourceProvider._();

final class CountryRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          CountryRemoteDatasource,
          CountryRemoteDatasource,
          CountryRemoteDatasource
        >
    with $Provider<CountryRemoteDatasource> {
  CountryRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<CountryRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CountryRemoteDatasource create(Ref ref) {
    return countryRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountryRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountryRemoteDatasource>(value),
    );
  }
}

String _$countryRemoteDatasourceHash() =>
    r'784a73a005e5ebdc1c15df0d111c82365d99ab73';
