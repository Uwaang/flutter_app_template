import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/feature_flags.dart';
import 'package:flutter_app_template/app/diagnostics/provider_diagnostics.dart';
import 'package:flutter_app_template/core/logging/app_logger.dart';

typedef StartupTaskAction =
    FutureOr<void> Function(ProviderContainer container);

@immutable
class StartupTask {
  const StartupTask({required this.name, required this.run});

  final String name;
  final StartupTaskAction run;
}

@immutable
class StartupTaskResult {
  const StartupTaskResult({required this.name, required this.elapsed});

  final String name;
  final Duration elapsed;
}

@immutable
class StartupSummary {
  const StartupSummary({
    required this.startedAt,
    required this.totalElapsed,
    required this.tasks,
  });

  final DateTime startedAt;
  final Duration totalElapsed;
  final List<StartupTaskResult> tasks;
}

class StartupDiagnostics {
  StartupSummary? latestSummary;
}

final startupDiagnosticsProvider = Provider<StartupDiagnostics>(
  (ref) => StartupDiagnostics(),
);

const defaultStartupTasks = <StartupTask>[
  StartupTask(name: 'Prepare app logger', run: _prepareAppLogger),
  StartupTask(name: 'Validate app configuration', run: _validateAppConfig),
  StartupTask(
    name: 'Configure provider diagnostics',
    run: _configureProviderDiagnostics,
  ),
];

Future<StartupSummary> runStartupTasks({
  required ProviderContainer container,
  required List<StartupTask> tasks,
  required AppLogger logger,
}) async {
  final startedAt = DateTime.now();
  final totalStopwatch = Stopwatch()..start();
  final results = <StartupTaskResult>[];

  for (final task in tasks) {
    final taskStopwatch = Stopwatch()..start();
    logger.debug('Starting startup task: ${task.name}');

    try {
      await task.run(container);
    } catch (error, stackTrace) {
      logger.error(
        'Startup task failed: ${task.name}',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } finally {
      taskStopwatch.stop();
    }

    final result = StartupTaskResult(
      name: task.name,
      elapsed: taskStopwatch.elapsed,
    );
    results.add(result);
    logger.info('Completed startup task: ${task.name}');
  }

  totalStopwatch.stop();
  final summary = StartupSummary(
    startedAt: startedAt,
    totalElapsed: totalStopwatch.elapsed,
    tasks: List.unmodifiable(results),
  );
  container.read(startupDiagnosticsProvider).latestSummary = summary;

  return summary;
}

void _prepareAppLogger(ProviderContainer container) {
  container.read(appLoggerProvider).debug('App logger ready');
}

void _validateAppConfig(ProviderContainer container) {
  container.read(appConfigProvider);
}

void _configureProviderDiagnostics(ProviderContainer container) {
  final config = container.read(appConfigProvider);
  final flags = container.read(featureFlagsProvider);
  container.read(providerDiagnosticsProvider).lifecycleLoggingEnabled = flags
      .isProviderLifecycleLoggingAvailable(config);
}
