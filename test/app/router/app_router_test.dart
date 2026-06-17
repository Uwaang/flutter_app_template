import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/app_environment.dart';
import 'package:flutter_app_template/app/config/feature_flags.dart';
import 'package:flutter_app_template/app/router/app_router.dart';
import 'package:flutter_app_template/app/theme/app_theme.dart';

void main() {
  const config = AppConfig(
    appName: 'Client App',
    brandName: 'Client Brand',
    applicationId: 'com.example.client',
    apiBaseUrl: 'https://api.client.example',
    environment: AppEnvironment.ci,
  );
  const productionConfig = AppConfig(
    appName: 'Client App',
    brandName: 'Client Brand',
    applicationId: 'com.example.client',
    apiBaseUrl: 'https://api.client.example',
    environment: AppEnvironment.prod,
  );

  test('centralizes route paths and names', () {
    expect(AppRoutePaths.home, '/');
    expect(AppRoutePaths.settings, '/settings');
    expect(AppRoutePaths.about, '/about');
    expect(AppRoutePaths.debug, '/debug');
    expect(AppRouteNames.home, 'home');
    expect(AppRouteNames.settings, 'settings');
    expect(AppRouteNames.about, 'about');
    expect(AppRouteNames.debug, 'debug');
  });

  testWidgets('renders the initial home route', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));
    await tester.pumpAndSettle();

    expect(
      find.text('Ship the next Flutter app without rebuilding the plumbing.'),
      findsOneWidget,
    );
  });

  testWidgets('navigates to settings from the home action', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Template guide'));
    await tester.pumpAndSettle();

    expect(find.text('Compile-time configuration'), findsOneWidget);
    expect(find.text('API_BASE_URL'), findsOneWidget);
  });

  testWidgets('renders the about route', (tester) async {
    final router = createAppRouter(initialLocation: AppRoutePaths.about);

    await tester.pumpWidget(_TestRouterApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('About'), findsOneWidget);
    expect(find.text('Project links'), findsOneWidget);
  });

  testWidgets('redirects the debug route when the debug flag is disabled', (
    tester,
  ) async {
    final router = createAppRouter(
      initialLocation: AppRoutePaths.debug,
      config: config,
      featureFlags: const FeatureFlags(
        enableDebugMenu: false,
        enableMockApi: false,
        enableNetworkLogging: false,
      ),
    );

    await tester.pumpWidget(_TestRouterApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Compile-time configuration'), findsOneWidget);
    expect(find.text('Debug'), findsNothing);
  });

  testWidgets('renders the debug route when the debug flag is enabled', (
    tester,
  ) async {
    final router = createAppRouter(
      initialLocation: AppRoutePaths.debug,
      config: config,
      featureFlags: const FeatureFlags(
        enableDebugMenu: true,
        enableMockApi: false,
        enableNetworkLogging: false,
      ),
    );

    await tester.pumpWidget(_TestRouterApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Debug'), findsOneWidget);
    expect(find.text('Feature flags'), findsOneWidget);
  });

  testWidgets('redirects the debug route in production even when enabled', (
    tester,
  ) async {
    final router = createAppRouter(
      initialLocation: AppRoutePaths.debug,
      config: productionConfig,
      featureFlags: const FeatureFlags(
        enableDebugMenu: true,
        enableMockApi: false,
        enableNetworkLogging: false,
      ),
    );

    await tester.pumpWidget(_TestRouterApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Compile-time configuration'), findsOneWidget);
    expect(find.text('Debug'), findsNothing);
  });

  testWidgets('renders a clear fallback for unknown routes', (tester) async {
    final router = createAppRouter(initialLocation: '/missing-page');

    await tester.pumpWidget(
      MaterialApp.router(theme: AppTheme.buildTheme(), routerConfig: router),
    );
    await tester.pumpAndSettle();

    expect(find.text('Page not found'), findsOneWidget);
    expect(find.text('Unknown route'), findsOneWidget);
    expect(find.text('/missing-page'), findsOneWidget);
  });
}

class _TestRouterApp extends StatelessWidget {
  const _TestRouterApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        theme: AppTheme.buildTheme(),
        routerConfig: router,
      ),
    );
  }
}
