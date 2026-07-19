import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

class FarmsListScreen extends ConsumerWidget {
  final Farmer farmer;

  const FarmsListScreen({super.key, required this.farmer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final farmsAsync = ref.watch(farmsListByFarmerProvider(farmer.id));

    return Scaffold(
      appBar: AppBar(title: Text('${l10n.farms}: ${farmer.name}')),
      body: farmsAsync.when(
        data: (farms) {
          if (farms.isEmpty) {
            return Center(
              child: Text(l10n.noFarms),
            ); // I need to add noFarms to l10n
          }
          return ListView.builder(
            itemCount: farms.length,
            itemBuilder: (context, index) {
              final farm = farms[index];
              return ListTile(
                title: Text(farm.name),
                subtitle: Text('${farm.landArea} ${farm.landAreaUnit}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => context.push(
                    '/farms/edit',
                    extra: {'farmer': farmer, 'farm': farm},
                  ),
                ),
                onTap: () => context.push('/damage-reports', extra: farm),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text(l10n.errorLoadingFarms)), // Add to l10n
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/farms/add', extra: farmer),
        tooltip: l10n.addFarm, // Add to l10n
        child: const Icon(Icons.add),
      ),
    );
  }
}
