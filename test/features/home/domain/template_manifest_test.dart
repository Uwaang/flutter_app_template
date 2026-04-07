import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_template/features/home/domain/template_manifest.dart';

void main() {
  test('parses template manifest json', () {
    final manifest = TemplateManifest.fromJson({
      'appName': 'Client App',
      'brandName': 'Client Brand',
      'packageName': 'com.example.client',
      'apiBaseUrl': 'https://api.client.example',
      'environment': 'prod',
      'supportedPlatforms': ['android', 'web'],
      'nextSteps': [
        {'title': 'Replace branding', 'description': 'Update icons and copy.'},
      ],
    });

    expect(manifest.appName, 'Client App');
    expect(manifest.supportedPlatforms, ['android', 'web']);
    expect(manifest.nextSteps.single.title, 'Replace branding');
  });
}
