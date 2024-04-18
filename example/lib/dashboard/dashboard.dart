import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:responsive_frame/responsive_frame.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveFrameLayout(
      mobile: (context) {
        return FrameConfig(
          bodyTop: const Header(),
          body: [
            FrameBodyListChild(
              child: Scaffold(
                appBar: AppBar(title: const Text('mobile')),
              ),
            ),
          ],
        );
      },
      tablet: (context) {
        return FrameConfig(
          leftEnd: const Menu(),
          body: [
            FrameBodyListChild(
              child: Material(
                child: Scaffold(
                  appBar: AppBar(title: const Text('mobile')),
                  body: const Textbox(),
                ),
              ),
            ),
            // FrameBodyListChild(
            //   child: Textbox(),
            //   // Scaffold(
            //   //   appBar: AppBar(title: const Text('mobile')),
            //   // ),
            // ),
          ],
          bodyTop: const Header(),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              'Overview',
              style: theme.textTheme.headlineSmall,
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Search(),
                    ),
                  ),
                  Flexible(child: ProfileButton()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileButton extends StatefulWidget {
  const ProfileButton({super.key});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 205, minWidth: 50),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        leading: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.1),
          foregroundImage: const AssetImage('/images/bananaman.png'),
        ),
        title: const Text(
          'Banana Man',
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 170, minWidth: 50),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: theme.textTheme.titleMedium,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: theme.colorScheme.primary,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Symbols.search_rounded,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
