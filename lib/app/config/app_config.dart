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

  void validate() {
    _requireNonBlank(appName, 'APP_NAME');
    _requireNonBlank(brandName, 'BRAND_NAME');
    _requireNonBlank(applicationId, 'APPLICATION_ID');
    _requireNonBlank(apiBaseUrl, 'API_BASE_URL');

    final apiUri = Uri.tryParse(apiBaseUrl);
    if (apiUri == null ||
        !apiUri.hasScheme ||
        !apiUri.hasAuthority ||
        (apiUri.scheme != 'http' && apiUri.scheme != 'https')) {
      throw StateError(
        'API_BASE_URL must be an absolute http(s) URL. Received: $apiBaseUrl',
      );
    }

    if (!RegExp(
      r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$',
    ).hasMatch(applicationId)) {
      throw StateError(
        'APPLICATION_ID must be a reverse-DNS identifier. Received: $applicationId',
      );
    }

    if (environment.isProduction) {
      _rejectProductionPlaceholder(appName, 'Template App', 'APP_NAME');
      _rejectProductionPlaceholder(brandName, 'Template Brand', 'BRAND_NAME');
      _rejectProductionPlaceholder(
        applicationId,
        'com.example.template.app',
        'APPLICATION_ID',
      );
      _rejectProductionPlaceholder(
        apiBaseUrl,
        'https://api.example.com',
        'API_BASE_URL',
      );
    }
  }

  static void _requireNonBlank(String value, String name) {
    if (value.trim().isEmpty) {
      throw StateError('$name must not be blank.');
    }
  }

  static void _rejectProductionPlaceholder(
    String value,
    String placeholder,
    String name,
  ) {
    if (value == placeholder) {
      throw StateError(
        '$name uses the template placeholder "$placeholder" in production.',
      );
    }
  }
}

final appConfigProvider = Provider<AppConfig>((ref) {
  final config = AppConfig(
    appName: AppDefines.appName,
    brandName: AppDefines.brandName,
    applicationId: AppDefines.applicationId,
    apiBaseUrl: AppDefines.apiBaseUrl,
    environment: AppDefines.environment,
  );
  config.validate();
  return config;
});
