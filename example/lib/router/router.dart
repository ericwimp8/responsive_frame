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
          '/heroes_home/${HeroesHomeLocation.all.name}',
    ),
    GoRoute(
      path: '/heroes_home/:fid',
      builder: (context, state) {
        final location = getRouteLocation<HeroesHomeLocation>(
          HeroesHomeLocation.values,
          state,
        );

        return HeroesHome(key: state.pageKey, location: location);
      },
    ),
  ],
);

T getRouteLocation<T extends Enum>(List<T> values, GoRouterState state) {
  final fid = state.pathParameters['fid']!;
  return values.firstWhere(
    (element) => element.name == fid,
    orElse: () => throw ArgumentError('HeroesHomeLocation not found: $fid'),
  );
}
