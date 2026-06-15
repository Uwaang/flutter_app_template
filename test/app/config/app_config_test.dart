import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/app_environment.dart';

void main() {
  group('AppEnvironment.fromValue', () {
    test('parses known environment names', () {
      expect(AppEnvironment.fromValue('ci'), AppEnvironment.ci);
      expect(AppEnvironment.fromValue('dev'), AppEnvironment.dev);
      expect(AppEnvironment.fromValue('development'), AppEnvironment.dev);
      expect(AppEnvironment.fromValue('stage'), AppEnvironment.stage);
      expect(AppEnvironment.fromValue('staging'), AppEnvironment.stage);
      expect(AppEnvironment.fromValue('prod'), AppEnvironment.prod);
      expect(AppEnvironment.fromValue('production'), AppEnvironment.prod);
    });

    test('rejects unknown environment names', () {
      expect(
        () => AppEnvironment.fromValue('qa'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('AppConfig.validate', () {
    test('allows template placeholders outside production', () {
      const config = AppConfig(
        appName: 'Template App',
        brandName: 'Template Brand',
        applicationId: 'com.example.template.app',
        apiBaseUrl: 'https://api.example.com',
        environment: AppEnvironment.ci,
      );

      expect(config.validate, returnsNormally);
    });

    test('rejects production template placeholders', () {
      const config = AppConfig(
        appName: 'Template App',
        brandName: 'Template Brand',
        applicationId: 'com.example.template.app',
        apiBaseUrl: 'https://api.example.com',
        environment: AppEnvironment.prod,
      );

      expect(config.validate, throwsA(isA<StateError>()));
    });

    test('rejects invalid API URLs', () {
      const config = AppConfig(
        appName: 'Client App',
        brandName: 'Client Brand',
        applicationId: 'com.example.client',
        apiBaseUrl: 'api.client.example',
        environment: AppEnvironment.stage,
      );

      expect(config.validate, throwsA(isA<StateError>()));
    });
  });
}
