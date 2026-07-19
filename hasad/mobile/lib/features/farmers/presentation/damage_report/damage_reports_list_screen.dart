import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/farmers/domain/farm.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class DamageReportsListScreen extends ConsumerWidget {
  final Farm farm;

  const DamageReportsListScreen({super.key, required this.farm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final reportsAsync = ref.watch(damageReportsListByFarmProvider(farm.id));

    return Scaffold(
      appBar: AppBar(title: Text('${l10n.damageReports}: ${farm.name}')),
      body: reportsAsync.when(
        data: (reports) {
          if (reports.isEmpty) {
            return const Center(child: Text('No damage reports found.'));
          }
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return ListTile(
                title: Text(DateFormat.yMMMd().format(report.damageDate)),
                subtitle: Text(
                  '${report.statusId} - ${report.items.length} items',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_money),
                      tooltip: l10n.compensation,
                      onPressed: () => context.push(
                        AppRoutes.compensation,
                        extra: report.id,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo_library),
                      onPressed: () =>
                          context.push(AppRoutes.attachments, extra: report.id),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () => context.push(
                  '/damage-reports/edit',
                  extra: {'farm': farm, 'report': report},
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading reports: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/damage-reports/add', extra: farm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
