import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class HeroSearch extends StatefulWidget {
  const HeroSearch({
    this.onTap,
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onClear,
  });
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  @override
  State<HeroSearch> createState() => _HeroSearchState();
}

class _HeroSearchState extends State<HeroSearch> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  void search(String value) {
    WithValueUpdate.of<SuperheroState>(context).searchAndFilter(search: value);
    widget.onChanged?.call(value);
  }

  SuperheroeDashboardLocation? location;
  @override
  void didChangeDependencies() {
    controller.text = WithValueUpdate.of<SuperheroState>(context).data.search;
    super.didChangeDependencies();
  }

  void onClear() {
    search('');
    widget.onClear?.call();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: SearchInput(
          onClear: onClear,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          onChanged: search,
          controller: controller,
        ),
      ),
    );
  }
}
