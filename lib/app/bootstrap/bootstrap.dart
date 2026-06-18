import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/bootstrap/app_error_reporter.dart';
import 'package:flutter_app_template/app/bootstrap/startup_task.dart';
import 'package:flutter_app_template/app/diagnostics/provider_diagnostics.dart';
import 'package:flutter_app_template/app/lifecycle/app_lifecycle.dart';
import 'package:flutter_app_template/core/logging/app_logger.dart';

typedef BootstrapBuilder = Widget Function();

Future<void> bootstrap(
  BootstrapBuilder builder, {
  List<StartupTask> startupTasks = defaultStartupTasks,
  ProviderContainer? container,
  AppLifecycleDispatcher? lifecycleDispatcher,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final appContainer = container ?? createAppProviderContainer();
  final logger = appContainer.read(appLoggerProvider);
  final errorReporter = AppErrorReporter(logger: logger);

  FlutterError.onError = errorReporter.reportFlutterError;
  PlatformDispatcher.instance.onError = errorReporter.reportPlatformError;

  await runZonedGuarded(() async {
    await runStartupTasks(
      container: appContainer,
      tasks: startupTasks,
      logger: logger,
    );

    final dispatcher =
        lifecycleDispatcher ?? createAppLifecycleDispatcher(appContainer);
    WidgetsBinding.instance.addObserver(dispatcher);

    runApp(
      UncontrolledProviderScope(container: appContainer, child: builder()),
    );
  }, errorReporter.reportZoneError);
}

ProviderContainer createAppProviderContainer({
  AppLogSink logSink = const DebugConsoleLogSink(),
  ProviderDiagnostics? providerDiagnostics,
}) {
  final diagnostics = providerDiagnostics ?? ProviderDiagnostics();
  final logger = AppLogger(logSink);

  return ProviderContainer(
    overrides: [
      appLogSinkProvider.overrideWithValue(logSink),
      providerDiagnosticsProvider.overrideWithValue(diagnostics),
    ],
    observers: [AppProviderObserver(logger: logger, diagnostics: diagnostics)],
  );
}
