import 'package:country_app/features/country/data/models/country.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;
  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1F2937),
      letterSpacing: -0.4,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF8F3ED), Color(0xFFECE4D9)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -80,
              child: _GlowBlob(color: Color(0xFFE76F51)),
            ),
            Positioned(
              bottom: -140,
              left: -100,
              child: _GlowBlob(color: Color(0xFF2A9D8F)),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  tween: Tween(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 18 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            color: const Color(0xFF1F2937),
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                          const SizedBox(width: 4),
                          Text('Country', style: titleStyle),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _FlagCard(
                        name: country.name,
                        region: country.region,
                        flagUrl: country.flagUrl,
                      ),
                      const SizedBox(height: 18),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          if (country.region.isNotEmpty)
                            _Tag(text: country.region, icon: Icons.public),
                          if (country.subRegion.isNotEmpty)
                            _Tag(
                              text: country.subRegion,
                              icon: Icons.map_outlined,
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'At a glance',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFF3D4C5C),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      _InfoCard(
                        children: [
                          _DetailRow(
                            icon: Icons.location_city,
                            label: 'Capital',
                            value: _displayOrNA(country.capital),
                          ),
                          _DetailRow(
                            icon: Icons.public,
                            label: 'Region',
                            value: _displayOrNA(country.region),
                          ),
                          _DetailRow(
                            icon: Icons.explore,
                            label: 'Subregion',
                            value: _displayOrNA(country.subRegion),
                          ),
                          _DetailRow(
                            icon: Icons.groups_2,
                            label: 'Population',
                            value: _formatPopulation(country.population),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              label: 'Population',
                              value: _formatPopulation(country.population),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              label: 'Capital',
                              value: _displayOrNA(country.capital),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _displayOrNA(String value) {
    return value.trim().isEmpty ? 'N/A' : value;
  }

  String _formatPopulation(int value) {
    if (value <= 0) return 'N/A';
    final chars = value.toString().split('').reversed.toList();
    final buffer = StringBuffer();
    for (var i = 0; i < chars.length; i++) {
      if (i != 0 && i % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(chars[i]);
    }
    return buffer.toString().split('').reversed.join();
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  const _GlowBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.18),
      ),
    );
  }
}

class _FlagCard extends StatelessWidget {
  final String name;
  final String region;
  final String flagUrl;

  const _FlagCard({
    required this.name,
    required this.region,
    required this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F0F172A),
            blurRadius: 20,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _FlagImage(url: flagUrl),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0x00000000), const Color(0x99000000)],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    region.isEmpty ? 'Region not available' : region,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagImage extends StatelessWidget {
  final String url;
  const _FlagImage({required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _flagPlaceholder();
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            valueColor: const AlwaysStoppedAnimation(Color(0xFFE9C46A)),
            value: loadingProgress.expectedTotalBytes == null
                ? null
                : loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return _flagPlaceholder();
      },
    );
  }

  Widget _flagPlaceholder() {
    return Container(
      color: const Color(0xFFEADFD2),
      child: const Center(
        child: Icon(Icons.flag_outlined, size: 56, color: Color(0xFF9A7F66)),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final IconData icon;
  const _Tag({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1E7DB),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFD3C2B2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6B4E3D)),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFF6B4E3D),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children:
            children
                .expand((widget) => [widget, const SizedBox(height: 14)])
                .toList()
              ..removeLast(),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF2A9D8F)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF111827),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F3EC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0D4C7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF1F2937),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
