import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/lifecycle/app_lifecycle.dart';
import 'package:flutter_app_template/core/logging/app_logger.dart';

class RecordingLifecycleHook implements AppLifecycleHook {
  final states = <AppLifecycleState>[];

  @override
  void didChangeLifecycleState(AppLifecycleState state) {
    states.add(state);
  }
}

class MemoryLogSink implements AppLogSink {
  final entries = <AppLogEntry>[];

  @override
  void write(AppLogEntry entry) {
    entries.add(entry);
  }
}

void main() {
  test('dispatches lifecycle state changes to hooks', () {
    final hook = RecordingLifecycleHook();
    final dispatcher = AppLifecycleDispatcher(hooks: [hook]);

    dispatcher.didChangeAppLifecycleState(AppLifecycleState.resumed);
    dispatcher.didChangeAppLifecycleState(AppLifecycleState.inactive);
    dispatcher.didChangeAppLifecycleState(AppLifecycleState.paused);
    dispatcher.didChangeAppLifecycleState(AppLifecycleState.detached);
    dispatcher.didChangeAppLifecycleState(AppLifecycleState.hidden);

    expect(hook.states, [
      AppLifecycleState.resumed,
      AppLifecycleState.inactive,
      AppLifecycleState.paused,
      AppLifecycleState.detached,
      AppLifecycleState.hidden,
    ]);
  });

  test('logging lifecycle hook writes lifecycle events', () {
    final sink = MemoryLogSink();
    final hook = LoggingAppLifecycleHook(AppLogger(sink));

    hook.didChangeLifecycleState(AppLifecycleState.paused);

    expect(sink.entries.single.level, LogLevel.info);
    expect(sink.entries.single.message, 'App lifecycle changed: paused');
  });
}
