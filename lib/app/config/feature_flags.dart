import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_config.dart';

class FeatureFlags {
  const FeatureFlags({
    required this.enableDebugMenu,
    required this.enableMockApi,
    required this.enableNetworkLogging,
    required this.enableProviderLogging,
  });

  factory FeatureFlags.fromEnvironment() {
    return const FeatureFlags(
      enableDebugMenu: bool.fromEnvironment('ENABLE_DEBUG_MENU'),
      enableMockApi: bool.fromEnvironment('ENABLE_MOCK_API'),
      enableNetworkLogging: bool.fromEnvironment('ENABLE_NETWORK_LOGGING'),
      enableProviderLogging: bool.fromEnvironment('ENABLE_PROVIDER_LOGGING'),
    );
  }

  final bool enableDebugMenu;
  final bool enableMockApi;
  final bool enableNetworkLogging;
  final bool enableProviderLogging;

  bool isDebugMenuAvailable(AppConfig config) {
    return enableDebugMenu && !config.environment.isProduction;
  }

  bool isNetworkLoggingAvailable(AppConfig config) {
    return enableNetworkLogging && !config.environment.isProduction;
  }

  bool isProviderLifecycleLoggingAvailable(AppConfig config) {
    return enableProviderLogging && !config.environment.isProduction;
  }
}

final featureFlagsProvider = Provider<FeatureFlags>(
  (ref) => FeatureFlags.fromEnvironment(),
);
