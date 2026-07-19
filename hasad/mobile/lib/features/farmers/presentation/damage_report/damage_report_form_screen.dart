import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/farmers/domain/damage_item.dart';
import 'package:mobile/features/farmers/domain/damage_report.dart';
import 'package:mobile/features/farmers/domain/farm.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class DamageReportFormScreen extends ConsumerStatefulWidget {
  final Farm farm;
  final DamageReport? report;

  const DamageReportFormScreen({super.key, required this.farm, this.report});

  @override
  ConsumerState<DamageReportFormScreen> createState() =>
      _DamageReportFormScreenState();
}

class _DamageReportFormScreenState
    extends ConsumerState<DamageReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _damageDate;
  late TextEditingController _notesController;
  List<DamageItem> _items = [];

  @override
  void initState() {
    super.initState();
    _damageDate = widget.report?.damageDate ?? DateTime.now();
    _notesController = TextEditingController(text: widget.report?.notes);
    _items = widget.report?.items.toList() ?? [];
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final report = DamageReport(
      id: widget.report?.id ?? '',
      farmId: widget.farm.id,
      farmerId: widget.farm.farmerId,
      damageDate: _damageDate,
      documentationDate: widget.report?.documentationDate ?? DateTime.now(),
      governorateId: widget.farm.governorateId,
      localityId: widget.farm.localityId,
      statusId: widget.report?.statusId ?? 'Draft',
      notes: _notesController.text.trim(),
      rowVersion: widget.report?.rowVersion ?? '',
      items: _items,
    );

    if (widget.report == null) {
      await ref
          .read(damageReportFormProvider.notifier)
          .createDamageReport(report);
    } else {
      await ref
          .read(damageReportFormProvider.notifier)
          .updateDamageReport(report);
    }

    if (mounted && ref.read(damageReportFormProvider).success) {
      ref.invalidate(damageReportsListByFarmProvider(widget.farm.id));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(damageReportFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.report == null ? 'Add Damage Report' : 'Edit Damage Report',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: const Text('Damage Date'),
                subtitle: Text(DateFormat.yMMMd().format(_damageDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _damageDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _damageDate = picked);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Damage Items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: _addItem,
                  ),
                ],
              ),
              ..._items.map(
                (item) => ListTile(
                  title: Text('${item.agriculturalSectorId} - ${item.cropId}'),
                  subtitle: Text('${item.damagePercentage}% damage'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => setState(() => _items.remove(item)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: state.isLoading ? null : _save,
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addItem() async {
    // Simplified: Quick add dummy item for now or show a dialog
    final newItem = DamageItem(
      id: const Uuid().v4(),
      damageReportId: widget.report?.id ?? '',
      agriculturalSectorId: 'Plant',
      subSectorId: 'Fruit',
      cropId: 'Olive',
      damageTypeId: 'Fire',
      affectedArea: 1,
      damagePercentage: 50,
      quantity: 10,
      estimatedLoss: 500,
    );
    setState(() => _items.add(newItem));
  }
}
