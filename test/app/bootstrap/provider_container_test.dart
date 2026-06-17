import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/bootstrap/bootstrap.dart';
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
    'createAppProviderContainer wires provider diagnostics and app logging together',
    () {
      final sink = MemoryLogSink();
      final diagnostics = ProviderDiagnostics();
      final container = createAppProviderContainer(
        logSink: sink,
        providerDiagnostics: diagnostics,
      );
      addTearDown(container.dispose);

      expect(container.read(providerDiagnosticsProvider), same(diagnostics));
      container.read(appLoggerProvider).info('ready');

      expect(sink.entries.single.message, 'ready');
    },
  );
}
