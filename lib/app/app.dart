import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/app_defines.dart';
import 'package:flutter_app_template/app/router/app_router.dart';
import 'package:flutter_app_template/app/theme/app_theme.dart';

class TemplateApp extends ConsumerWidget {
  const TemplateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppDefines.appName,
      debugShowCheckedModeBanner: !config.environment.isProduction,
      theme: AppTheme.buildTheme(),
      routerConfig: router,
    );
  }
}
