import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/diagnostics/provider_diagnostics.dart';
import 'package:flutter_app_template/core/logging/app_logger.dart';

class MemoryLogSink implements AppLogSink {
  final entries = <AppLogEntry>[];

  @override
  void write(AppLogEntry entry) {
    entries.add(entry);
  }
}

void main() {
  test(
    'provider errors are logged through AppLogger even when lifecycle logging is disabled',
    () {
      final sink = MemoryLogSink();
      final diagnostics = ProviderDiagnostics();
      final error = StateError('provider failed');
      final failingProvider = Provider<int>(
        (ref) => throw error,
        name: 'failingProvider',
      );
      final container = ProviderContainer(
        observers: [
          AppProviderObserver(
            logger: AppLogger(sink),
            diagnostics: diagnostics,
          ),
        ],
      );
      addTearDown(container.dispose);

      expect(() => container.read(failingProvider), throwsA(anything));

      expect(diagnostics.failedCount, 1);
      expect(
        diagnostics.recentEvents.single.type,
        ProviderDiagnosticEventType.failed,
      );
      expect(diagnostics.recentEvents.single.providerName, 'failingProvider');
      expect(sink.entries.single.level, LogLevel.error);
      expect(sink.entries.single.message, 'Provider failed: failingProvider');
      expect(sink.entries.single.error, same(error));
    },
  );

  test('provider lifecycle diagnostics are not noisy by default', () {
    final sink = MemoryLogSink();
    final diagnostics = ProviderDiagnostics();
    final provider = Provider<int>((ref) => 1, name: 'quietProvider');
    final container = ProviderContainer(
      observers: [
        AppProviderObserver(logger: AppLogger(sink), diagnostics: diagnostics),
      ],
    );

    expect(container.read(provider), 1);
    container.dispose();

    expect(diagnostics.addedCount, 0);
    expect(diagnostics.disposedCount, 0);
    expect(diagnostics.recentEvents, isEmpty);
    expect(sink.entries, isEmpty);
  });

  test('provider lifecycle diagnostics respect the provider logging flag', () {
    final sink = MemoryLogSink();
    final diagnostics = ProviderDiagnostics()..lifecycleLoggingEnabled = true;
    final provider = Provider<int>((ref) => 1, name: 'lifecycleProvider');
    final container = ProviderContainer(
      observers: [
        AppProviderObserver(logger: AppLogger(sink), diagnostics: diagnostics),
      ],
    );

    expect(container.read(provider), 1);
    container.dispose();

    expect(diagnostics.addedCount, 1);
    expect(diagnostics.disposedCount, 1);
    expect(diagnostics.recentEvents.map((event) => event.providerName), [
      'lifecycleProvider',
      'lifecycleProvider',
    ]);
    expect(
      sink.entries.map((entry) => entry.message),
      containsAll([
        'Provider added: lifecycleProvider (Provider<int>)',
        'Provider disposed: lifecycleProvider (Provider<int>)',
      ]),
    );
  });
}
