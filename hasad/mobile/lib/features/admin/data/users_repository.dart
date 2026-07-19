import 'package:dio/dio.dart';
import 'package:mobile/features/admin/domain/role.dart';
import 'package:mobile/features/admin/domain/user.dart';
import 'package:mobile/features/location/data/location_repository.dart';
import 'package:mobile/features/location/domain/directorate.dart';
import 'package:mobile/features/location/domain/governorate.dart';
import 'package:mobile/shared/domain/paginated_list.dart';

class UsersException implements Exception {
  final List<String> errors;
  UsersException(this.errors);

  @override
  String toString() =>
      errors.isEmpty ? 'User management operation failed.' : errors.join('\n');
}

abstract class UsersRepository {
  Future<PaginatedList<User>> getUsers({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    String? role,
    String? governorateId,
    String? directorateId,
    bool? isActive,
  });
  Future<List<Role>> getRoles();
  Future<List<Governorate>> getGovernorates();
  Future<List<Directorate>> getDirectorates({String? governorateId});
  Future<void> createUser({
    required String fullName,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String role,
    String? governorateId,
    String? directorateId,
    required bool isActive,
  });
  Future<void> updateUser({
    required String id,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String role,
    String? governorateId,
    String? directorateId,
    required bool isActive,
  });
  Future<void> resetPassword({
    required String userId,
    required String newPassword,
    required String confirmPassword,
  });
  Future<void> changeStatus({required String userId, required bool isActive});
}

class UsersRepositoryImpl implements UsersRepository {
  final Dio _dio;
  final LocationRepository _locationRepository;

  UsersRepositoryImpl(this._dio, this._locationRepository);

  @override
  Future<PaginatedList<User>> getUsers({
    int pageNumber = 1,
    int pageSize = 10,
    String? search,
    String? role,
    String? governorateId,
    String? directorateId,
    bool? isActive,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/Users',
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
          'search': search,
          'role': role,
          'governorateId': governorateId,
          'directorateId': directorateId,
          'isActive': isActive,
        }..removeWhere((key, value) => value == null),
      );
      final envelope = response.data;
      final data = envelope?['data'];

      if (envelope?['succeeded'] != true || data == null) {
        throw UsersException(_errorsFromEnvelope(envelope));
      }

      return PaginatedList<User>.fromJson(
        data as Map<String, dynamic>,
        (json) => User.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw UsersException(_errorsFromDio(e));
    }
  }

  @override
  Future<List<Role>> getRoles() async {
    return _getMany('/v1/Users/roles', (json) => Role.fromJson(json));
  }

  @override
  Future<List<Governorate>> getGovernorates() async {
    return _locationRepository.getGovernorates();
  }

  @override
  Future<List<Directorate>> getDirectorates({String? governorateId}) async {
    return _locationRepository.getDirectorates(governorateId: governorateId);
  }

  @override
  Future<void> createUser({
    required String fullName,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String role,
    String? governorateId,
    String? directorateId,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/Users',
        data: {
          'fullName': fullName,
          'userName': userName,
          'email': email,
          'phoneNumber': phoneNumber,
          'password': password,
          'confirmPassword': confirmPassword,
          'role': role,
          'governorateId': governorateId,
          'directorateId': directorateId,
          'isActive': isActive,
        },
      );
      final envelope = response.data;
      if (envelope?['succeeded'] != true) {
        throw UsersException(_errorsFromEnvelope(envelope));
      }
    } on DioException catch (e) {
      throw UsersException(_errorsFromDio(e));
    }
  }

  @override
  Future<void> updateUser({
    required String id,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String role,
    String? governorateId,
    String? directorateId,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/v1/Users/$id',
        data: {
          'id': id,
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNumber,
          'role': role,
          'governorateId': governorateId,
          'directorateId': directorateId,
          'isActive': isActive,
        },
      );
      final envelope = response.data;
      if (envelope?['succeeded'] != true) {
        throw UsersException(_errorsFromEnvelope(envelope));
      }
    } on DioException catch (e) {
      throw UsersException(_errorsFromDio(e));
    }
  }

  @override
  Future<void> resetPassword({
    required String userId,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/Users/$userId/reset-password',
        data: {
          'userId': userId,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      );
      final envelope = response.data;
      if (envelope?['succeeded'] != true) {
        throw UsersException(_errorsFromEnvelope(envelope));
      }
    } on DioException catch (e) {
      throw UsersException(_errorsFromDio(e));
    }
  }

  @override
  Future<void> changeStatus({
    required String userId,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/v1/Users/$userId/status',
        data: {'userId': userId, 'isActive': isActive},
      );
      final envelope = response.data;
      if (envelope?['succeeded'] != true) {
        throw UsersException(_errorsFromEnvelope(envelope));
      }
    } on DioException catch (e) {
      throw UsersException(_errorsFromDio(e));
    }
  }

  Future<List<T>> _getMany<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      final envelope = response.data;
      final data = envelope?['data'];

      if (envelope?['succeeded'] != true || data is! List) {
        throw UsersException(_errorsFromEnvelope(envelope));
      }

      return data
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw UsersException(_errorsFromDio(e));
    }
  }

  List<String> _errorsFromDio(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ['Network error: Please check your internet connection.'];
    }

    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return _errorsFromEnvelope(data);
    }
    return [];
  }

  List<String> _errorsFromEnvelope(Map<String, dynamic>? envelope) {
    if (envelope == null) return [];
    final errors = envelope['errors'];
    if (errors is List) {
      return errors.whereType<String>().toList();
    }
    return [];
  }
}
