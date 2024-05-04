//Needs FocusScope wrapping parent
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardListNavigation extends StatelessWidget {
  const KeyboardListNavigation({
    required this.child,
    required this.enterPressed,
    required this.upPressed,
    required this.downPressed,
    required this.escapePressed,
    super.key,
  });
  final Widget child;
  final VoidCallback enterPressed;
  final VoidCallback upPressed;
  final VoidCallback downPressed;
  final VoidCallback escapePressed;

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): upPressed,
        const SingleActivator(LogicalKeyboardKey.arrowDown): downPressed,
        const SingleActivator(LogicalKeyboardKey.enter): enterPressed,
        const SingleActivator(LogicalKeyboardKey.escape): escapePressed,
      },
      child: child,
    );
  }
}
