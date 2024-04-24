import 'package:example/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void updateFilter(HeroFilter? value) {
    if (value != null) {
      SuperheroData.of(context).updateHeroFilter(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Selector<SuperheroData, HeroFilter>(
      selector: (context, superHeroData) {
        return superHeroData.notifier!.data.heroFilter;
      },
      builder: (context, filter, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoSlidingSegmentedControl<HeroFilter>(
                backgroundColor: theme.colorScheme.surfaceTint,
                thumbColor: theme.colorScheme.primary,
                groupValue: filter,
                onValueChanged: updateFilter,
                children: <HeroFilter, Widget>{
                  HeroFilter.all: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'All',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  HeroFilter.superHeroes: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Super Heroes',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  HeroFilter.villans: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Villans',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  HeroFilter.battleHardened: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Battle Hardened',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  HeroFilter.masterMinds: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Master Minds',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

enum HeroFilter {
  villans,
  superHeroes,
  battleHardened,
  masterMinds,
  all,
}

// class ProfileButton extends StatefulWidget {
//   const ProfileButton({super.key});

//   @override
//   State<ProfileButton> createState() => _ProfileButtonState();
// }

// class _ProfileButtonState extends State<ProfileButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 205, minWidth: 50),
//       child: ExpansionTile(
//         tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
//         leading: CircleAvatar(
//           backgroundColor: Colors.black.withOpacity(0.1),
//           foregroundImage: const AssetImage('assets/images/bananaman.png'),
//         ),
//         title: const Text(
//           'Banana Man',
//           maxLines: 1,
//           overflow: TextOverflow.fade,
//         ),
//       ),
//     );
//   }
// }
