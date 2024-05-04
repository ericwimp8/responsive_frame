import 'package:flutter/material.dart';

class TextNoOverflow extends StatelessWidget {
  const TextNoOverflow(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.center,
  });
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      style: style,
    );
  }
}
