import 'package:animated_switcher_wrapper/animated_switcher_wrapper.dart';
import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    required this.controller,
    super.key,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.onClear,
  });
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  void _clear() {
    widget.onClear?.call();
  }

  void onChanged(String value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: TextField(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        controller: widget.controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(Symbols.search, color: theme.colorScheme.primary),
          hintText: 'Search',
          hintStyle: theme.textTheme.titleMedium
              ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
          suffixIcon: AnimatedSwitcherScaleFade(
            child: widget.controller.text.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppIconButton(
                      onPressed: _clear,
                      icon: const Icon(
                        Symbols.close_rounded,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
