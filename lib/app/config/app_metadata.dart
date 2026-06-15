import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppMetadata {
  const AppMetadata({
    required this.version,
    required this.buildNumber,
    required this.platform,
  });

  factory AppMetadata.current() {
    return AppMetadata(
      version: const String.fromEnvironment(
        'APP_VERSION',
        defaultValue: '1.0.0',
      ),
      buildNumber: const String.fromEnvironment(
        'BUILD_NUMBER',
        defaultValue: '1',
      ),
      platform: kIsWeb ? 'web' : defaultTargetPlatform.name,
    );
  }

  final String version;
  final String buildNumber;
  final String platform;
}

final appMetadataProvider = Provider<AppMetadata>(
  (ref) => AppMetadata.current(),
);
