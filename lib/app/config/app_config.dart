import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_defines.dart';
import 'package:flutter_app_template/app/config/app_environment.dart';

@immutable
class AppConfig {
  const AppConfig({
    required this.appName,
    required this.brandName,
    required this.applicationId,
    required this.apiBaseUrl,
    required this.environment,
  });

  final String appName;
  final String brandName;
  final String applicationId;
  final String apiBaseUrl;
  final AppEnvironment environment;
}

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig(
    appName: AppDefines.appName,
    brandName: AppDefines.brandName,
    applicationId: AppDefines.applicationId,
    apiBaseUrl: AppDefines.apiBaseUrl,
    environment: AppDefines.environment,
  ),
);
