import 'package:country_app/core/widgets/loader.dart';
import 'package:country_app/features/country/data/models/country.dart';
import 'package:country_app/features/country/presentation/pages/country_detail_screen.dart';
import 'package:country_app/features/country/presentation/viewmodels/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryListScreen extends ConsumerWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryState = ref.watch(countryViewModelProvider);
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1F2937),
      letterSpacing: -0.4,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F3ED),
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF8F3ED), Color(0xFFECE4D9)],
              ),
            ),
            child: SizedBox.expand(),
          ),
          Positioned(
            top: -140,
            right: -90,
            child: _GlowBlob(color: Color(0xFFE76F51)),
          ),
          Positioned(
            bottom: -160,
            left: -110,
            child: _GlowBlob(color: Color(0xFF2A9D8F)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.public, color: Color(0xFF2A9D8F)),
                      const SizedBox(width: 8),
                      Text('Countries', style: titleStyle),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Discover places, people, and culture at a glance.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _SearchField(
                    onChanged: (value) {
                      ref
                          .read(countryViewModelProvider.notifier)
                          .setQuery(value);
                    },
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: countryState.when(
                      data: (countries) {
                        return TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 650),
                          curve: Curves.easeOutCubic,
                          tween: Tween(begin: 0, end: 1),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 16 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: ListView.separated(
                            itemCount: countries.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 14),
                            itemBuilder: (_, index) {
                              final country = countries[index];
                              return _CountryCard(
                                country: country,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CountryDetailScreen(country: country),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                      error: (e, _) => Center(child: Text(e.toString())),
                      loading: () => const Center(child: Loader()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search countries',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  const _GlowBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.18),
      ),
    );
  }
}

class _CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const _CountryCard({required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 16,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _FlagThumb(url: country.flagUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  country.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF1F2937),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlagThumb extends StatelessWidget {
  final String url;
  const _FlagThumb({required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 90,
        height: 68,
        color: const Color(0xFFEADFD2),
        child: url.isEmpty
            ? const Icon(Icons.flag_outlined, color: Color(0xFF9A7F66))
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.flag_outlined,
                    color: Color(0xFF9A7F66),
                  );
                },
              ),
      ),
    );
  }
}
