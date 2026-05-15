import 'package:country_app/core/widgets/loader.dart';
import 'package:country_app/features/country/presentation/viewmodels/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryListScreen extends ConsumerWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryState = ref.watch(countryViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Country List")),
      body: countryState.when(
        data: (countries) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (_, index) {
                final country = countries[index];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        country.flagUrl,
                        width: 36,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(country.name),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    subtitle: Text(
                      "Tap to read more about this country...",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          );
        },
        error: (e, _) => Center(child: Text(e.toString())),
        loading: () => Loader(),
      ),
    );
  }
}
