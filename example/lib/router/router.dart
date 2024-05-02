import 'dart:ui';

import 'package:example/barrel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This matches up with HeroFilter in router.dart
// the names must be equal
enum SuperheroeDashboardLocation {
  all,
  villains,
  superheroes,
  masterMinds,
  battleHardened,
  overview,
}

abstract class RoutePaths {
  static const String superHeroDashBoard = '/super_heroes_dashboard';
  static const String dashboardLocationID = 'dlid';
  static const String superheroIndex = 'shi';
  static const String noIndex = '/-1';
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return '${RoutePaths.superHeroDashBoard}/${SuperheroeDashboardLocation.all.name}${RoutePaths.noIndex}';
      },
    ),
    GoRoute(
      path:
          '${RoutePaths.superHeroDashBoard}/:${RoutePaths.dashboardLocationID}/:${RoutePaths.superheroIndex}',
      builder: (context, state) {
        return SuperheroDashboard(key: state.pageKey);
      },
      routes: [
        GoRoute(
          path: 'myDrawer',
          // path: 'myDrawer/:${RoutePaths.dashboardLocationID}',
          name: 'myDrawer',
          pageBuilder: (context, state) => CustomTransitionPage(
            fullscreenDialog: true,
            opaque: false,
            transitionsBuilder:
                (context, primaryAnimation, secondaryAnimation, child) {
              const begin = Offset(-1, 0);
              const end = Offset.zero;

              return MenuDrawerAnimation(
                begin: begin,
                end: end,
                primaryAnimation: primaryAnimation,
                child: child,
              );
            },
            child: const MenuDrawer(),
          ),
        ),
      ],
    ),
  ],
);

T getRouteLocation<T extends Enum>(List<T> values, GoRouterState state) {
  final id = state.pathParameters[RoutePaths.dashboardLocationID];
  if (id == null) {
    throw ArgumentError('HeroesHomeLocation not found: $id');
  }

  return values.firstWhere(
    (element) => element.name == id,
    orElse: () => throw ArgumentError('HeroesHomeLocation not found: $id'),
  );
}

int getParamIndex(GoRouterState state) {
  final id = state.pathParameters[RoutePaths.superheroIndex]!;
  final index = int.tryParse(id);
  if (index == null) {
    throw Exception(
      'Invalid state.pathParameters: $id',
    );
  }
  return index;
}
