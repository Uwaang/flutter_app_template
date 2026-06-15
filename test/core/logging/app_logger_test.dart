import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/core/logging/app_logger.dart';

class MemoryLogSink implements AppLogSink {
  final entries = <AppLogEntry>[];

  @override
  void write(AppLogEntry entry) {
    entries.add(entry);
  }
}

void main() {
  test('AppLogger writes structured log entries to the configured sink', () {
    final sink = MemoryLogSink();
    final logger = AppLogger(sink);
    final error = StateError('boom');

    logger.info('Ready');
    logger.error('Failed', error: error);

    expect(sink.entries, hasLength(2));
    expect(sink.entries.first.level, LogLevel.info);
    expect(sink.entries.first.message, 'Ready');
    expect(sink.entries.last.level, LogLevel.error);
    expect(sink.entries.last.error, error);
  });
}
