import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

/// Landing screen shown after a successful login.
class HomeScreen extends ConsumerWidget {
  /// Creates the home screen.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(authProvider).session;

    final canAccessFarmers =
        session?.roles.any(
          (r) => const [
            'SuperAdmin',
            'Administrator',
            'AgriculturalEngineer',
            'FieldSurveyor',
            'ReadOnly',
          ].contains(r),
        ) ??
        true;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboard),
        actions: [
          IconButton(
            tooltip: l10n.logout,
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.welcome(session?.fullName ?? session?.email ?? ''),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: [
                if (canAccessFarmers)
                  _FeatureCard(
                    title: l10n.farmers,
                    icon: Icons.people,
                    onTap: () => context.push(AppRoutes.farmers),
                  ),
                if (session?.roles.contains('SuperAdmin') ?? false)
                  _FeatureCard(
                    title: l10n.users,
                    icon: Icons.admin_panel_settings,
                    onTap: () => context.push(AppRoutes.users),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
