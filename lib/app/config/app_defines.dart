import 'package:flutter_app_template/app/config/app_environment.dart';

abstract final class AppDefines {
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Template App',
  );

  static const String brandName = String.fromEnvironment(
    'BRAND_NAME',
    defaultValue: 'Template Brand',
  );

  static const String applicationId = String.fromEnvironment(
    'APPLICATION_ID',
    defaultValue: 'com.example.template.app',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  static const String environmentName = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static AppEnvironment get environment =>
      AppEnvironment.fromValue(environmentName);
}
