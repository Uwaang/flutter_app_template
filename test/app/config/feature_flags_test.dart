import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/app_environment.dart';
import 'package:flutter_app_template/app/config/feature_flags.dart';

void main() {
  test('default feature flags are disabled', () {
    final flags = FeatureFlags.fromEnvironment();

    expect(flags.enableDebugMenu, isFalse);
    expect(flags.enableMockApi, isFalse);
    expect(flags.enableNetworkLogging, isFalse);
    expect(flags.enableProviderLogging, isFalse);
  });

  test(
    'debug menu, network logging, and provider logging are unavailable in production',
    () {
      const flags = FeatureFlags(
        enableDebugMenu: true,
        enableMockApi: false,
        enableNetworkLogging: true,
        enableProviderLogging: true,
      );
      const config = AppConfig(
        appName: 'Client App',
        brandName: 'Client Brand',
        applicationId: 'com.example.client',
        apiBaseUrl: 'https://api.client.example',
        environment: AppEnvironment.prod,
      );

      expect(flags.isDebugMenuAvailable(config), isFalse);
      expect(flags.isNetworkLoggingAvailable(config), isFalse);
      expect(flags.isProviderLifecycleLoggingAvailable(config), isFalse);
    },
  );

  test('debug menu and provider logging can be enabled outside production', () {
    const flags = FeatureFlags(
      enableDebugMenu: true,
      enableMockApi: false,
      enableNetworkLogging: false,
      enableProviderLogging: true,
    );
    const config = AppConfig(
      appName: 'Client App',
      brandName: 'Client Brand',
      applicationId: 'com.example.client',
      apiBaseUrl: 'https://api.client.example',
      environment: AppEnvironment.stage,
    );

    expect(flags.isDebugMenuAvailable(config), isTrue);
    expect(flags.isProviderLifecycleLoggingAvailable(config), isTrue);
  });
}
