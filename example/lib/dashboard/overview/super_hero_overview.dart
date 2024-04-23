import 'dart:async';
import 'package:example/barrel.dart';
import 'package:example/dashboard/overview/overview_section.dart';
import 'package:flutter/material.dart';

class SuperHeroOverview extends StatelessWidget {
  const SuperHeroOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedHero = SuperHeroData.of(context).data.selectedHero;

    return AppAnimatedSwitcherSlideFade(
      duration: const Duration(milliseconds: 400),
      begin: const Offset(0, 0.03),
      child: _Overview(
        key: ObjectKey(selectedHero),
        selectedHero: selectedHero,
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.selectedHero, super.key});
  final SuperHero selectedHero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileImage(superHero: selectedHero),
        Text(
          '${selectedHero.name} - ${selectedHero.biography.alignmentFormatted}',
          style: theme.textTheme.headlineSmall,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: OverviewSection(
                heading: 'Appearance',
                children: [
                  InfoRow(
                    leading: 'Gender:',
                    trailing: selectedHero.appearance.gender,
                  ),
                  InfoRow(
                    leading: 'Race:',
                    trailing: selectedHero.appearance.race,
                  ),
                  InfoRow(
                    leading: 'Height:',
                    trailing:
                        '${selectedHero.appearance.heightImperial}/${selectedHero.appearance.heightMetric} ',
                  ),
                  InfoRow(
                    leading: 'Weight:',
                    trailing:
                        '${selectedHero.appearance.weightImperial}/${selectedHero.appearance.weightMetric} ',
                  ),
                  InfoRow(
                    leading: 'Eye Color:',
                    trailing: selectedHero.appearance.eyeColor,
                  ),
                  InfoRow(
                    leading: 'Hair Color:',
                    trailing: selectedHero.appearance.hairColor,
                  ),
                ],
              ),
            ),
            OverviewSection(
              heading: 'Biography',
              children: [
                InfoRow(
                  leading: 'Full Name:',
                  trailing: selectedHero.biography.fullName,
                ),
                InfoRow(
                  leading: 'Alter Egos:',
                  trailing: selectedHero.biography.alterEgos,
                ),
                InfoRow(
                  leading: 'aliases:',
                  trailing: selectedHero.biography.aliasesFormated,
                ),
                InfoRow(
                  leading: 'Place of Birth:',
                  trailing: selectedHero.biography.placeOfBirth,
                ),
                InfoRow(
                  leading: 'First Appearance:',
                  trailing: selectedHero.biography.firstAppearance,
                ),
                InfoRow(
                  leading: 'Publisher:',
                  trailing: selectedHero.biography.publisher,
                ),
                InfoRow(
                  leading: 'Alignment:',
                  trailing: selectedHero.biography.alignment,
                ),
              ],
            ),
            OverviewSection(
              heading: 'Work',
              children: [
                InfoRow(
                  leading: 'Occupation:',
                  trailing: selectedHero.work.occupation,
                ),
                InfoRow(
                  leading: 'Base:',
                  trailing: selectedHero.work.base,
                ),
              ],
            ),
            OverviewSection(
              heading: 'Connections',
              children: [
                InfoRow(
                  leading: 'Affiliation:',
                  trailing: selectedHero.connections.groupAffiliation,
                ),
                InfoRow(
                  leading: 'Relatives:',
                  trailing: selectedHero.connections.relatives,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    required this.superHero,
    super.key,
  });
  final SuperHero superHero;
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String url = '';

  void updateThemeFromImage(
    ImageProvider imageProvider,
    AppThemeState state,
    String newUrl,
  ) {
    if (newUrl != url && state.data.useDynamicTheme) {
      url = newUrl;
      unawaited(state.updateThemeFromImage(imageProvider));
    }
  }

  void setDefaultTheme(AppThemeState state, String newUrl) {
    if (newUrl != url) {
      url = newUrl;
      Future(() {
        state.setDefaultTheme();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppThemeDataData.of(context);
    if (widget.superHero.id == -1) {
      const url = 'assets/images/bananaman.png';

      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 180,
        ),
        child: const AspectRatio(
          aspectRatio: 0.6,
          child: Image(image: AssetImage(url)),
        ),
      );
    }

    final provider = AssetImage(widget.superHero.images.sm);
    updateThemeFromImage(
      provider,
      state,
      widget.superHero.images.md,
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 180,
      ),
      child: AspectRatio(
        aspectRatio: 0.6,
        child: Image(
          image: provider,
        ),
      ),
    );
  }
}
