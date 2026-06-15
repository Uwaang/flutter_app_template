import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/router/app_router.dart';
import 'package:flutter_app_template/core/network/api_client.dart';
import 'package:flutter_app_template/core/widgets/info_tile.dart';
import 'package:flutter_app_template/features/home/application/template_manifest_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final manifest = ref.watch(templateManifestProvider);
    final dio = ref.watch(dioProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(config.appName),
        actions: [
          TextButton.icon(
            onPressed: () => context.go(AppRoutePaths.settings),
            icon: const Icon(Icons.tune),
            label: const Text('Template guide'),
          ),
          TextButton.icon(
            onPressed: () => context.go(AppRoutePaths.about),
            icon: const Icon(Icons.info_outline),
            label: const Text('About'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.secondaryContainer,
                ],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(config.brandName, style: theme.textTheme.labelLarge),
                const SizedBox(height: 12),
                Text(
                  'Ship the next Flutter app without rebuilding the plumbing.',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'This repository is the starter template for Android, Web, Linux, and Windows projects.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: manifest.supportedPlatforms
                      .map((platform) => Chip(label: Text(platform)))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Template defaults', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  InfoTile(label: 'App name', value: manifest.appName),
                  InfoTile(label: 'Brand name', value: manifest.brandName),
                  InfoTile(label: 'Package', value: manifest.packageName),
                  InfoTile(label: 'Environment', value: manifest.environment),
                  InfoTile(label: 'API base URL', value: dio.options.baseUrl),
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
                  Text(
                    'Template setup checklist',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  for (final item in manifest.nextSteps)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.check_circle_outline),
                      title: Text(item.title),
                      subtitle: Text(item.description),
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
