import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: theme.colorScheme.primary,
      child: IconButton(
        color: theme.colorScheme.onPrimary,
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
