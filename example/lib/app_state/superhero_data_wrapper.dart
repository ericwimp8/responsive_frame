import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class SuperheroDataWrapper extends StatelessWidget {
  const SuperheroDataWrapper({
    required this.child,
    super.key,
  });
  final WidgetBuilder child;

  @override
  Widget build(BuildContext context) {
    return WithUpdate(
      notifier: SuperheroState(),
      child: Builder(builder: child),
    );
  }
}
