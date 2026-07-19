import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

class FarmerSearchScreen extends ConsumerStatefulWidget {
  const FarmerSearchScreen({super.key});

  @override
  ConsumerState<FarmerSearchScreen> createState() => _FarmerSearchScreenState();
}

class _FarmerSearchScreenState extends ConsumerState<FarmerSearchScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch() async {
    if (!_formKey.currentState!.validate()) return;
    
    final idNumber = _controller.text.trim();
    await ref.read(farmerSearchProvider.notifier).search(idNumber);

    if (!mounted) return;

    final state = ref.read(farmerSearchProvider);
    if (state.status == FarmerSearchStatus.found && state.farmer != null) {
      context.push(AppRoutes.editFarmer, extra: state.farmer); // Placeholder for details
    } else if (state.status == FarmerSearchStatus.notFound) {
      context.push(AppRoutes.addFarmer, extra: idNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(farmerSearchProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.searchFarmer)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.enterFarmerIdToContinue,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: l10n.nationalId,
                  prefixIcon: const Icon(Icons.search),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty) ? l10n.requiredField : null,
                onFieldSubmitted: (_) => _onSearch(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: state.status == FarmerSearchStatus.searching ? null : _onSearch,
                child: state.status == FarmerSearchStatus.searching
                    ? const CircularProgressIndicator()
                    : Text(l10n.search),
              ),
              if (state.status == FarmerSearchStatus.error)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    state.error ?? l10n.errorLoadingFarmers,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
