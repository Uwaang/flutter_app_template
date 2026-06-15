import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_app_template/features/home/presentation/home_screen.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_screen.dart';

abstract final class AppRoutePaths {
  static const home = '/';
  static const settings = '/settings';
}

abstract final class AppRouteNames {
  static const home = 'home';
  static const settings = 'settings';
}

typedef AppRedirect =
    FutureOr<String?> Function(BuildContext context, GoRouterState state);

final appRedirectProvider = Provider<AppRedirect?>((ref) => null);

final appRouterProvider = Provider<GoRouter>(
  (ref) => createAppRouter(redirect: ref.watch(appRedirectProvider)),
);

GoRouter createAppRouter({
  AppRedirect? redirect,
  String initialLocation = '/',
}) {
  return GoRouter(
    initialLocation: initialLocation,
    redirect: redirect,
    routes: [
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.settings,
        name: AppRouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => UnknownRouteScreen(uri: state.uri),
  );
}

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({required this.uri, super.key});

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.route_outlined,
                size: 48,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text('Unknown route', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                uri.toString(),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go(AppRoutePaths.home),
                child: const Text('Go home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
