import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/app/router/app_router.dart';
import 'package:flutter_app_template/app/theme/app_theme.dart';

void main() {
  test('centralizes route paths and names', () {
    expect(AppRoutePaths.home, '/');
    expect(AppRoutePaths.settings, '/settings');
    expect(AppRouteNames.home, 'home');
    expect(AppRouteNames.settings, 'settings');
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
