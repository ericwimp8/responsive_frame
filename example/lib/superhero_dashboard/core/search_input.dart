import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    super.key,
    this.onChanged,
    this.controller,
  });
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  void _clear() {
    widget.onChanged?.call('');
    controller.clear();
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
        controller: controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(Symbols.search, color: theme.colorScheme.primary),
          hintText: 'Search',
          hintStyle: theme.textTheme.titleMedium
              ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
          suffixIcon: AppAnimatedSwitcherScale(
            child: controller.text.isEmpty
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
