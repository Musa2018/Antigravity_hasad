import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/auth/presentation/forgot_password_screen.dart';
import 'package:mobile/features/auth/presentation/reset_password_screen.dart';
import 'package:mobile/features/auth/presentation/login_screen.dart';
import 'package:mobile/features/farmers/domain/damage_report.dart';
import 'package:mobile/features/farmers/domain/farm.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';
import 'package:mobile/features/farmers/presentation/damage_report/attachment_gallery_screen.dart';
import 'package:mobile/features/farmers/presentation/damage_report/damage_report_form_screen.dart';
import 'package:mobile/features/farmers/presentation/damage_report/damage_reports_list_screen.dart';
import 'package:mobile/features/farmers/presentation/compensation/compensation_screen.dart';
import 'package:mobile/features/farmers/presentation/farm_form_screen.dart';
import 'package:mobile/features/farmers/presentation/farmer_form_screen.dart';
import 'package:mobile/features/farmers/presentation/farmers_list_screen.dart';
import 'package:mobile/features/farmers/presentation/farms_list_screen.dart';
import 'package:mobile/features/farmers/presentation/farmer_details_screen.dart';
import 'package:mobile/features/farmers/presentation/farmer_search_screen.dart';
import 'package:mobile/features/home/presentation/home_screen.dart';
import 'package:mobile/features/admin/domain/user.dart';
import 'package:mobile/features/admin/presentation/users_screen.dart';
import 'package:mobile/features/admin/presentation/create_user_screen.dart';

/// Route paths used across the application.
abstract final class AppRoutes {
  /// Splash shown while the persisted session is being restored.
  static const splash = '/';

  /// Login screen.
  static const login = '/login';

  /// Forgot password.
  static const forgotPassword = '/forgot-password';

  /// Reset password.
  static const resetPassword = '/reset-password';

  /// Authenticated home screen.
  static const home = '/home';

  /// Users list.
  static const users = '/users';

  /// Add user.
  static const addUser = '/users/add';

  /// Edit user.
  static const editUser = '/users/edit';

  /// Farmer search.
  static const farmerSearch = '/farmers/search';

  /// Farmer details.
  static const farmerDetails = '/farmers/details';

  /// Farmers list.
  static const farmers = '/farmers';

  /// Add farmer.
  static const addFarmer = '/farmers/add';

  /// Edit farmer.
  static const editFarmer = '/farmers/edit';

  /// Farms list.
  static const farms = '/farms';

  /// Add farm.
  static const addFarm = '/farms/add';

  /// Edit farm.
  static const editFarm = '/farms/edit';

  /// Damage reports list.
  static const damageReports = '/damage-reports';

  /// Add damage report.
  static const addDamageReport = '/damage-reports/add';

  /// Edit damage report.
  static const editDamageReport = '/damage-reports/edit';

  /// Attachment gallery.
  static const attachments = '/damage-reports/attachments';

  /// Compensation.
  static const compensation = '/compensation';
}

/// Bridges a Riverpod provider into a [Listenable] so GoRouter re-evaluates
/// its redirect whenever authentication state changes.
class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, _) => notifyListeners());
  }
}

/// Application router with an authentication guard.
///
/// - While the session is being restored, all navigation stays on the splash
///   route.
/// - Unauthenticated users are redirected to [AppRoutes.login].
/// - Authenticated users are kept out of the splash/login routes and land on
///   [AppRoutes.home].
final appRouterProvider = Provider<GoRouter>((ref) {
  final listenable = _AuthStateListenable(ref);
  ref.onDispose(listenable.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: listenable,
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final location = state.matchedLocation;

      if (auth.status == AuthStatus.unknown) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (!auth.isAuthenticated) {
        final isAuthPath =
            location == AppRoutes.login ||
            location == AppRoutes.forgotPassword ||
            location == AppRoutes.resetPassword;
        return isAuthPath ? null : AppRoutes.login;
      }

      if (location == AppRoutes.splash ||
          location == AppRoutes.login ||
          location == AppRoutes.forgotPassword ||
          location == AppRoutes.resetPassword) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) =>
            ResetPasswordScreen(email: state.extra as String),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.users,
        builder: (context, state) => const UsersScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const UserFormScreen(),
          ),
          GoRoute(
            path: 'edit',
            builder: (context, state) =>
                UserFormScreen(user: state.extra as User?),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.farmers,
        builder: (context, state) => const FarmersListScreen(),
      ),
      GoRoute(
        path: AppRoutes.farmerSearch,
        builder: (context, state) => const FarmerSearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.farmerDetails,
        builder: (context, state) =>
            FarmerDetailsScreen(farmer: state.extra as Farmer),
      ),
      GoRoute(
        path: AppRoutes.addFarmer,
        builder: (context, state) =>
            FarmerFormScreen(initialIdNumber: state.extra as String?),
      ),
      GoRoute(
        path: AppRoutes.editFarmer,
        builder: (context, state) =>
            FarmerFormScreen(farmer: state.extra as Farmer?),
      ),
      GoRoute(
        path: AppRoutes.farms,
        builder: (context, state) =>
            FarmsListScreen(farmer: state.extra as Farmer),
      ),
      GoRoute(
        path: AppRoutes.addFarm,
        builder: (context, state) =>
            FarmFormScreen(farmer: state.extra as Farmer),
      ),
      GoRoute(
        path: AppRoutes.editFarm,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return FarmFormScreen(
            farmer: extra['farmer'] as Farmer,
            farm: extra['farm'] as Farm,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.damageReports,
        builder: (context, state) =>
            DamageReportsListScreen(farm: state.extra as Farm),
      ),
      GoRoute(
        path: AppRoutes.addDamageReport,
        builder: (context, state) =>
            DamageReportFormScreen(farm: state.extra as Farm),
      ),
      GoRoute(
        path: AppRoutes.editDamageReport,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DamageReportFormScreen(
            farm: extra['farm'] as Farm,
            report: extra['report'] as DamageReport,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.attachments,
        builder: (context, state) =>
            AttachmentGalleryScreen(reportId: state.extra as String),
      ),
      GoRoute(
        path: AppRoutes.compensation,
        builder: (context, state) =>
            CompensationScreen(reportId: state.extra as String),
      ),
    ],
  );
});
