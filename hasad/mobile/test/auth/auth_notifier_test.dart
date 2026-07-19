import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';

import 'fakes.dart';

void main() {
  group('AuthNotifier', () {
    late FakeAuthRepository repository;
    late FakeSecureStorage storage;

    AuthNotifier createNotifier() =>
        AuthNotifier(repository, storage, TokenRefresher(repository, storage));

    setUp(() {
      repository = FakeAuthRepository();
      storage = FakeSecureStorage();
    });

    test('resolves to unauthenticated when no session is stored', () async {
      final notifier = createNotifier();
      await notifier.restoreSession();

      expect(notifier.state.status, AuthStatus.unauthenticated);
    });

    test('restores a session from a stored refresh token', () async {
      storage.values['refresh'] = 'stored-refresh';
      repository.session = sampleSession();

      final notifier = createNotifier();
      await notifier.restoreSession();

      expect(notifier.state.status, AuthStatus.authenticated);
      expect(notifier.state.session?.email, 'admin@hasad.ps');
      expect(await storage.getRefreshToken(), 'refresh-1');
    });

    test('login persists the token pair and authenticates', () async {
      repository.session = sampleSession();
      final notifier = createNotifier();
      await notifier.restoreSession(); // Ensure initialization completes

      await notifier.login('admin@hasad.ps', 'password');

      expect(notifier.state.status, AuthStatus.authenticated);
      expect(await storage.getToken(), 'access-1');
      expect(await storage.getRefreshToken(), 'refresh-1');
    });

    test('login with rememberMe persists the email', () async {
      repository.session = sampleSession();
      final notifier = createNotifier();
      await notifier.restoreSession();

      await notifier.login('admin@hasad.ps', 'password', rememberMe: true);

      expect(await storage.getRememberedEmail(), 'admin@hasad.ps');
    });

    test('failed login surfaces errors and stays unauthenticated', () async {
      repository.session = null;
      final notifier = createNotifier();
      await notifier.restoreSession();

      await notifier.login('admin@hasad.ps', 'wrong');

      expect(notifier.state.status, AuthStatus.unauthenticated);
      expect(notifier.state.errors, isNotEmpty);
      expect(await storage.getToken(), isNull);
    });

    test('unexpected login failure clears the loading state', () async {
      repository.unexpectedError = StateError('boom');
      final notifier = createNotifier();
      await notifier.restoreSession();

      await notifier.login('admin@hasad.ps', 'password');

      expect(notifier.state.status, AuthStatus.unauthenticated);
      expect(notifier.state.isLoading, isFalse);
    });

    test(
      'logout revokes the refresh token and clears credentials but keeps email',
      () async {
        repository.session = sampleSession();
        final notifier = createNotifier();
        await notifier.restoreSession();
        await notifier.login('admin@hasad.ps', 'password', rememberMe: true);

        await notifier.logout();

        expect(notifier.state.status, AuthStatus.unauthenticated);
        expect(repository.logoutCalls, 1);
        expect(repository.revokedTokens, ['refresh-1']);
        expect(await storage.getToken(), isNull);
        expect(await storage.getRememberedEmail(), 'admin@hasad.ps');
      },
    );

    test('logout without a stored token skips the server call', () async {
      final notifier = createNotifier();
      await notifier.restoreSession();

      await notifier.logout();

      expect(repository.logoutCalls, 0);
      expect(notifier.state.status, AuthStatus.unauthenticated);
    });
  });
}
