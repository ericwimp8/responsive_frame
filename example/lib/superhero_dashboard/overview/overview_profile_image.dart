import 'dart:async';

import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:with_value/with_value.dart';

class OverviewProfileImage extends StatefulWidget {
  const OverviewProfileImage({
    required this.superHero,
    super.key,
  });
  final Superhero superHero;
  @override
  State<OverviewProfileImage> createState() => _OverviewProfileImageState();
}

class _OverviewProfileImageState extends State<OverviewProfileImage> {
  String url = '';

  void updateThemeFromImage(
    ImageProvider imageProvider,
    AppThemeState state,
    String newUrl,
  ) {
    if (newUrl != url && state.data.useDynamicTheme) {
      url = newUrl;
      unawaited(state.updateThemeFromImage(imageProvider));
    }
  }

  AssetImage? provider;
  String? imagePath;
  @override
  void didChangeDependencies() {
    if (imagePath != widget.superHero.images.sm) {
      imagePath = widget.superHero.images.sm;
      provider = AssetImage(widget.superHero.images.sm);
      updateThemeFromImage(
        provider!,
        WithValueUpdate.of<AppThemeState>(context),
        widget.superHero.images.md,
      );
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProfileImage(theme: theme, provider: provider, widget: widget);
  }
}
