import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
    this.onChanged,
    this.clear,
    this.controller,
  });
  final ValueChanged<String>? onChanged;
  final VoidCallback? clear;
  final TextEditingController? controller;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  void _clear() {
    widget.clear?.call();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: theme.textTheme.titleMedium
            ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
        suffixIcon: AppAnimatedSwitcherScale(
          child: controller.text.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: theme.colorScheme.primary,
                    child: IconButton(
                      color: theme.colorScheme.onPrimary,
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
