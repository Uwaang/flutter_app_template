import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/core/logging/app_logger.dart';

enum ProviderDiagnosticEventType { added, updated, disposed, failed }

@immutable
class ProviderDiagnosticEvent {
  const ProviderDiagnosticEvent({
    required this.type,
    required this.providerName,
    required this.providerType,
    required this.occurredAt,
  });

  final ProviderDiagnosticEventType type;
  final String providerName;
  final String providerType;
  final DateTime occurredAt;
}

class ProviderDiagnostics {
  ProviderDiagnostics({this.maxRecentEvents = 8});

  final int maxRecentEvents;
  bool lifecycleLoggingEnabled = false;
  int addedCount = 0;
  int updatedCount = 0;
  int disposedCount = 0;
  int failedCount = 0;
  final List<ProviderDiagnosticEvent> _recentEvents = [];

  List<ProviderDiagnosticEvent> get recentEvents =>
      List.unmodifiable(_recentEvents);

  void record(ProviderDiagnosticEvent event) {
    switch (event.type) {
      case ProviderDiagnosticEventType.added:
        addedCount += 1;
      case ProviderDiagnosticEventType.updated:
        updatedCount += 1;
      case ProviderDiagnosticEventType.disposed:
        disposedCount += 1;
      case ProviderDiagnosticEventType.failed:
        failedCount += 1;
    }

    _recentEvents.add(event);
    if (_recentEvents.length > maxRecentEvents) {
      _recentEvents.removeAt(0);
    }
  }
}

final providerDiagnosticsProvider = Provider<ProviderDiagnostics>(
  (ref) => ProviderDiagnostics(),
);

final class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver({
    required AppLogger logger,
    required ProviderDiagnostics diagnostics,
  }) : _logger = logger,
       _diagnostics = diagnostics;

  final AppLogger _logger;
  final ProviderDiagnostics _diagnostics;

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    _recordLifecycleEvent(context, ProviderDiagnosticEventType.added);
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    _recordLifecycleEvent(context, ProviderDiagnosticEventType.updated);
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    _recordLifecycleEvent(context, ProviderDiagnosticEventType.disposed);
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    final event = _eventFor(context, ProviderDiagnosticEventType.failed);
    _diagnostics.record(event);
    _logger.error(
      'Provider failed: ${event.providerName}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _recordLifecycleEvent(
    ProviderObserverContext context,
    ProviderDiagnosticEventType type,
  ) {
    if (!_diagnostics.lifecycleLoggingEnabled) {
      return;
    }

    final event = _eventFor(context, type);
    _diagnostics.record(event);
    _logger.debug(
      'Provider ${type.name}: ${event.providerName} (${event.providerType})',
    );
  }

  ProviderDiagnosticEvent _eventFor(
    ProviderObserverContext context,
    ProviderDiagnosticEventType type,
  ) {
    return ProviderDiagnosticEvent(
      type: type,
      providerName: _safeProviderName(context),
      providerType: context.provider.runtimeType.toString(),
      occurredAt: DateTime.now(),
    );
  }

  String _safeProviderName(ProviderObserverContext context) {
    return context.provider.name ?? context.provider.runtimeType.toString();
  }
}
