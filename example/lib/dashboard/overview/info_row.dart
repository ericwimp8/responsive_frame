import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    required this.leading,
    required this.trailing,
    super.key,
  });

  final String leading;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 140, maxWidth: 140),
            child: Text(
              leading,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Text(
              trailing,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
