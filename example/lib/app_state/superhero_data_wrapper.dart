import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class SuperheroDataWrapper extends StatelessWidget {
  const SuperheroDataWrapper({
    required this.child,
    this.state,
    super.key,
  });
  final WidgetBuilder child;
  final SuperheroState? state;
  @override
  Widget build(BuildContext context) {
    return WithValueUpdate(
      notifier: state ?? SuperheroState(),
      child: Builder(builder: child),
    );
  }
}
