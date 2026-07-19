import 'package:dio/dio.dart';
import 'package:mobile/features/location/domain/directorate.dart';
import 'package:mobile/features/location/domain/governorate.dart';
import 'package:mobile/features/location/domain/locality.dart';

abstract class LocationRepository {
  Future<List<Governorate>> getGovernorates();
  Future<List<Directorate>> getDirectorates({String? governorateId});
  Future<List<Locality>> getLocalities({String? governorateId});
}

class LocationRepositoryImpl implements LocationRepository {
  final Dio _dio;

  LocationRepositoryImpl(this._dio);

  @override
  Future<List<Governorate>> getGovernorates() async {
    return _getMany(
      '/v1/Location/governorates',
      (json) => Governorate.fromJson(json),
    );
  }

  @override
  Future<List<Directorate>> getDirectorates({String? governorateId}) async {
    return _getMany(
      '/v1/Users/directorates',
      (json) => Directorate.fromJson(json),
      queryParameters: governorateId != null ? {'governorateId': governorateId} : null,
    );
  }

  @override
  Future<List<Locality>> getLocalities({String? governorateId}) async {
    return _getMany(
      '/v1/Location/localities',
      (json) => Locality.fromJson(json),
      queryParameters: governorateId != null ? {'governorateId': governorateId} : null,
    );
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
        throw Exception('Failed to load location data.');
      }

      return data.map((json) => fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data['errors'] is List) {
        throw Exception((data['errors'] as List).join('\n'));
      }
      throw Exception('Network error: Please check your internet connection.');
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }
}
