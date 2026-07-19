import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';

/// Adapter that always returns the configured JSON body with status 200.
class _FixedAdapter implements HttpClientAdapter {
  final Map<String, dynamic> body;

  _FixedAdapter(this.body);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        'content-type': ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

AuthRepositoryImpl _repositoryFor(Map<String, dynamic> body) {
  final dio = Dio(BaseOptions(baseUrl: 'https://test.local'))
    ..httpClientAdapter = _FixedAdapter(body);
  return AuthRepositoryImpl(dio);
}

void main() {
  group('AuthRepositoryImpl', () {
    test('parses a well-formed session payload', () async {
      final repository = _repositoryFor({
        'succeeded': true,
        'data': {
          'token': 'access-1',
          'refreshToken': 'refresh-1',
          'userId': 'user-1',
          'email': 'admin@hasad.ps',
          'fullName': 'Super Admin',
          'roles': ['SuperAdmin'],
          'governorateId': 'gz-1',
          'directorateId': 'dir-1',
        },
      });

      final session = await repository.login('admin@hasad.ps', 'password');

      expect(session.token, 'access-1');
      expect(session.refreshToken, 'refresh-1');
    });

    test('malformed payload surfaces as AuthException', () async {
      final repository = _repositoryFor({
        'succeeded': true,
        'data': {'token': null, 'unexpected': 'shape'},
      });

      await expectLater(
        repository.login('admin@hasad.ps', 'password'),
        throwsA(isA<AuthException>()),
      );
    });

    test('failed envelope surfaces backend errors', () async {
      final repository = _repositoryFor({
        'succeeded': false,
        'errors': ['Invalid email or password.'],
      });

      await expectLater(
        repository.login('admin@hasad.ps', 'password'),
        throwsA(
          isA<AuthException>().having((e) => e.errors, 'errors', [
            'Invalid email or password.',
          ]),
        ),
      );
    });
  });
}
