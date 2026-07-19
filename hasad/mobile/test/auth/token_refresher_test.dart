import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/token_refresher.dart';

import 'fakes.dart';

void main() {
  group('TokenRefresher', () {
    late FakeAuthRepository repository;
    late FakeSecureStorage storage;
    late TokenRefresher refresher;

    setUp(() {
      repository = FakeAuthRepository();
      storage = FakeSecureStorage();
      refresher = TokenRefresher(repository, storage);
    });

    test('returns null when no refresh token is stored', () async {
      expect(await refresher.refreshSession(), isNull);
      expect(repository.refreshCalls, 0);
    });

    test('rotates and persists the new token pair', () async {
      storage.values['refresh'] = 'old-refresh';
      repository.session = sampleSession();

      final session = await refresher.refreshSession();

      expect(session, isNotNull);
      expect(await storage.getToken(), 'access-1');
      expect(await storage.getRefreshToken(), 'refresh-1');
    });

    test('clears storage when the backend rejects the token', () async {
      storage.values['refresh'] = 'revoked';
      storage.values['token'] = 'stale';
      repository.session = null;

      expect(await refresher.refreshSession(), isNull);
      expect(storage.values, isEmpty);
    });

    test('concurrent callers share a single in-flight refresh', () async {
      storage.values['refresh'] = 'old-refresh';
      repository.session = sampleSession();
      repository.refreshDelay = const Duration(milliseconds: 50);

      final results = await Future.wait([
        refresher.refreshSession(),
        refresher.refreshSession(),
        refresher.refreshSession(),
      ]);

      expect(repository.refreshCalls, 1);
      expect(results.every((s) => s != null), isTrue);
    });

    test('allows a new refresh after the previous one completes', () async {
      storage.values['refresh'] = 'old-refresh';
      repository.session = sampleSession();

      await refresher.refreshSession();
      await refresher.refreshSession();

      expect(repository.refreshCalls, 2);
    });

    test('unexpected failure returns null without clearing storage', () async {
      storage.values['refresh'] = 'old-refresh';
      repository.unexpectedError = StateError('boom');

      expect(await refresher.refreshSession(), isNull);
      expect(await storage.getRefreshToken(), 'old-refresh');
    });
  });
}
