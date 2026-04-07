import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_defines.dart';
import 'package:flutter_app_template/features/home/domain/template_manifest.dart';

final templateManifestProvider = Provider<TemplateManifest>(
  (ref) => TemplateManifest.fromJson({
    'appName': AppDefines.appName,
    'brandName': AppDefines.brandName,
    'packageName': AppDefines.applicationId,
    'apiBaseUrl': AppDefines.apiBaseUrl,
    'environment': AppDefines.environmentName,
    'supportedPlatforms': ['android', 'web', 'linux', 'windows'],
    'nextSteps': [
      {
        'title': 'Replace branding',
        'description':
            'Update APP_NAME, BRAND_NAME, launcher icons, splash, and copy.',
      },
      {
        'title': 'Wire services',
        'description':
            'Point API_BASE_URL at your backend and add real feature modules.',
      },
      {
        'title': 'Configure delivery',
        'description':
            'Set up GitHub repository secrets and Codemagic signing groups.',
      },
    ],
  }),
);
