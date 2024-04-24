import 'package:example/barrel.dart';
import 'package:go_router/go_router.dart';

enum SuperheroeDashboardLocation {
  all,
  villains,
  superheroes,
  masterMinds,
  battleHardened,
}

abstract class RoutePaths {
  static const String superHeroDashBoard = '/super_heroes_dashboard/';
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return '${RoutePaths.superHeroDashBoard}${SuperheroeDashboardLocation.all.name}';
      },
    ),
    GoRoute(
      path: '${RoutePaths.superHeroDashBoard}:fid',
      builder: (context, state) {
        return SuperheroDashboard(key: state.pageKey);
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
