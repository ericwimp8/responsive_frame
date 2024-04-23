import 'package:example/theme/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const MenuHeader(),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
                    child:
                        Text('DASHBOARDS', style: theme.textTheme.titleSmall),
                  ),
                  MenuTile(
                    selected: true,
                    title: const Text('Overview'),
                    leading: const Icon(Symbols.overview_key_rounded),
                    onTap: () {},
                  ),
                  MenuTile(
                    onTap: () {},
                    leading: const Icon(Symbols.send_money_rounded),
                    title: const Text('Heroes'),
                  ),
                  MenuTile(
                    onTap: () {},
                    leading: const Icon(Symbols.ssid_chart_rounded),
                    title: const Text('Villians'),
                  ),
                  MenuTile(
                    onTap: () {},
                    leading: const Icon(Symbols.groups_rounded),
                    title: const Text('Master Minds'),
                  ),
                  MenuTile(
                    onTap: () {},
                    leading: const Icon(Symbols.groups_rounded),
                    title: const Text('Battle Hardened'),
                  ),
                  const MenuSwitchTile(
                    title: Text('Dark Mode'),
                    leading: Icon(Symbols.dark_mode_rounded),
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

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.asset(
              height: 100,
              'assets/images/example_icon.png',
            ),
          ),
          const Text(
            'ERIC',
            style: TextStyle(
              height: 0,
              fontSize: 30,
              fontFamily: 'JosefinSans',
              fontVariations: <FontVariation>[
                FontVariation('wght', 400),
              ],
            ),
          ),
          const Text(
            'Wimp',
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'JosefinSans',
              fontVariations: <FontVariation>[
                FontVariation('wght', 400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    required this.title,
    required this.leading,
    this.onTap,
    this.selected = false,
    super.key,
  });
  final Widget title;
  final Widget leading;
  final bool selected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        shape: !selected
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        titleTextStyle: selected
            ? theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)
            : theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
        selected: selected,
        textColor: theme.colorScheme.onSurface.withOpacity(0.3),
        onTap: onTap,
        leading: leading,
        title: title,
      ),
    );
  }
}

class MenuSwitchTile extends StatelessWidget {
  const MenuSwitchTile({
    required this.title,
    required this.leading,
    this.onTap,
    this.selected = false,
    super.key,
  });
  final Widget title;
  final Widget leading;
  final bool selected;
  final VoidCallback? onTap;

  void updateTheme(bool isDark, AppThemeState state) {
    state.updateThemeMode(
      isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = AppThemeDataData.of(context);
    final isDark = state.isDark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SwitchListTile(
        onChanged: (value) => updateTheme(value, state),
        value: isDark,
        title: title,
      ),
    );
  }
}
