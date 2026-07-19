import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/auth_interceptor.dart';
import 'package:mobile/core/network/token_refresher.dart';

import 'fakes.dart';

/// Adapter that returns 401 for stale tokens and 200 for the rotated one.
class _ScriptedAdapter implements HttpClientAdapter {
  int requests = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests++;
    final auth = options.headers['Authorization'] as String?;
    if (auth == 'Bearer access-1') {
      return ResponseBody.fromString(
        jsonEncode({'succeeded': true}),
        200,
        headers: {
          'content-type': ['application/json'],
        },
      );
    }
    return ResponseBody.fromString(
      jsonEncode({'succeeded': false}),
      401,
      headers: {
        'content-type': ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group('AuthInterceptor', () {
    late FakeAuthRepository repository;
    late FakeSecureStorage storage;
    late _ScriptedAdapter adapter;
    late Dio dio;

    setUp(() {
      repository = FakeAuthRepository();
      storage = FakeSecureStorage();
      adapter = _ScriptedAdapter();

      final retryClient = Dio(BaseOptions(baseUrl: 'https://test.local'))
        ..httpClientAdapter = adapter;
      dio = Dio(BaseOptions(baseUrl: 'https://test.local'))
        ..httpClientAdapter = adapter
        ..interceptors.add(
          AuthInterceptor(
            storage,
            TokenRefresher(repository, storage),
            retryClient,
          ),
        );
    });

    test('refreshes and retries once after a 401', () async {
      storage.values['token'] = 'stale';
      storage.values['refresh'] = 'old-refresh';
      repository.session = sampleSession();

      final response = await dio.get<dynamic>('/v1/anything');

      expect(response.statusCode, 200);
      expect(repository.refreshCalls, 1);
      expect(adapter.requests, 2);
      expect(storage.values['token'], 'access-1');
    });

    test('propagates the 401 when refresh is not possible', () async {
      storage.values['token'] = 'stale';
      repository.session = null;

      await expectLater(
        dio.get<dynamic>('/v1/anything'),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
      expect(adapter.requests, 1);
    });

    test('does not attempt refresh for auth endpoints', () async {
      storage.values['token'] = 'stale';
      storage.values['refresh'] = 'old-refresh';
      repository.session = sampleSession();

      await expectLater(
        dio.post<dynamic>('/v1/accounts/login'),
        throwsA(isA<DioException>()),
      );
      expect(repository.refreshCalls, 0);
    });
  });
}
