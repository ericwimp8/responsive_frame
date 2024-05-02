import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:with_value/with_value.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  void updateTheme(bool isDark, AppThemeState state) {
    state.updateThemeMode(
      isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = WithValueUpdate.of<AppThemeState>(context);
    final isDark = state.isDark;
    final theme = Theme.of(context);
    return MenuTile(
      onTap: () => updateTheme(!isDark, state),
      leadingWidget: const Icon(Symbols.dark_mode_rounded),
      title: Text(
        'Dark Mode',
        style: isDark
            ? theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)
            : theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
      ),
      trailing: Switch(
        value: state.isDark,
        onChanged: (value) => updateTheme(value, state),
      ),
    );
  }
}

// class DarkModeSwitchSmall extends StatelessWidget {
//   const DarkModeSwitchSmall({super.key});

//   void updateTheme(bool isDark, AppThemeState state) {
//     state.updateThemeMode(
//       isDark ? ThemeMode.dark : ThemeMode.light,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = WithValueUpdate.of<AppThemeState>(context);
//     final isDark = state.isDark;

//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 120),
//       child: MenuTile(
//         padding: const EdgeInsets.only(right: 8),
//         onTap: () => updateTheme(!isDark, state),
//         title: const Icon(Symbols.dark_mode_rounded),
//         trailing: Switch(
//           value: state.isDark,
//           onChanged: (value) => updateTheme(value, state),
//         ),
//       ),
//     );
//   }
// }
