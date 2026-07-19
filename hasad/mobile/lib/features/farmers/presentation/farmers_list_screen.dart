import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/domain/gender.dart';
import 'package:mobile/features/farmers/presentation/farmer_identity_dialog.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

class FarmersListScreen extends ConsumerWidget {
  const FarmersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final farmersAsync = ref.watch(farmersListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.farmers)),
      body: farmersAsync.when(
        data: (farmers) {
          if (farmers.isEmpty) {
            return Center(child: Text(l10n.noFarmers));
          }
          return ListView.builder(
            itemCount: farmers.length,
            itemBuilder: (context, index) {
              final farmer = farmers[index];
              return ListTile(
                title: Text(farmer.name),
                subtitle: Text(farmer.nationalId),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () =>
                      context.push(AppRoutes.editFarmer, extra: farmer),
                ),
                onTap: () =>
                    context.push(AppRoutes.farmerDetails, extra: farmer),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.errorLoadingFarmers),
              TextButton(
                onPressed: () => ref.refresh(farmersListProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await FarmerIdentityDialog.show(context);
          if (result == null || !context.mounted) return;

          if (result.exists && result.farmer != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'تم العثور على بيانات المزارع في النظام - الانتقال لصفحة التعديل',
                ),
                backgroundColor: Colors.blue,
              ),
            );
            context.push(AppRoutes.editFarmer, extra: result.farmer);
          } else {
            final newFarmerWithId = Farmer(
              id: '',
              idTypeId: 1,
              idNumber: result.idNumber,
              firstNameAr: '',
              fatherNameAr: '',
              grandfatherNameAr: '',
              familyNameAr: '',
              firstNameEn: '',
              fatherNameEn: '',
              grandfatherNameEn: '',
              familyNameEn: '',
              birthDate: DateTime.now(),
              gender: Gender.unspecified,
              phoneNumber: '',
              familySize: 1,
              governorateId: '',
              localityId: '',
              address: '',
            );
            context.push(AppRoutes.createFarmer, extra: newFarmerWithId);
          }
        },
        label: const Text('إضافة جديد'),
        icon: const Icon(Icons.person_add),
      ),
    );
  }
}
