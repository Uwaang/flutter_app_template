import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LogLevel { debug, info, warning, error }

class AppLogEntry {
  const AppLogEntry({
    required this.level,
    required this.message,
    this.error,
    this.stackTrace,
  });

  final LogLevel level;
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
}

abstract interface class AppLogSink {
  void write(AppLogEntry entry);
}

class DebugConsoleLogSink implements AppLogSink {
  const DebugConsoleLogSink();

  @override
  void write(AppLogEntry entry) {
    debugPrint('[${entry.level.name}] ${entry.message}');
    if (entry.error != null) {
      debugPrint('error: ${entry.error}');
    }
    if (entry.stackTrace != null) {
      debugPrintStack(stackTrace: entry.stackTrace);
    }
  }
}

class AppLogger {
  const AppLogger(this._sink);

  final AppLogSink _sink;

  void debug(String message) =>
      _sink.write(AppLogEntry(level: LogLevel.debug, message: message));

  void info(String message) =>
      _sink.write(AppLogEntry(level: LogLevel.info, message: message));

  void warning(String message, {Object? error, StackTrace? stackTrace}) =>
      _sink.write(
        AppLogEntry(
          level: LogLevel.warning,
          message: message,
          error: error,
          stackTrace: stackTrace,
        ),
      );

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _sink.write(
        AppLogEntry(
          level: LogLevel.error,
          message: message,
          error: error,
          stackTrace: stackTrace,
        ),
      );
}

final appLogSinkProvider = Provider<AppLogSink>(
  (ref) => const DebugConsoleLogSink(),
);

final appLoggerProvider = Provider<AppLogger>(
  (ref) => AppLogger(ref.watch(appLogSinkProvider)),
);
