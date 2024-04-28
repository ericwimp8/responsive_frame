import 'package:flutter/material.dart';

class TextNoOverflow extends StatelessWidget {
  const TextNoOverflow(this.text, {super.key, this.style});
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      style: style,
    );
  }
}
