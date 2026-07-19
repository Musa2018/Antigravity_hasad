import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/network/connectivity_provider.dart';
import 'package:mobile/core/presentation/widgets/searchable_lookup_field.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/admin/domain/role.dart';
import 'package:mobile/features/admin/domain/user.dart';
import 'package:mobile/features/admin/presentation/users_providers.dart';
import 'package:mobile/features/location/domain/directorate.dart';
import 'package:mobile/features/location/domain/governorate.dart';
import 'package:mobile/l10n/app_localizations.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = ref.read(usersListProvider);
      if (!state.isLoading &&
          (state.data?.pageNumber ?? 0) < (state.data?.totalPages ?? 0)) {
        ref
            .read(usersListProvider.notifier)
            .fetchUsers(pageNumber: (state.data?.pageNumber ?? 0) + 1);
      }
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        ref
            .read(usersListProvider.notifier)
            .setSearch(query.isEmpty ? null : query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(usersListProvider);
    final users = state.data?.items ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.users),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              if (await ref.checkIsOffline()) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No internet connection.')),
                );
                return;
              }
              ref.read(usersListProvider.notifier).fetchUsers(isRefresh: true);
            },
            tooltip: 'Refresh List',
          ),
          IconButton(
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
            ),
            onPressed: () => setState(() => _showFilters = !_showFilters),
            tooltip: 'Toggle Filters',
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () async {
              if (await ref.checkIsOffline()) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'No internet connection. This action is online only.',
                    ),
                  ),
                );
                return;
              }
              if (!context.mounted) return;
              context.push(AppRoutes.addUser);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, email, or username...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          // إيقاف أي عملية بحث معلقة
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          // مسح النص
                          _searchController.clear();
                          // إجبار الواجهة على التحديث لإخفاء الأيقونة فوراً
                          setState(() {});
                          // إعادة جلب البيانات
                          ref.read(usersListProvider.notifier).setSearch(null);
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                _onSearchChanged(value);
                // إجبار الواجهة على التحديث عند كل حرف لتظهر الأيقونة
                setState(() {});
              },
            ),
          ),
          if (_showFilters) _FilterPanel(),
          if (state.isLoading && users.isEmpty)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (state.errors.isNotEmpty && users.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errors.first,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (await ref.checkIsOffline()) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No internet connection.'),
                            ),
                          );
                          return;
                        }
                        ref
                            .read(usersListProvider.notifier)
                            .fetchUsers(isRefresh: true);
                      },
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            )
          else if (users.isEmpty && !state.isLoading)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.noUsers),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (await ref.checkIsOffline()) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No internet connection.'),
                            ),
                          );
                          return;
                        }
                        if (!context.mounted) return;
                        context.push(AppRoutes.addUser);
                      },
                      icon: const Icon(Icons.person_add),
                      label: Text(l10n.addUser),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  if (await ref.checkIsOffline()) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No internet connection.')),
                    );
                    return;
                  }
                  return ref
                      .read(usersListProvider.notifier)
                      .fetchUsers(isRefresh: true);
                },
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: users.length + (state.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == users.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return _UserCard(user: users[index]);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterPanel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(usersListProvider);
    final rolesAsync = ref.watch(rolesProvider);
    final governoratesAsync = ref.watch(governoratesProvider);
    final directoratesAsync = state.governorateId != null
        ? ref.watch(directoratesProvider(state.governorateId))
        : const AsyncValue<List<Directorate>>.data([]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: rolesAsync.when(
                  data: (roles) => SearchableLookupField<Role>(
                    label: 'Role',
                    items: roles,
                    itemLabel: (r) => r.name,
                    value: roles.where((r) => r.name == state.role).firstOrNull,
                    onChanged: (v) =>
                        ref.read(usersListProvider.notifier).setRole(v?.name),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: LinearProgressIndicator(),
                  ),
                  error: (e, _) => const Text('Error loading roles'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: governoratesAsync.when(
                  data: (govs) => SearchableLookupField<Governorate>(
                    label: 'Governorate',
                    items: govs,
                    itemLabel: (g) => g.nameEn,
                    searchStrings: (g) => [g.nameEn, g.nameAr],
                    value: govs
                        .where((g) => g.id == state.governorateId)
                        .firstOrNull,
                    onChanged: (v) => ref
                        .read(usersListProvider.notifier)
                        .setGovernorate(v?.id),
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: LinearProgressIndicator(),
                  ),
                  error: (e, _) => const Text('Error loading geo'),
                ),
              ),
            ],
          ),
          if (state.governorateId != null) ...[
            const SizedBox(height: 8),
            directoratesAsync.when(
              data: (dirs) => SearchableLookupField<Directorate>(
                label: 'Directorate',
                items: dirs,
                itemLabel: (d) => d.nameEn,
                searchStrings: (d) => [d.nameEn, d.nameAr],
                value: dirs
                    .where((d) => d.id == state.directorateId)
                    .firstOrNull,
                onChanged: (v) =>
                    ref.read(usersListProvider.notifier).setDirectorate(v?.id),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => const Text('Error loading directorates'),
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () =>
                    ref.read(usersListProvider.notifier).clearFilters(),
                icon: const Icon(Icons.clear_all, size: 18),
                label: const Text('Clear All Filters'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserCard extends ConsumerWidget {
  final User user;

  const _UserCard({required this.user});

  Future<void> _resetPassword(BuildContext context, WidgetRef ref) async {
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter new password for ${user.fullName}'),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (v) =>
                    (v == null || v.length < 6) ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                validator: (v) => v != passwordController.text
                    ? 'Passwords do not match'
                    : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(userManagementProvider.notifier)
          .resetPassword(
            userId: user.id,
            newPassword: passwordController.text,
            confirmPassword: confirmController.text,
          );

      if (context.mounted) {
        final state = ref.read(userManagementProvider);
        if (state.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successfully')),
          );
        } else if (state.errors.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errors.first),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _toggleStatus(BuildContext context, WidgetRef ref) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.isActive ? 'Deactivate User' : 'Activate User'),
        content: Text(
          'Are you sure you want to ${user.isActive ? 'deactivate' : 'activate'} ${user.fullName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(user.isActive ? 'Deactivate' : 'Activate'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(userManagementProvider.notifier)
          .changeStatus(userId: user.id, isActive: !user.isActive);

      if (context.mounted) {
        final state = ref.read(userManagementProvider);
        if (state.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User ${user.isActive ? 'deactivated' : 'activated'} successfully',
              ),
            ),
          );
          ref.read(usersListProvider.notifier).fetchUsers(isRefresh: true);
        } else if (state.errors.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errors.first),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text(user.fullName[0].toUpperCase())),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '@${user.userName}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                _StatusBadge(isActive: user.isActive),
              ],
            ),
            const Divider(height: 24),
            _InfoRow(
              icon: Icons.badge_outlined,
              label: 'Role',
              value: user.role,
            ),
            _InfoRow(
              icon: Icons.location_on_outlined,
              label: 'Governorate',
              value: user.governorateName ?? 'Global',
            ),
            if (user.directorateName != null)
              _InfoRow(
                icon: Icons.business_outlined,
                label: 'Directorate',
                value: user.directorateName!,
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    if (await ref.checkIsOffline()) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No internet connection.'),
                        ),
                      );
                      return;
                    }
                    if (!context.mounted) return;
                    context.push(AppRoutes.editUser, extra: user);
                  },
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit'),
                ),
                TextButton.icon(
                  onPressed: () async {
                    if (await ref.checkIsOffline()) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No internet connection.'),
                        ),
                      );
                      return;
                    }
                    if (!context.mounted) return;
                    _resetPassword(context, ref);
                  },
                  icon: const Icon(Icons.lock_reset_outlined, size: 18),
                  label: const Text('Reset'),
                ),
                TextButton.icon(
                  onPressed: () async {
                    if (await ref.checkIsOffline()) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No internet connection.'),
                        ),
                      );
                      return;
                    }
                    if (!context.mounted) return;
                    _toggleStatus(context, ref);
                  },
                  icon: Icon(
                    user.isActive
                        ? Icons.person_off_outlined
                        : Icons.person_outline,
                    size: 18,
                  ),
                  label: Text(user.isActive ? 'Deactivate' : 'Activate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;

  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.green.shade200 : Colors.red.shade200,
        ),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? Colors.green.shade700 : Colors.red.shade700,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
