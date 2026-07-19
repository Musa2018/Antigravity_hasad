import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/domain/gender.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

class FarmerDetailsScreen extends ConsumerWidget {
  final Farmer farmer;

  const FarmerDetailsScreen({super.key, required this.farmer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    // We watch the farmerProvider to ensure we have the latest data from the local DB
    // and to handle the loading/error states as required.
    final farmerAsync = ref.watch(farmerProvider(farmer.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.farmerDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(AppRoutes.editFarmer, extra: farmer),
          ),
        ],
      ),
      body: farmerAsync.when(
        data: (latestFarmer) => _FarmerDetailsBody(farmer: latestFarmer),
        loading: () => _FarmerDetailsBody(
          farmer: farmer,
        ), // Show initial data while loading
        error: (error, stack) =>
            _FarmerDetailsBody(farmer: farmer), // Fallback to passed data
      ),
    );
  }
}

class _FarmerDetailsBody extends StatelessWidget {
  final Farmer farmer;

  const _FarmerDetailsBody({required this.farmer});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat.yMd(locale);
    final dateTimeFormat = DateFormat.yMd(locale).add_Hm();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SyncStatusBadge(status: farmer.syncStatus),
          const SizedBox(height: 16),

          _Section(
            title: l10n.identitySection,
            children: [
              _InfoRow(
                label: l10n.idType,
                value: farmer.idTypeId == 1
                    ? l10n.nationalId
                    : farmer.idTypeId.toString(),
              ),
              _InfoRow(label: l10n.idNumber, value: farmer.idNumber),
            ],
          ),

          _Section(
            title: l10n.arabicNameSection,
            children: [
              _InfoRow(label: l10n.firstName, value: farmer.firstNameAr),
              _InfoRow(label: l10n.secondName, value: farmer.fatherNameAr),
              _InfoRow(label: l10n.thirdName, value: farmer.grandfatherNameAr),
              _InfoRow(label: l10n.fourthName, value: farmer.familyNameAr),
            ],
          ),

          _Section(
            title: l10n.englishNameSection,
            children: [
              _InfoRow(label: l10n.firstName, value: farmer.firstNameEn),
              _InfoRow(label: l10n.secondName, value: farmer.fatherNameEn),
              _InfoRow(label: l10n.thirdName, value: farmer.grandfatherNameEn),
              _InfoRow(label: l10n.fourthName, value: farmer.familyNameEn),
            ],
          ),

          _Section(
            title: l10n.demographicsSection,
            children: [
              _InfoRow(
                label: l10n.dateOfBirth,
                value: dateFormat.format(farmer.birthDate),
              ),
              _InfoRow(
                label: l10n.gender,
                value: _getGenderLabel(context, farmer.gender),
              ),
              _InfoRow(label: l10n.mobileNumber, value: farmer.phoneNumber),
              _InfoRow(
                label: l10n.familySize,
                value: farmer.familySize.toString(),
              ),
            ],
          ),

          _Section(
            title: l10n.locationSection,
            children: [
              _InfoRow(label: l10n.governorate, value: farmer.governorateId),
              _InfoRow(label: l10n.village, value: farmer.localityId),
              _InfoRow(label: l10n.address, value: farmer.address),
            ],
          ),

          _Section(
            title: l10n.auditSection,
            children: [
              if (farmer.createdAt != null)
                _InfoRow(
                  label: l10n.createdAt,
                  value: dateTimeFormat.format(farmer.createdAt!),
                ),
              if (farmer.updatedAt != null)
                _InfoRow(
                  label: l10n.updatedAt,
                  value: dateTimeFormat.format(farmer.updatedAt!),
                ),
            ],
          ),

          const Divider(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.farms, extra: farmer),
              icon: const Icon(Icons.agriculture),
              label: Text(l10n.farms),
            ),
          ),
        ],
      ),
    );
  }

  String _getGenderLabel(BuildContext context, Gender gender) {
    final l10n = AppLocalizations.of(context)!;
    switch (gender) {
      case Gender.male:
        return l10n.male;
      case Gender.female:
        return l10n.female;
      case Gender.unspecified:
        return l10n.unspecified;
    }
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _SyncStatusBadge extends StatelessWidget {
  final String status;

  const _SyncStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case 'completed':
        color = Colors.green;
        label = l10n.synced;
        icon = Icons.check_circle;
        break;
      case 'pending':
      case 'syncing':
        color = Colors.orange;
        label = l10n.pendingSync;
        icon = Icons.sync;
        break;
      case 'failed':
      case 'conflict':
        color = Colors.red;
        label = l10n.syncError;
        icon = Icons.error;
        break;
      default:
        color = Colors.grey;
        label = status;
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
