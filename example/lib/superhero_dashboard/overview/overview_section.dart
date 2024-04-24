import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({
    required this.children,
    required this.heading,
    super.key,
  });
  final List<Widget> children;
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 16),
            child: AppHeading(label: heading),
          ),
          ...children,
        ],
      ),
    );
  }
}
