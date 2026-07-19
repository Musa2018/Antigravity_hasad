import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

/// Result returned by [FarmerIdentityDialog].
class FarmerIdentitySearchResult {
  final bool exists;
  final Farmer? farmer;
  final String idNumber;

  const FarmerIdentitySearchResult({
    required this.exists,
    this.farmer,
    required this.idNumber,
  });
}

/// Dialog asking for the farmer's ID number before creation/editing.
class FarmerIdentityDialog extends ConsumerStatefulWidget {
  const FarmerIdentityDialog({super.key});

  static Future<FarmerIdentitySearchResult?> show(BuildContext context) {
    return showDialog<FarmerIdentitySearchResult>(
      context: context,
      builder: (context) => const FarmerIdentityDialog(),
    );
  }

  @override
  ConsumerState<FarmerIdentityDialog> createState() =>
      _FarmerIdentityDialogState();
}

class _FarmerIdentityDialogState extends ConsumerState<FarmerIdentityDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final idNumber = _controller.text.trim();

    try {
      final repo = ref.read(farmerRepositoryProvider);
      final farmers = await repo.getFarmers(idNumber: idNumber);

      if (!mounted) return;

      if (farmers.isNotEmpty) {
        final existingFarmer = farmers.firstWhere(
          (f) => f.idNumber == idNumber,
          orElse: () => farmers.first,
        );
        Navigator.of(context).pop(
          FarmerIdentitySearchResult(
            exists: true,
            farmer: existingFarmer,
            idNumber: idNumber,
          ),
        );
      } else {
        Navigator.of(context).pop(
          FarmerIdentitySearchResult(
            exists: false,
            farmer: null,
            idNumber: idNumber,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: const Text('التحقق من رقم هوية المزارع'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAlignment.start,
          children: [
            const Text(
              'يرجى إدخال رقم هوية المزارع للتحقق المسبق في النظام قبل إضافة بيانات جديدة.',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'رقم الهوية',
                hintText: 'أدخل 9 أرقام',
                prefixIcon: const Icon(Icons.badge),
                border: const OutlineInputBorder(),
                errorText: _errorMessage,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال رقم الهوية';
                }
                if (value.trim().length < 8) {
                  return 'رقم الهوية غير مكتمل';
                }
                return null;
              },
              onFieldSubmitted: (_) => _performSearch(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _performSearch,
          icon: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.search),
          label: const Text('بحث ومتابعة'),
        ),
      ],
    );
  }
}
