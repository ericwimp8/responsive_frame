import 'package:example/barrel.dart';
import 'package:go_router/go_router.dart';

enum HeroesHomeLocation {
  all('all'),
  villans('villans'),
  superheroes('superheroes'),
  masterMinds('masterMinds'),
  battleHardened('battleHardened');

  const HeroesHomeLocation(this.path);
  final String path;
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) =>
          '/heroes_home/${HeroesHomeLocation.all.path}',
    ),
    GoRoute(
      path: '/heroes_home/:fid',
      builder: (context, state) {
        final fid = state.pathParameters['fid']!;

        final location = HeroesHomeLocation.values.firstWhere(
          (element) => element.path == fid,
          orElse: () =>
              throw ArgumentError('HeroesHomeLocation not found: $fid'),
        );

        return HeroesHome(key: state.pageKey, location: location);
      },
    ),
  ],
);
