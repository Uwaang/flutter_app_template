import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/core/logging/app_logger.dart';

abstract interface class AppLifecycleHook {
  void didChangeLifecycleState(AppLifecycleState state);
}

class AppLifecycleDispatcher extends WidgetsBindingObserver {
  AppLifecycleDispatcher({required List<AppLifecycleHook> hooks})
    : _hooks = List.unmodifiable(hooks);

  final List<AppLifecycleHook> _hooks;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    for (final hook in _hooks) {
      hook.didChangeLifecycleState(state);
    }
  }
}

class LoggingAppLifecycleHook implements AppLifecycleHook {
  const LoggingAppLifecycleHook(this._logger);

  final AppLogger _logger;

  @override
  void didChangeLifecycleState(AppLifecycleState state) {
    _logger.info('App lifecycle changed: ${state.name}');
  }
}

final appLifecycleHooksProvider = Provider<List<AppLifecycleHook>>(
  (ref) => [LoggingAppLifecycleHook(ref.watch(appLoggerProvider))],
);

AppLifecycleDispatcher createAppLifecycleDispatcher(
  ProviderContainer container,
) {
  return AppLifecycleDispatcher(
    hooks: container.read(appLifecycleHooksProvider),
  );
}
