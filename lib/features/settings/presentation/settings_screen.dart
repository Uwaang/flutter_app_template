import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/feature_flags.dart';
import 'package:flutter_app_template/app/router/app_router.dart';
import 'package:flutter_app_template/core/widgets/info_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final flags = ref.watch(featureFlagsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Template guide')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Compile-time configuration',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Override these values with --dart-define in local builds, CI, or Codemagic workflows.',
                  ),
                  const SizedBox(height: 12),
                  InfoTile(label: 'APP_ENV', value: config.environment.name),
                  InfoTile(label: 'APP_NAME', value: config.appName),
                  InfoTile(label: 'BRAND_NAME', value: config.brandName),
                  InfoTile(
                    label: 'APPLICATION_ID',
                    value: config.applicationId,
                  ),
                  InfoTile(label: 'API_BASE_URL', value: config.apiBaseUrl),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preferences', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  InfoTile(label: 'Theme', value: 'System default'),
                  InfoTile(label: 'Cache', value: 'App-managed'),
                  const SizedBox(height: 12),
                  const Text(
                    'Connect these placeholders to project-specific preferences when the app needs them.',
                  ),
                ],
              ),
            ),
          ),
          if (flags.isDebugMenuAvailable(config)) ...[
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.go(AppRoutePaths.debug),
              icon: const Icon(Icons.bug_report_outlined),
              label: const Text('Open debug menu'),
            ),
          ],
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'When to extract shared code',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Keep each app repository independent until common edits start repeating across multiple apps. At that point, extract design system or service code into a shared package repository.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
