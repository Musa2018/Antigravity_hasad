import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/connectivity_provider.dart';
import 'package:mobile/core/presentation/widgets/searchable_lookup_field.dart';
import 'package:mobile/features/admin/domain/role.dart';
import 'package:mobile/features/admin/domain/user.dart';
import 'package:mobile/features/admin/presentation/users_providers.dart';
import 'package:mobile/features/location/domain/directorate.dart';
import 'package:mobile/features/location/domain/governorate.dart';
import 'package:mobile/l10n/app_localizations.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  final User? user;

  const UserFormScreen({super.key, this.user});

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  String? _selectedRoleId;
  String? _selectedGovernorateId;
  String? _selectedDirectorateId;
  bool _isActive = true;

  bool get _isEdit => widget.user != null;

  @override
  void initState() {
    super.initState();
    final u = widget.user;
    _fullNameController = TextEditingController(text: u?.fullName);
    _userNameController = TextEditingController(text: u?.userName);
    _emailController = TextEditingController(text: u?.email);
    _phoneController = TextEditingController(text: u?.phoneNumber);
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _isActive = u?.isActive ?? true;
    _selectedGovernorateId = u?.governorateId;
    _selectedDirectorateId = u?.directorateId;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _retryLookups() async {
    if (await ref.checkIsOffline()) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No internet connection.')));
      return;
    }
    ref.invalidate(rolesProvider);
    ref.invalidate(governoratesProvider);
    if (_selectedGovernorateId != null) {
      ref.invalidate(directoratesProvider(_selectedGovernorateId));
    }
  }

  Future<void> _submit() async {
    if (await ref.checkIsOffline()) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No internet connection.')));
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    final roles = ref.read(rolesProvider).value ?? [];
    final selectedRole = roles.firstWhere((r) => r.id == _selectedRoleId);

    if (_isEdit) {
      await ref
          .read(userManagementProvider.notifier)
          .updateUser(
            id: widget.user!.id,
            fullName: _fullNameController.text.trim(),
            userName: _userNameController.text.trim(),
            email: _emailController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            role: selectedRole.name,
            governorateId: _selectedGovernorateId,
            directorateId: _selectedDirectorateId,
            isActive: _isActive,
          );
    } else {
      await ref
          .read(userManagementProvider.notifier)
          .createUser(
            fullName: _fullNameController.text.trim(),
            userName: _userNameController.text.trim(),
            email: _emailController.text.trim(),
            phoneNumber: _phoneController.text.trim(),
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            role: selectedRole.name,
            governorateId: _selectedGovernorateId,
            directorateId: _selectedDirectorateId,
            isActive: _isActive,
          );
    }

    if (mounted && ref.read(userManagementProvider).success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEdit
                ? 'User updated successfully'
                : AppLocalizations.of(context)!.userCreatedSuccessfully,
          ),
        ),
      );
      ref.invalidate(usersListProvider);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(userManagementProvider);
    final rolesAsync = ref.watch(rolesProvider);
    final governoratesAsync = ref.watch(governoratesProvider);
    final directoratesAsync = _selectedGovernorateId != null
        ? ref.watch(directoratesProvider(_selectedGovernorateId))
        : const AsyncValue<List<Directorate>>.data([]);

    final roles = rolesAsync.value ?? [];

    if (_selectedRoleId == null && widget.user != null && roles.isNotEmpty) {
      try {
        _selectedRoleId = roles
            .firstWhere((r) => r.name == widget.user!.role)
            .id;
      } catch (_) {}
    }

    final selectedRole = _selectedRoleId != null
        ? roles.where((r) => r.id == _selectedRoleId).firstOrNull
        : null;
    final scopeType = selectedRole?.scopeType ?? 'Global';

    final bool lookupLoading =
        rolesAsync.isLoading ||
        governoratesAsync.isLoading ||
        directoratesAsync.isLoading;

    final bool lookupError =
        rolesAsync.hasError ||
        governoratesAsync.hasError ||
        directoratesAsync.hasError;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit User' : l10n.addUser),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _retryLookups,
            tooltip: 'Refresh Lookup Data',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (lookupLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: LinearProgressIndicator(),
                ),
              if (lookupError)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    border: Border.all(color: Colors.orange.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Warning: Failed to load required data.',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _retryLookups,
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Retry All'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (state.errors.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    state.errors.join('\n'),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: l10n.fullName),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _userNameController,
                enabled: !_isEdit,
                decoration: InputDecoration(labelText: l10n.username),
                validator: (v) =>
                    (v == null || v.isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: l10n.email),
                validator: (v) {
                  if (v == null || v.isEmpty) return l10n.emailRequired;
                  if (!v.contains('@')) return l10n.emailInvalid;
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: l10n.phoneNumber),
              ),
              if (!_isEdit) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: l10n.password),
                  obscureText: true,
                  validator: (v) => (v == null || v.length < 6)
                      ? l10n.passwordRequired
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: l10n.confirmPassword),
                  obscureText: true,
                  validator: (v) => v != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
              ],
              const SizedBox(height: 16),
              rolesAsync.when(
                data: (rolesList) => SearchableLookupField<Role>(
                  label: l10n.role,
                  items: rolesList,
                  itemLabel: (r) => r.name,
                  value: rolesList
                      .where((r) => r.id == _selectedRoleId)
                      .firstOrNull,
                  onChanged: (v) => setState(() {
                    _selectedRoleId = v?.id;
                    if (v?.scopeType == 'Global') {
                      _selectedGovernorateId = null;
                      _selectedDirectorateId = null;
                    }
                  }),
                  validator: (v) => v == null ? l10n.requiredField : null,
                ),
                loading: () => SearchableLookupField<Role>(
                  label: l10n.role,
                  items: const [],
                  itemLabel: (_) => '',
                  onChanged: (_) {},
                  isLoading: true,
                ),
                error: (e, _) => SearchableLookupField<Role>(
                  label: l10n.role,
                  items: const [],
                  itemLabel: (_) => '',
                  onChanged: (_) {},
                  errorText: 'Tap Refresh button in AppBar',
                ),
              ),
              if (scopeType != 'Global') ...[
                const SizedBox(height: 16),
                governoratesAsync.when(
                  data: (govList) => SearchableLookupField<Governorate>(
                    label: l10n.governorate,
                    items: govList,
                    itemLabel: (g) => g.nameEn,
                    searchStrings: (g) => [g.nameEn, g.nameAr],
                    value: govList
                        .where((g) => g.id == _selectedGovernorateId)
                        .firstOrNull,
                    onChanged: (v) => setState(() {
                      _selectedGovernorateId = v?.id;
                      _selectedDirectorateId = null;
                    }),
                    validator: (v) => v == null ? l10n.requiredField : null,
                  ),
                  loading: () => SearchableLookupField<Governorate>(
                    label: l10n.governorate,
                    items: const [],
                    itemLabel: (_) => '',
                    onChanged: (_) {},
                    isLoading: true,
                  ),
                  error: (e, _) => SearchableLookupField<Governorate>(
                    label: l10n.governorate,
                    items: const [],
                    itemLabel: (_) => '',
                    onChanged: (_) {},
                    errorText: 'Tap Refresh button in AppBar',
                  ),
                ),
              ],
              if (scopeType == 'Directorate') ...[
                const SizedBox(height: 16),
                _selectedGovernorateId == null
                    ? InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Directorate',
                        ),
                        child: const Text('Select Governorate first'),
                      )
                    : directoratesAsync.when(
                        data: (dirList) => SearchableLookupField<Directorate>(
                          label: l10n.directorate,
                          items: dirList,
                          itemLabel: (d) => d.nameEn,
                          searchStrings: (d) => [d.nameEn, d.nameAr],
                          value: dirList
                              .where((d) => d.id == _selectedDirectorateId)
                              .firstOrNull,
                          onChanged: (v) =>
                              setState(() => _selectedDirectorateId = v?.id),
                          validator: (v) =>
                              v == null ? l10n.requiredField : null,
                        ),
                        loading: () => SearchableLookupField<Directorate>(
                          label: l10n.directorate,
                          items: const [],
                          itemLabel: (_) => '',
                          onChanged: (_) {},
                          isLoading: true,
                        ),
                        error: (e, _) => SearchableLookupField<Directorate>(
                          label: l10n.directorate,
                          items: const [],
                          itemLabel: (_) => '',
                          onChanged: (_) {},
                          errorText: 'Tap Refresh button in AppBar',
                        ),
                      ),
              ],
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text(l10n.active),
                value: _isActive,
                onChanged: (v) => setState(() => _isActive = v),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: (state.isLoading || lookupLoading || lookupError)
                    ? null
                    : _submit,
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
