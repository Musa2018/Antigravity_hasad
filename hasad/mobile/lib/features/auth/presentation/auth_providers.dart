import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/core/network/auth_interceptor.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/core/storage/secure_storage_service.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/domain/auth_session.dart';

/// Raw secure storage backend.
final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

/// Token persistence service.
final secureStorageServiceProvider = Provider((ref) {
  return SecureStorageService(ref.watch(secureStorageProvider));
});

/// Bare HTTP client (no auth interceptor) targeting the configured API root.
/// Used for auth endpoints and for replaying refreshed requests.
final baseDioProvider = Provider((ref) {
  return Dio(BaseOptions(baseUrl: EnvironmentConfig.config.apiBaseUrl));
});

/// Backend authentication endpoints.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(baseDioProvider));
});

/// Single-flight refresh-token rotation coordinator.
final tokenRefresherProvider = Provider((ref) {
  return TokenRefresher(
    ref.watch(authRepositoryProvider),
    ref.watch(secureStorageServiceProvider),
  );
});

/// Authenticated HTTP client for application API calls: attaches the access
/// token and retries once after a 401 via refresh-token rotation.
final apiDioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: EnvironmentConfig.config.apiBaseUrl));
  dio.interceptors.add(
    AuthInterceptor(
      ref.watch(secureStorageServiceProvider),
      ref.watch(tokenRefresherProvider),
      ref.watch(baseDioProvider),
    ),
  );
  return dio;
});

/// High-level authentication lifecycle states.
enum AuthStatus {
  /// Session restoration has not completed yet.
  unknown,

  /// A valid session is active.
  authenticated,

  /// No valid session; the user must log in.
  unauthenticated,
}

/// Immutable authentication state exposed to the UI and the router.
class AuthState {
  /// Current lifecycle status.
  final AuthStatus status;

  /// Active session data when [status] is [AuthStatus.authenticated].
  final AuthSession? session;

  /// Whether a login request is in progress.
  final bool isLoading;

  /// Error messages from the last failed login attempt.
  final List<String> errors;

  /// Creates an [AuthState].
  const AuthState({
    this.status = AuthStatus.unknown,
    this.session,
    this.isLoading = false,
    this.errors = const [],
  });

  /// Convenience flag for router guards.
  bool get isAuthenticated => status == AuthStatus.authenticated;
}

/// Manages login, logout, and session restoration.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final SecureStorageService _storage;
  final TokenRefresher _refresher;

  /// Creates the notifier and immediately starts session restoration.
  AuthNotifier(this._repository, this._storage, this._refresher)
    : super(const AuthState()) {
    restoreSession();
  }

  /// Restores a persisted session after app restart by rotating the stored
  /// refresh token. Resolves to unauthenticated when no valid token exists.
  Future<void> restoreSession() async {
    final session = await _refresher.refreshSession();
    if (!mounted) return;
    state = session == null
        ? const AuthState(status: AuthStatus.unauthenticated)
        : AuthState(status: AuthStatus.authenticated, session: session);
  }

  /// Attempts to log in and persists the returned token pair on success.
  Future<void> login(
    String email,
    String password, {
    bool rememberMe = false,
  }) async {
    state = const AuthState(
      status: AuthStatus.unauthenticated,
      isLoading: true,
    );
    try {
      final session = await _repository.login(email, password);
      await _storage.saveToken(session.token);
      await _storage.saveRefreshToken(session.refreshToken);

      if (rememberMe) {
        await _storage.saveRememberedEmail(email);
      } else {
        await _storage.saveRememberedEmail(null);
      }

      if (!mounted) return;
      state = AuthState(status: AuthStatus.authenticated, session: session);
    } on AuthException catch (e) {
      if (!mounted) return;
      state = AuthState(status: AuthStatus.unauthenticated, errors: e.errors);
    } catch (_) {
      // Any unexpected failure must still clear the loading state so the
      // user can retry.
      if (!mounted) return;
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  /// Revokes the refresh-token family on the server (best effort) and
  /// clears all locally persisted tokens.
  Future<void> logout() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await _repository.logout(refreshToken);
      } on AuthException {
        // Server-side revocation is best effort; local logout always proceeds.
      }
    }
    await _storage
        .logout(); // Use the new logout that preserves remembered email
    if (!mounted) return;
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

/// Provides the remembered email if any.
final rememberedEmailProvider = FutureProvider<String?>((ref) async {
  return await ref.watch(secureStorageServiceProvider).getRememberedEmail();
});

/// Application-wide authentication state.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(secureStorageServiceProvider),
    ref.watch(tokenRefresherProvider),
  );
});
