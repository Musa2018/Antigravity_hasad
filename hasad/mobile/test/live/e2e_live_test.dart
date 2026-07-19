import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';

import '../auth/fakes.dart';

const _base = 'http://localhost:5271/api';
const _email = String.fromEnvironment('LIVE_E2E_EMAIL');
const _password = String.fromEnvironment('LIVE_E2E_PASSWORD');

/// Enable with:
/// flutter test test/live --dart-define=LIVE_E2E=true \
///   --dart-define=LIVE_E2E_EMAIL=... --dart-define=LIVE_E2E_PASSWORD=...
/// (the seeded admin credentials)
/// Requires the backend running locally with the seeded admin account.
const _liveE2eEnabled = bool.fromEnvironment('LIVE_E2E');

void main() {
  final dio = Dio(BaseOptions(baseUrl: _base));
  final repository = AuthRepositoryImpl(dio);

  test(
    'E2E: full auth lifecycle against the live backend',
    skip: !_liveE2eEnabled,
    () async {
      final storage = FakeSecureStorage();
      final refresher = TokenRefresher(repository, storage);
      final notifier = AuthNotifier(repository, storage, refresher);

      // 1. Login + token persistence
      await notifier.login(_email, _password);
      expect(notifier.state.status, AuthStatus.authenticated);
      final accessToken1 = storage.values['token'];
      final refreshToken1 = storage.values['refresh'];
      expect(accessToken1, isNotEmpty);
      expect(refreshToken1, isNotEmpty);

      // 2. Manual refresh -> rotation (both tokens replaced).
      // Wait >1s so the new JWT's iat/exp claims differ.
      await Future<void>.delayed(const Duration(milliseconds: 1100));
      final session2 = await refresher.refreshSession();
      expect(session2, isNotNull);
      expect(storage.values['token'], isNot(accessToken1));
      expect(storage.values['refresh'], isNot(refreshToken1));

      // 3. Session restoration after "app restart" (new notifier, same storage)
      final restored = AuthNotifier(
        repository,
        storage,
        TokenRefresher(repository, storage),
      );
      await restored.restoreSession();
      expect(restored.state.status, AuthStatus.authenticated);
      expect(restored.state.session?.email, _email);

      // 5. Logout -> revocation + cleared storage
      final finalRefresh = storage.values['refresh'];
      await restored.logout();
      expect(restored.state.status, AuthStatus.unauthenticated);
      expect(storage.values, isEmpty);

      // 6. Revoked refresh token must be rejected
      await expectLater(
        repository.refresh(finalRefresh!),
        throwsA(isA<AuthException>()),
      );

      // 7. Reuse of a rotated token is rejected and revokes the family
      final storage2 = FakeSecureStorage();
      final refresher2 = TokenRefresher(repository, storage2);
      final notifier2 = AuthNotifier(repository, storage2, refresher2);
      await notifier2.login(_email, _password);
      final rotatedAway = storage2.values['refresh'];
      await refresher2.refreshSession();
      await expectLater(
        repository.refresh(rotatedAway!),
        throwsA(isA<AuthException>()),
      );
      // Family revoked: the current token no longer restores a session
      final notifier3 = AuthNotifier(
        repository,
        storage2,
        TokenRefresher(repository, storage2),
      );
      await notifier3.restoreSession();
      expect(notifier3.state.status, AuthStatus.unauthenticated);
    },
  );
}
