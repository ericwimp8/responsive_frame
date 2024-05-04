import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:with_value/with_value.dart';

class DynamicThemeSwitch extends StatelessWidget {
  const DynamicThemeSwitch({super.key});

  void updateTheme(AppThemeState state, bool isDynamic) {
    state.updateDynamicTheme(isDynamic);
  }

  @override
  Widget build(BuildContext context) {
    final state = WithValueUpdate.of<AppThemeState>(context);
    final isDynamic = state.data.useDynamicTheme;
    final theme = Theme.of(context);
    return MenuTile(
      onTap: () => updateTheme(state, !isDynamic),
      leadingWidget: const Icon(Symbols.dark_mode_rounded),
      title: Text(
        'Dynamic Theme',
        style: isDynamic
            ? theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)
            : theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
      ),
      trailing: Switch(
        value: isDynamic,
        onChanged: (value) => updateTheme(state, value),
      ),
    );
  }
}

// class DynamicThemeSwitchSmall extends StatelessWidget {
//   const DynamicThemeSwitchSmall({super.key});
//   void updateTheme(AppThemeState state, bool isDynamic) {
//     state.updateDynamicTheme(isDynamic);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = WithValueUpdate.of<AppThemeState>(context);
//     final isDynamic = state.data.useDynamicTheme;

//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxWidth: 120),
//       child: MenuTile(
//         padding: EdgeInsets.zero,
//         onTap: () => updateTheme(state, !isDynamic),
//         title: const Icon(Symbols.palette_rounded),
//         trailing: Switch(
//           value: isDynamic,
//           onChanged: (value) => updateTheme(state, value),
//         ),
//       ),
//     );
//   }
// }
