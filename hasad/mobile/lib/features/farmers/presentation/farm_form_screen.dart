import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/farmers/domain/farm.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

class FarmFormScreen extends ConsumerStatefulWidget {
  final Farmer farmer;
  final Farm? farm;

  const FarmFormScreen({super.key, required this.farmer, this.farm});

  @override
  ConsumerState<FarmFormScreen> createState() => _FarmFormScreenState();
}

class _FarmFormScreenState extends ConsumerState<FarmFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _governorateController;
  late TextEditingController _localityController;
  late TextEditingController _areaController;
  late TextEditingController _areaUnitController;
  late TextEditingController _ownershipController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.farm?.name);
    _governorateController = TextEditingController(
      text: widget.farm?.governorateId,
    );
    _localityController = TextEditingController(text: widget.farm?.localityId);
    _areaController = TextEditingController(
      text: widget.farm?.landArea.toString(),
    );
    _areaUnitController = TextEditingController(
      text: widget.farm?.landAreaUnit,
    );
    _ownershipController = TextEditingController(
      text: widget.farm?.ownershipTypeId,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _governorateController.dispose();
    _localityController.dispose();
    _areaController.dispose();
    _areaUnitController.dispose();
    _ownershipController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final farm = Farm(
      id: widget.farm?.id ?? '',
      farmerId: widget.farmer.id,
      name: _nameController.text.trim(),
      governorateId: _governorateController.text.trim(),
      localityId: _localityController.text.trim(),
      landArea: double.tryParse(_areaController.text) ?? 0,
      landAreaUnit: _areaUnitController.text.trim(),
      ownershipTypeId: _ownershipController.text.trim(),
      rowVersion: widget.farm?.rowVersion ?? '',
    );

    if (widget.farm == null) {
      await ref.read(farmFormProvider.notifier).createFarm(farm);
    } else {
      await ref.read(farmFormProvider.notifier).updateFarm(farm);
    }

    if (mounted && ref.read(farmFormProvider).success) {
      ref.invalidate(farmsListByFarmerProvider(widget.farmer.id));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(farmFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.farm == null ? l10n.addFarm : l10n.editFarm),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.errors.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    state.errors.join('\n'),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: l10n.farmName),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _governorateController,
                decoration: InputDecoration(labelText: l10n.governorate),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _localityController,
                decoration: InputDecoration(labelText: l10n.locality),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _areaController,
                      decoration: InputDecoration(labelText: l10n.landArea),
                      keyboardType: TextInputType.number,
                      validator: (v) => (double.tryParse(v ?? '') ?? 0) <= 0
                          ? l10n.requiredField
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _areaUnitController,
                      decoration: InputDecoration(labelText: l10n.unit),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? l10n.requiredField : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ownershipController,
                decoration: InputDecoration(labelText: l10n.ownershipType),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: state.isLoading ? null : _save,
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
