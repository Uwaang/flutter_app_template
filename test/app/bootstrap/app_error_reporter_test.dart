import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/bootstrap/app_error_reporter.dart';
import 'package:flutter_app_template/core/logging/app_logger.dart';

class MemoryLogSink implements AppLogSink {
  final entries = <AppLogEntry>[];

  @override
  void write(AppLogEntry entry) {
    entries.add(entry);
  }
}

void main() {
  test('logs Flutter framework errors and preserves presentation', () {
    final sink = MemoryLogSink();
    var presented = false;
    final reporter = AppErrorReporter(
      logger: AppLogger(sink),
      presentFlutterError: (_) => presented = true,
    );
    final error = StateError('flutter failed');

    reporter.reportFlutterError(
      FlutterErrorDetails(exception: error, stack: StackTrace.current),
    );

    expect(presented, isTrue);
    expect(sink.entries.single.level, LogLevel.error);
    expect(sink.entries.single.message, 'Flutter framework error');
    expect(sink.entries.single.error, same(error));
  });

  test('logs platform dispatcher errors as handled', () {
    final sink = MemoryLogSink();
    final reporter = AppErrorReporter(logger: AppLogger(sink));
    final error = StateError('platform failed');

    final handled = reporter.reportPlatformError(error, StackTrace.current);

    expect(handled, isTrue);
    expect(sink.entries.single.level, LogLevel.error);
    expect(sink.entries.single.message, 'Platform dispatcher error');
    expect(sink.entries.single.error, same(error));
  });

  test('logs zone errors', () {
    final sink = MemoryLogSink();
    final reporter = AppErrorReporter(logger: AppLogger(sink));
    final error = StateError('zone failed');

    reporter.reportZoneError(error, StackTrace.current);

    expect(sink.entries.single.level, LogLevel.error);
    expect(sink.entries.single.message, 'Zone error');
    expect(sink.entries.single.error, same(error));
  });
}
