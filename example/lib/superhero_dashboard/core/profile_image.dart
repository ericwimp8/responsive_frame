import 'dart:ui';

import 'package:example/barrel.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    required this.theme,
    required this.provider,
    required this.superhero,
    super.key,
  });

  final ThemeData theme;
  final AssetImage? provider;
  final Superhero superhero;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          side: BorderSide(
            width: 3,
            color: theme.colorScheme.primary.withOpacity(0.3),
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
              image: provider!,
            ),
          ),
          child: BackdropFilter(
            blendMode: BlendMode.src,
            filter: ImageFilter.blur(
              sigmaX: 12,
              sigmaY: 12,
            ),
            child: Align(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Material(
                        elevation: 20,
                        shadowColor: Colors.black,
                        clipBehavior: Clip.antiAlias,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 210,
                          ),
                          child: AspectRatio(
                            aspectRatio: 0.8,
                            child: Image(
                              fit: BoxFit.cover,
                              image: provider!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      superhero.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        height: 0,
                        fontSize: 30,
                        fontFamily: 'JosefinSans',
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 400),
                        ],
                      ),
                    ),
                    Text(
                      superhero.biography.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'JosefinSans',
                        fontVariations: <FontVariation>[
                          FontVariation('wght', 400),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
