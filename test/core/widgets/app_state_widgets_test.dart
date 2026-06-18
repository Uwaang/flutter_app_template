import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/theme/app_theme.dart';
import 'package:flutter_app_template/core/widgets/app_empty_state.dart';
import 'package:flutter_app_template/core/widgets/app_error_state.dart';
import 'package:flutter_app_template/core/widgets/app_loading_state.dart';

void main() {
  testWidgets('AppLoadingState renders progress and optional message', (
    tester,
  ) async {
    await tester.pumpWidget(
      const _StateTestApp(child: AppLoadingState(message: 'Loading data')),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading data'), findsOneWidget);
  });

  testWidgets('AppEmptyState renders title, message, icon, and action', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      _StateTestApp(
        child: AppEmptyState(
          title: 'Nothing here',
          message: 'Create an item to get started.',
          action: TextButton(
            onPressed: () => tapped = true,
            child: const Text('Create'),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    expect(find.text('Nothing here'), findsOneWidget);
    expect(find.text('Create an item to get started.'), findsOneWidget);

    await tester.tap(find.text('Create'));
    expect(tapped, isTrue);
  });

  testWidgets('AppErrorState renders retry action when provided', (
    tester,
  ) async {
    var retried = false;

    await tester.pumpWidget(
      _StateTestApp(
        child: AppErrorState(
          title: 'Failed to load',
          message: 'Please try again.',
          onRetry: () => retried = true,
        ),
      ),
    );

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.text('Failed to load'), findsOneWidget);
    expect(find.text('Please try again.'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    expect(retried, isTrue);
  });
}

class _StateTestApp extends StatelessWidget {
  const _StateTestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.buildTheme(),
      home: Scaffold(body: child),
    );
  }
}
