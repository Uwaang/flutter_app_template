import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/app_metadata.dart';
import 'package:flutter_app_template/core/widgets/info_tile.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final metadata = ref.watch(appMetadataProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(config.appName, style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  InfoTile(label: 'Brand', value: config.brandName),
                  InfoTile(label: 'Version', value: metadata.version),
                  InfoTile(label: 'Build', value: metadata.buildNumber),
                  InfoTile(label: 'Platform', value: metadata.platform),
                  InfoTile(
                    label: 'Application ID',
                    value: config.applicationId,
                  ),
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
                  Text('Project links', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const Text(
                    'Replace this section with support, privacy, store, or repository links for the real app.',
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
