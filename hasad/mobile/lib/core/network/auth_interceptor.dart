import 'package:dio/dio.dart';
import 'package:mobile/core/network/token_refresher.dart';
import 'package:mobile/core/storage/secure_storage_service.dart';

/// Attaches the access token to outgoing requests and transparently
/// recovers from 401 responses by rotating the refresh token and retrying
/// the failed request once.
class AuthInterceptor extends Interceptor {
  static const _retriedKey = 'auth_interceptor_retried';

  final SecureStorageService _storage;
  final TokenRefresher _refresher;
  final Dio _retryClient;

  /// Creates the interceptor.
  ///
  /// [retryClient] is a bare [Dio] (without this interceptor) used to replay
  /// the original request after a successful refresh.
  AuthInterceptor(this._storage, this._refresher, Dio retryClient)
    : _retryClient = retryClient;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final isAuthEndpoint = options.path.contains('/accounts/');
    final alreadyRetried = options.extra[_retriedKey] == true;

    if (err.response?.statusCode != 401 || isAuthEndpoint || alreadyRetried) {
      return handler.next(err);
    }

    final session = await _refresher.refreshSession();
    if (session == null) {
      return handler.next(err);
    }

    try {
      options.extra[_retriedKey] = true;
      options.headers['Authorization'] = 'Bearer ${session.token}';
      final response = await _retryClient.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    }
  }
}
