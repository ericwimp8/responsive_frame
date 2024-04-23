import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/barrel.dart';

import 'package:flutter/material.dart';

class SuperHeroOverview extends StatelessWidget {
  const SuperHeroOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedHero = SuperHeroData.of(context).data.selectedHero;

    return _Overview(
      key: ValueKey(selectedHero.id),
      selectedHero: selectedHero,
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.selectedHero, super.key});
  final SuperHero selectedHero;

  Widget _profileImage(SuperHero superHero) {
    if (superHero.id == 0 || superHero.id == -1) {
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 180,
        ),
        child: AspectRatio(
          aspectRatio: 0.6,
          child: Image.asset(
            fit: BoxFit.cover,
            'assets/images/bananaman.png',
          ),
        ),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 180,
      ),
      child: AspectRatio(
        aspectRatio: 0.6,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: superHero.images.md,
          progressIndicatorBuilder: (context, url, downloadProgress) => Align(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _profileImage(selectedHero),
        Text(
          '${selectedHero.name} - ${selectedHero.biography.alignmentFormatted}',
          style: theme.textTheme.headlineSmall,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 16),
                    child: AppHeading(label: 'Appearance'),
                  ),
                  _InfoRow(
                    leading: 'Gender:',
                    trailing: selectedHero.appearance.gender,
                  ),
                  _InfoRow(
                    leading: 'Race:',
                    trailing: selectedHero.appearance.race,
                  ),
                  _InfoRow(
                    leading: 'Height:',
                    trailing:
                        '${selectedHero.appearance.heightImperial}/${selectedHero.appearance.heightMetric} ',
                  ),
                  _InfoRow(
                    leading: 'Weight:',
                    trailing:
                        '${selectedHero.appearance.weightImperial}/${selectedHero.appearance.weightMetric} ',
                  ),
                  _InfoRow(
                    leading: 'Eye Color:',
                    trailing: selectedHero.appearance.eyeColor,
                  ),
                  _InfoRow(
                    leading: 'Hair Color:',
                    trailing: selectedHero.appearance.hairColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8, top: 16),
                    child: AppHeading(label: 'Biography'),
                  ),
                  _InfoRow(
                    leading: 'Full Name:',
                    trailing: selectedHero.biography.fullName,
                  ),
                  _InfoRow(
                    leading: 'Alter Egos:',
                    trailing: selectedHero.biography.alterEgos,
                  ),
                  _InfoRow(
                    leading: 'aliases:',
                    trailing: selectedHero.biography.aliasesFormated,
                  ),
                  _InfoRow(
                    leading: 'Place of Birth:',
                    trailing: selectedHero.biography.placeOfBirth,
                  ),
                  _InfoRow(
                    leading: 'First Appearance:',
                    trailing: selectedHero.biography.firstAppearance,
                  ),
                  _InfoRow(
                    leading: 'Publisher:',
                    trailing: selectedHero.biography.publisher,
                  ),
                  _InfoRow(
                    leading: 'Alignment:',
                    trailing: selectedHero.biography.alignment,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: AppHeading(label: 'Biography'),
                  ),
                  _InfoRow(
                    leading: 'Full Name:',
                    trailing: selectedHero.biography.fullName,
                  ),
                  _InfoRow(
                    leading: 'Alter Egos:',
                    trailing: selectedHero.biography.alterEgos,
                  ),
                  _InfoRow(
                    leading: 'aliases:',
                    trailing: selectedHero.biography.aliasesFormated,
                  ),
                  _InfoRow(
                    leading: 'Place of Birth:',
                    trailing: selectedHero.biography.placeOfBirth,
                  ),
                  _InfoRow(
                    leading: 'First Appearance:',
                    trailing: selectedHero.biography.firstAppearance,
                  ),
                  _InfoRow(
                    leading: 'Publisher:',
                    trailing: selectedHero.biography.publisher,
                  ),
                  _InfoRow(
                    leading: 'Alignment:',
                    trailing: selectedHero.biography.alignment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.leading,
    required this.trailing,
  });

  final String leading;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 140, maxWidth: 140),
            child: Text(
              leading,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Text(
              trailing,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
