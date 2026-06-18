import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/router/app_router.dart';
import 'package:flutter_app_template/app/theme/app_radius.dart';
import 'package:flutter_app_template/app/theme/app_spacing.dart';
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
        padding: AppSpacing.screen,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: AppRadius.hero,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.secondaryContainer,
                ],
              ),
            ),
            padding: AppSpacing.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(config.brandName, style: theme.textTheme.labelLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Ship the next Flutter app without rebuilding the plumbing.',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'This repository is the starter template for Android, Web, Linux, and Windows projects.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: manifest.supportedPlatforms
                      .map((platform) => Chip(label: Text(platform)))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: AppSpacing.card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Template defaults', style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  InfoTile(label: 'App name', value: manifest.appName),
                  InfoTile(label: 'Brand name', value: manifest.brandName),
                  InfoTile(label: 'Package', value: manifest.packageName),
                  InfoTile(label: 'Environment', value: manifest.environment),
                  InfoTile(label: 'API base URL', value: dio.options.baseUrl),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: AppSpacing.card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Template setup checklist',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
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
