import 'dart:async';

import 'package:flutter/material.dart';

typedef BootstrapBuilder = Widget Function();

Future<void> bootstrap(BootstrapBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  await runZonedGuarded(
    () async {
      runApp(builder());
    },
    (error, stackTrace) {
      debugPrint('Unhandled bootstrap error: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
