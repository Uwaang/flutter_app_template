import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/theme/app_theme.dart';
import 'package:flutter_app_template/core/widgets/app_error_state.dart';
import 'package:flutter_app_template/core/widgets/app_loading_state.dart';
import 'package:flutter_app_template/core/widgets/async_value_view.dart';

void main() {
  testWidgets('AsyncValueView renders data state', (tester) async {
    await tester.pumpWidget(
      _AsyncValueTestApp(
        child: AsyncValueView<int>(
          value: const AsyncValue.data(7),
          data: (value) => Text('Value: $value'),
        ),
      ),
    );

    expect(find.text('Value: 7'), findsOneWidget);
  });

  testWidgets('AsyncValueView renders loading state', (tester) async {
    await tester.pumpWidget(
      _AsyncValueTestApp(
        child: AsyncValueView<int>(
          value: const AsyncValue.loading(),
          loadingMessage: 'Loading item',
          data: (value) => Text('$value'),
        ),
      ),
    );

    expect(find.byType(AppLoadingState), findsOneWidget);
    expect(find.text('Loading item'), findsOneWidget);
  });

  testWidgets(
    'AsyncValueView renders error state without exposing raw values',
    (tester) async {
      var retried = false;

      await tester.pumpWidget(
        _AsyncValueTestApp(
          child: AsyncValueView<int>(
            value: AsyncValue.error(
              StateError('secret-token'),
              StackTrace.empty,
            ),
            errorTitle: 'Unable to load',
            errorMessage: (_) => 'A safe retryable error occurred.',
            onRetry: () => retried = true,
            data: (value) => Text('$value'),
          ),
        ),
      );

      expect(find.byType(AppErrorState), findsOneWidget);
      expect(find.text('Unable to load'), findsOneWidget);
      expect(find.text('A safe retryable error occurred.'), findsOneWidget);
      expect(find.textContaining('secret-token'), findsNothing);

      await tester.tap(find.text('Try again'));
      expect(retried, isTrue);
    },
  );
}

class _AsyncValueTestApp extends StatelessWidget {
  const _AsyncValueTestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.buildTheme(),
      home: Scaffold(body: child),
    );
  }
}
