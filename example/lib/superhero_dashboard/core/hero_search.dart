import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class HeroSearch extends StatefulWidget {
  const HeroSearch({super.key});

  @override
  State<HeroSearch> createState() => _HeroSearchState();
}

class _HeroSearchState extends State<HeroSearch> {
  final controller = TextEditingController();

  void search(String value) {
    WithValueUpdate.of<SuperheroState>(context).searchAndFilter(search: value);
  }

  SuperheroeDashboardLocation? location;
  @override
  void didChangeDependencies() {
    controller.text = WithValueUpdate.of<SuperheroState>(context).data.search;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: SearchInput(
          onChanged: search,
          controller: controller,
        ),
      ),
    );
  }
}
