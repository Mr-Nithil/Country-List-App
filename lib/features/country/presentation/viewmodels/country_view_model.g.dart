// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CountryViewModel)
final countryViewModelProvider = CountryViewModelProvider._();

final class CountryViewModelProvider
    extends $AsyncNotifierProvider<CountryViewModel, List<Country>> {
  CountryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryViewModelHash();

  @$internal
  @override
  CountryViewModel create() => CountryViewModel();
}

String _$countryViewModelHash() => r'c6463afa1a014eca0d13c1338352ec75f48732f5';

abstract class _$CountryViewModel extends $AsyncNotifier<List<Country>> {
  FutureOr<List<Country>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Country>>, List<Country>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Country>>, List<Country>>,
              AsyncValue<List<Country>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
