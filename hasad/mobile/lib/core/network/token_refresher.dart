import 'dart:async';

import 'package:mobile/core/storage/secure_storage_service.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/domain/auth_session.dart';

/// Coordinates refresh-token rotation so that concurrent 401s trigger a
/// single `/refresh` call instead of racing each other.
///
/// Rotation invalidates the presented refresh token, and the backend revokes
/// the whole token family on reuse — so a duplicate refresh would log the
/// user out. All refresh attempts must therefore go through [refreshSession].
class TokenRefresher {
  final AuthRepository _repository;
  final SecureStorageService _storage;

  Future<AuthSession?>? _inFlight;

  /// Creates a refresher backed by [repository] and [storage].
  TokenRefresher(AuthRepository repository, SecureStorageService storage)
    : _repository = repository,
      _storage = storage;

  /// Rotates the stored refresh token and persists the new session pair.
  ///
  /// Returns the new [AuthSession], or `null` when no refresh token is
  /// stored or the backend rejects it (expired/revoked). Concurrent callers
  /// share a single in-flight refresh.
  Future<AuthSession?> refreshSession() {
    return _inFlight ??= _doRefresh().whenComplete(() => _inFlight = null);
  }

  Future<AuthSession?> _doRefresh() async {
    final refreshToken = await _storage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }
    try {
      final session = await _repository.refresh(refreshToken);
      await _storage.saveToken(session.token);
      await _storage.saveRefreshToken(session.refreshToken);
      return session;
    } on AuthException {
      await _storage.clearAll();
      return null;
    } catch (_) {
      // Unexpected failure (not a backend rejection): keep the stored
      // tokens so a later attempt can retry, but report no session.
      return null;
    }
  }
}
