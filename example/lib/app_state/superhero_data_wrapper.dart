import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class SuperheroDataWrapper extends StatelessWidget {
  const SuperheroDataWrapper({
    required this.child,
    super.key,
  });
  final WidgetBuilder child;

  @override
  Widget build(BuildContext context) {
    return WithValueUpdate(
      notifier: SuperheroState(),
      child: Builder(builder: child),
    );
  }
}
