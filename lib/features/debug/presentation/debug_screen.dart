import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/app/bootstrap/startup_task.dart';
import 'package:flutter_app_template/app/config/app_config.dart';
import 'package:flutter_app_template/app/config/app_metadata.dart';
import 'package:flutter_app_template/app/config/feature_flags.dart';
import 'package:flutter_app_template/core/widgets/info_tile.dart';

class DebugScreen extends ConsumerWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final flags = ref.watch(featureFlagsProvider);
    final metadata = ref.watch(appMetadataProvider);
    final startupSummary = ref.watch(startupDiagnosticsProvider).latestSummary;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
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
                    'Runtime configuration',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  InfoTile(label: 'APP_ENV', value: config.environment.name),
                  InfoTile(label: 'API_BASE_URL', value: config.apiBaseUrl),
                  InfoTile(label: 'Platform', value: metadata.platform),
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
                  Text('Feature flags', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  InfoTile(
                    label: 'ENABLE_DEBUG_MENU',
                    value: flags.enableDebugMenu.toString(),
                  ),
                  InfoTile(
                    label: 'ENABLE_MOCK_API',
                    value: flags.enableMockApi.toString(),
                  ),
                  InfoTile(
                    label: 'ENABLE_NETWORK_LOGGING',
                    value: flags.enableNetworkLogging.toString(),
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
                  Text(
                    'Startup diagnostics',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  if (startupSummary == null)
                    const InfoTile(label: 'Status', value: 'Not captured')
                  else ...[
                    InfoTile(
                      label: 'Tasks',
                      value: startupSummary.tasks.length.toString(),
                    ),
                    InfoTile(
                      label: 'Total elapsed',
                      value: '${startupSummary.totalElapsed.inMilliseconds} ms',
                    ),
                    for (final task in startupSummary.tasks)
                      InfoTile(
                        label: task.name,
                        value: '${task.elapsed.inMilliseconds} ms',
                      ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Diagnostics display action')),
              );
            },
            icon: const Icon(Icons.bug_report_outlined),
            label: const Text('Show diagnostics action'),
          ),
        ],
      ),
    );
  }
}
