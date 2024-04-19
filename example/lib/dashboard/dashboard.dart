import 'dart:convert';

import 'package:example/barrel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:responsive_frame/responsive_frame.dart';

List<SuperHero> _parseHeroes(String superHeroes) {
  return (jsonDecode(superHeroes) as List)
      .map((e) => SuperHero.fromJson(e as Map<String, dynamic>))
      .toList();
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final SuperHeroDataModel data;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  bool loading = true;

  Future<void> loadData() async {
    final heroList = await compute(_parseHeroes, jsonEncode(superHeroJson));
    data = SuperHeroDataModel(heroList: heroList, selectedHero: heroList.first);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (loading) {
      child = const Material(child: Center(child: CircularProgressIndicator()));
    } else {
      child = SuperHeroData(
        data: data,
        child: Builder(
          builder: (context) {
            return ResponsiveFrameLayout(
              persistentFrameConfig: const FrameConfig(
                dimensions: DimensionsConfig(
                  bodyTopMaxHeight: double.infinity,
                  bodyTopMinHeight: 0,
                  leftEndMinWidth: 200,
                  leftEndMaxWidth: 300,
                ),
                bodyTop: Header(),
              ),
              mobile: (context) {
                return const FrameConfig();
              },
              tablet: (context) {
                return const FrameConfig(
                  leftEnd: Menu(),
                  rightEnd: Statistics(),
                  dimensions: DimensionsConfig(
                    rightEndFillVertical: false,
                    rightEndMaxWidth: 350,
                    rightEndMinWidth: 250,
                  ),
                );
              },
            );
          },
        ),
      );
    }
    return AppAnimatedSwitcherSlideFade(child: child);
  }
}
