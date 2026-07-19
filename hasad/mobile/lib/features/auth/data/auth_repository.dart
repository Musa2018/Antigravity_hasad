import 'package:dio/dio.dart';
import 'package:mobile/features/auth/domain/auth_session.dart';

/// Raised when an auth endpoint rejects a request (invalid credentials,
/// expired/revoked refresh token, or validation failure).
class AuthException implements Exception {
  /// Error messages returned by the backend, if any.
  final List<String> errors;

  /// Creates an [AuthException] from backend error messages.
  AuthException(this.errors);

  @override
  String toString() =>
      errors.isEmpty ? 'Authentication failed.' : errors.join('\n');
}

/// Contract for the backend authentication endpoints.
abstract class AuthRepository {
  /// Authenticates with [email] and [password], returning a session pair.
  Future<AuthSession> login(String email, String password);

  /// Exchanges [refreshToken] for a new rotated session pair.
  Future<AuthSession> refresh(String refreshToken);

  /// Revokes [refreshToken] and its token family on the server.
  Future<void> logout(String refreshToken);

  /// Requests a password reset for [email].
  Future<void> forgotPassword(String email);

  /// Resets password using [token] and [newPassword] for [email].
  Future<void> resetPassword(String email, String token, String newPassword);
}

/// Dio-backed implementation of [AuthRepository] targeting the HASAD API.
class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  /// Creates the repository with a configured [Dio] client whose `baseUrl`
  /// points at the API root (e.g. `https://.../api`).
  AuthRepositoryImpl(this._dio);

  @override
  Future<AuthSession> login(String email, String password) {
    return _postForSession('/v1/accounts/login', {
      'email': email,
      'password': password,
    });
  }

  @override
  Future<AuthSession> refresh(String refreshToken) {
    return _postForSession('/v1/accounts/refresh', {
      'refreshToken': refreshToken,
    });
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/v1/accounts/logout',
        data: {'refreshToken': refreshToken},
      );
    } on DioException catch (e) {
      throw AuthException(_errorsFrom(e));
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/v1/accounts/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw AuthException(_errorsFrom(e));
    }
  }

  @override
  Future<void> resetPassword(
    String email,
    String token,
    String newPassword,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/accounts/reset-password',
        data: {'email': email, 'token': token, 'newPassword': newPassword},
      );
      if (response.data?['succeeded'] != true) {
        throw AuthException(_errorsFromEnvelope(response.data));
      }
    } on DioException catch (e) {
      throw AuthException(_errorsFrom(e));
    }
  }

  Future<AuthSession> _postForSession(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(path, data: body);
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data is! Map<String, dynamic>) {
        throw AuthException(_errorsFromEnvelope(envelope));
      }
      try {
        return AuthSession.fromJson(data);
      } catch (_) {
        // Malformed payload (missing/mistyped fields): surface as an auth
        // failure instead of an opaque deserialization error.
        throw AuthException(const []);
      }
    } on DioException catch (e) {
      throw AuthException(_errorsFrom(e));
    }
  }

  static List<String> _errorsFrom(DioException e) {
    final body = e.response?.data;
    if (body is Map<String, dynamic>) {
      return _errorsFromEnvelope(body);
    }
    return const [];
  }

  static List<String> _errorsFromEnvelope(Map<String, dynamic>? envelope) {
    final errors = envelope?['errors'];
    if (errors is List) {
      return errors.whereType<String>().toList();
    }
    return const [];
  }
}
