import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MenuLayout(
      child: Column(
        children: [
          const MenuHeader(
            imagePath: 'assets/images/example_icon.png',
            subtitle: 'Wimp',
            title: 'Eric',
          ),
          Expanded(
            child: ListView(
              children: [
                const MenuTile(title: Text('Home')),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
                  child: Text('DASHBOARDS', style: theme.textTheme.titleSmall),
                ),
                const MenuTile(title: Text('Superhero')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
