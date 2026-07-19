import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/farmers/domain/compensation.dart';
import 'package:mobile/features/farmers/presentation/compensation/compensation_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

class CompensationScreen extends ConsumerWidget {
  final String reportId;

  const CompensationScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final compensationAsync = ref.watch(compensationProvider(reportId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.compensation)),
      body: compensationAsync.when(
        data: (compensation) => compensation == null
            ? _NoCompensationView(reportId: reportId)
            : _CompensationDetailView(compensation: compensation),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}

class _NoCompensationView extends ConsumerStatefulWidget {
  final String reportId;
  const _NoCompensationView({required this.reportId});

  @override
  ConsumerState<_NoCompensationView> createState() =>
      __NoCompensationViewState();
}

class __NoCompensationViewState extends ConsumerState<_NoCompensationView> {
  final _remarksController = TextEditingController();

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final actionState = ref.watch(compensationActionProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.calculate_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 24),
          Text(l10n.noCompensation, textAlign: TextAlign.center),
          const SizedBox(height: 32),
          TextField(
            controller: _remarksController,
            decoration: InputDecoration(
              labelText: l10n.remarks,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: actionState.isLoading
                ? null
                : () async {
                    await ref
                        .read(compensationActionProvider.notifier)
                        .calculate(widget.reportId, _remarksController.text);
                    ref.invalidate(compensationProvider(widget.reportId));
                  },
            child: actionState.isLoading
                ? const CircularProgressIndicator()
                : Text(l10n.calculateCompensation),
          ),
        ],
      ),
    );
  }
}

class _CompensationDetailView extends ConsumerWidget {
  final Compensation compensation;
  const _CompensationDetailView({required this.compensation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final auth = ref.watch(authProvider);
    final roles = auth.session?.roles ?? [];

    final canManage =
        roles.contains('SuperAdmin') || roles.contains('Administrator');
    final canSubmit = canManage || roles.contains('AgriculturalEngineer');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DataRow(
            label: l10n.calculatedAmount,
            value: '${compensation.calculatedAmount}',
          ),
          _DataRow(
            label: l10n.approvedAmount,
            value: '${compensation.approvedAmount}',
          ),
          _DataRow(label: l10n.status, value: compensation.status),
          _DataRow(label: l10n.remarks, value: compensation.remarks),
          const SizedBox(height: 40),

          if (compensation.status == 'Calculated' && canSubmit)
            ElevatedButton(
              onPressed: () => _handleAction(
                ref,
                () => ref
                    .read(compensationActionProvider.notifier)
                    .submit(compensation),
              ),
              child: const Text('Submit for Approval'),
            ),

          if (compensation.status == 'Submitted' && canManage) ...[
            ElevatedButton(
              onPressed: () => _handleAction(
                ref,
                () => ref
                    .read(compensationActionProvider.notifier)
                    .approve(
                      compensation,
                      compensation.calculatedAmount,
                      'Approved by admin',
                    ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.approve),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _handleAction(
                ref,
                () => ref
                    .read(compensationActionProvider.notifier)
                    .reject(compensation, 'Rejected by admin'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reject'),
            ),
          ],

          if (compensation.status == 'Approved' && canManage)
            ElevatedButton(
              onPressed: () => _handleAction(
                ref,
                () => ref
                    .read(compensationActionProvider.notifier)
                    .pay(compensation, 'Paid out'),
              ),
              child: Text(l10n.paid),
            ),

          if ((compensation.status == 'Calculated' ||
                  compensation.status == 'Rejected') &&
              canSubmit) ...[
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () => _handleAction(
                ref,
                () => ref
                    .read(compensationActionProvider.notifier)
                    .recalculate(compensation),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Recalculate'),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _handleAction(
    WidgetRef ref,
    Future<void> Function() action,
  ) async {
    await action();
    ref.invalidate(compensationProvider(compensation.damageReportId));
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final String value;
  const _DataRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
