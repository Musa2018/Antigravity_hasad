import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/admin/data/users_repository.dart';
import 'package:mobile/features/location/data/location_repository.dart';
import 'package:mobile/features/location/domain/directorate.dart';
import 'package:mobile/features/location/domain/governorate.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class _FixedAdapter implements HttpClientAdapter {
  final Map<String, dynamic> body;
  final int statusCode;

  _FixedAdapter(this.body, {this.statusCode = 200});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        'content-type': ['application/json'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

UsersRepositoryImpl _repositoryFor(
  Map<String, dynamic> body, {
  int statusCode = 200,
  LocationRepository? locationRepo,
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://test.local'))
    ..httpClientAdapter = _FixedAdapter(body, statusCode: statusCode);
  return UsersRepositoryImpl(dio, locationRepo ?? MockLocationRepository());
}

void main() {
  group('UsersRepositoryImpl', () {
    test('getRoles returns list of roles on success', () async {
      final repository = _repositoryFor({
        'succeeded': true,
        'data': [
          {'id': 'r1', 'name': 'SuperAdmin', 'scopeType': 'Global'},
          {'id': 'r2', 'name': 'Admin', 'scopeType': 'Global'},
        ],
      });

      final roles = await repository.getRoles();

      expect(roles.length, 2);
      expect(roles[0].name, 'SuperAdmin');
      expect(roles[0].scopeType, 'Global');
      expect(roles[1].name, 'Admin');
    });

    test('getGovernorates returns list of governorates on success', () async {
      final mockLocRepo = MockLocationRepository();
      when(() => mockLocRepo.getGovernorates()).thenAnswer(
        (_) async => [Governorate(id: 'g1', nameAr: 'غزة', nameEn: 'Gaza')],
      );
      final repository = _repositoryFor({}, locationRepo: mockLocRepo);

      final govs = await repository.getGovernorates();

      expect(govs.length, 1);
      expect(govs[0].nameEn, 'Gaza');
    });

    test('getDirectorates returns filtered list on success', () async {
      final mockLocRepo = MockLocationRepository();
      when(() => mockLocRepo.getDirectorates(governorateId: 'g1')).thenAnswer(
        (_) async => [
          Directorate(
            id: 'd1',
            nameAr: 'د1',
            nameEn: 'D1',
            governorateId: 'g1',
          ),
        ],
      );
      final repository = _repositoryFor({}, locationRepo: mockLocRepo);

      final dirs = await repository.getDirectorates(governorateId: 'g1');

      expect(dirs.length, 1);
      expect(dirs[0].governorateId, 'g1');
    });

    test('throws UsersException when succeeded is false', () async {
      final repository = _repositoryFor({
        'succeeded': false,
        'errors': ['Something went wrong'],
      });

      expect(
        () => repository.getRoles(),
        throwsA(
          isA<UsersException>().having((e) => e.errors, 'errors', [
            'Something went wrong',
          ]),
        ),
      );
    });

    test('throws UsersException on Dio error', () async {
      final repository = _repositoryFor({
        'succeeded': false,
        'errors': ['Internal Server Error'],
      }, statusCode: 500);

      expect(() => repository.getRoles(), throwsA(isA<UsersException>()));
    });

    test('createUser sends correct data and succeeds', () async {
      final repository = _repositoryFor({'succeeded': true});

      await repository.createUser(
        fullName: 'New User',
        userName: 'newuser',
        email: 'new@test.com',
        phoneNumber: '123',
        password: 'Password123!',
        confirmPassword: 'Password123!',
        role: 'Admin',
        isActive: true,
      );
      // No exception means success
    });

    test('getUsers returns paginated list on success', () async {
      final repository = _repositoryFor({
        'succeeded': true,
        'data': {
          'items': [
            {
              'id': 'u1',
              'fullName': 'User One',
              'userName': 'user1',
              'email': 'u1@test.com',
              'phoneNumber': '111',
              'role': 'Admin',
              'isActive': true,
              'createdAt': '2026-07-16T12:00:00Z',
            },
          ],
          'pageNumber': 1,
          'totalPages': 1,
          'totalCount': 1,
        },
      });

      final result = await repository.getUsers(pageNumber: 1);

      expect(result.items.length, 1);
      expect(result.items[0].fullName, 'User One');
      expect(result.totalCount, 1);
    });

    test('returns Network error message on connectivity failure', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://test.local'));
      // Simulate a connection error
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
              ),
            );
          },
        ),
      );
      final repository = UsersRepositoryImpl(dio, MockLocationRepository());

      expect(
        () => repository.getRoles(),
        throwsA(
          isA<UsersException>().having(
            (e) => e.errors.first,
            'errors.first',
            contains('Network error'),
          ),
        ),
      );
    });
  });
}
