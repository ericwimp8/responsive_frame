import 'package:animated_switcher_wrapper/animated_switcher_wrapper.dart';
import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class SuperHeroOverview extends StatefulWidget {
  const SuperHeroOverview({super.key});

  @override
  State<SuperHeroOverview> createState() => _SuperHeroOverviewState();
}

class _SuperHeroOverviewState extends State<SuperHeroOverview> {
  @override
  Widget build(BuildContext context) {
    return SelectedSuperheroWrapper(
      builder: (context, hero) {
        return AnimatedSwitcherSlideFade(
          duration: const Duration(milliseconds: 200),
          slideBegin: const Offset(0, 0.1),
          child: _Overview(
            key: ObjectKey(hero),
            selectedHero: hero,
          ),
        );
      },
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.selectedHero, super.key});
  final Superhero selectedHero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OverviewProfileImage(superhero: selectedHero),
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
