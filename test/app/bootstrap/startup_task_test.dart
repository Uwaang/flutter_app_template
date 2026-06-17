import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/bootstrap/startup_task.dart';
import 'package:flutter_app_template/core/logging/app_logger.dart';

class MemoryLogSink implements AppLogSink {
  final entries = <AppLogEntry>[];

  @override
  void write(AppLogEntry entry) {
    entries.add(entry);
  }
}

void main() {
  test('runs startup tasks in declared order and records timing', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final sink = MemoryLogSink();
    final logger = AppLogger(sink);
    final order = <String>[];

    final summary = await runStartupTasks(
      container: container,
      logger: logger,
      tasks: [
        StartupTask(name: 'first', run: (_) => order.add('first')),
        StartupTask(name: 'second', run: (_) async => order.add('second')),
      ],
    );

    expect(order, ['first', 'second']);
    expect(summary.tasks.map((task) => task.name), ['first', 'second']);
    expect(summary.totalElapsed, isA<Duration>());
    expect(
      container.read(startupDiagnosticsProvider).latestSummary,
      same(summary),
    );
  });

  test('logs and propagates startup task failures', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final sink = MemoryLogSink();
    final logger = AppLogger(sink);
    final error = StateError('startup failed');

    await expectLater(
      runStartupTasks(
        container: container,
        logger: logger,
        tasks: [StartupTask(name: 'failing task', run: (_) => throw error)],
      ),
      throwsA(same(error)),
    );

    expect(sink.entries.last.level, LogLevel.error);
    expect(sink.entries.last.message, 'Startup task failed: failing task');
    expect(sink.entries.last.error, same(error));
    expect(container.read(startupDiagnosticsProvider).latestSummary, isNull);
  });
}
