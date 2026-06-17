import 'package:flutter/foundation.dart';

import 'package:flutter_app_template/core/logging/app_logger.dart';

typedef FlutterErrorPresenter = void Function(FlutterErrorDetails details);

class AppErrorReporter {
  AppErrorReporter({
    required AppLogger logger,
    FlutterErrorPresenter? presentFlutterError,
  }) : _logger = logger,
       _presentFlutterError = presentFlutterError ?? FlutterError.presentError;

  final AppLogger _logger;
  final FlutterErrorPresenter _presentFlutterError;

  void reportFlutterError(FlutterErrorDetails details) {
    _logger.error(
      'Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
    _presentFlutterError(details);
  }

  bool reportPlatformError(Object error, StackTrace stackTrace) {
    _logger.error(
      'Platform dispatcher error',
      error: error,
      stackTrace: stackTrace,
    );
    debugPrint('Unhandled platform error: $error');
    debugPrintStack(stackTrace: stackTrace);
    return true;
  }

  void reportZoneError(Object error, StackTrace stackTrace) {
    _logger.error('Zone error', error: error, stackTrace: stackTrace);
    debugPrint('Unhandled zone error: $error');
    debugPrintStack(stackTrace: stackTrace);
  }
}
