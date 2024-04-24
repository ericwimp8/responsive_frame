import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class SuperheroDataWrapper extends StatelessWidget {
  const SuperheroDataWrapper({
    required this.child,
    // required this.initialValue,
    super.key,
  });
  final WidgetBuilder child;
  // final SuperheroData initialValue;
  @override
  Widget build(BuildContext context) {
    return SuperheroData(
      notifier: SuperheroState(),
      child: Builder(builder: child),
    );
  }
}
