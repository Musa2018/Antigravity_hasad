import 'package:dio/dio.dart';
import 'package:mobile/features/farmers/data/farm_repository.dart';
import 'package:mobile/features/farmers/domain/farm.dart';

class RemoteFarmRepository implements FarmRepository {
  final Dio _dio;

  RemoteFarmRepository(this._dio);

  @override
  Future<List<Farm>> getFarmsByFarmer(String farmerId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/farms/farmer/$farmerId',
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw FarmException(_errorsFromEnvelope(envelope));
      }
      final items = data as List;
      return items
          .map((e) => Farm.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw FarmException(_errorsFromDio(e));
    }
  }

  @override
  Future<Farm> getFarm(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/v1/farms/$id');
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw FarmException(_errorsFromEnvelope(envelope));
      }
      return Farm.fromJson(data);
    } on DioException catch (e) {
      throw FarmException(_errorsFromDio(e));
    }
  }

  @override
  Future<Farm> createFarm(Farm farm) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/farms',
        data: {
          'clientId': farm.id,
          'farmerId': farm.farmerId,
          'name': farm.name,
          'governorateId': farm.governorateId,
          'localityId': farm.localityId,
          'landArea': farm.landArea,
          'landAreaUnit': farm.landAreaUnit,
          'latitude': farm.latitude,
          'longitude': farm.longitude,
          'ownershipTypeId': farm.ownershipTypeId,
        },
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw FarmException(_errorsFromEnvelope(envelope));
      }
      return Farm.fromJson(data);
    } on DioException catch (e) {
      throw FarmException(_errorsFromDio(e));
    }
  }

  @override
  Future<Farm> updateFarm(Farm farm) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/v1/farms/${farm.id}',
        data: {
          'id': farm.id,
          'clientId': farm.id,
          'farmerId': farm.farmerId,
          'name': farm.name,
          'governorateId': farm.governorateId,
          'localityId': farm.localityId,
          'landArea': farm.landArea,
          'landAreaUnit': farm.landAreaUnit,
          'latitude': farm.latitude,
          'longitude': farm.longitude,
          'ownershipTypeId': farm.ownershipTypeId,
          'rowVersion': farm.rowVersion,
        },
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw FarmException(_errorsFromEnvelope(envelope));
      }
      return Farm.fromJson(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw FarmException([
          'CONFLICT: The record has been modified by another user.',
        ]);
      }
      throw FarmException(_errorsFromDio(e));
    }
  }

  @override
  Future<void> deleteFarm(String id) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>('/v1/farms/$id');
      final envelope = response.data;
      if (envelope?['succeeded'] != true) {
        throw FarmException(_errorsFromEnvelope(envelope));
      }
    } on DioException catch (e) {
      throw FarmException(_errorsFromDio(e));
    }
  }

  List<String> _errorsFromDio(DioException e) {
    final body = e.response?.data;
    if (body is Map<String, dynamic>) {
      return _errorsFromEnvelope(body);
    }
    return const [];
  }

  List<String> _errorsFromEnvelope(Map<String, dynamic>? envelope) {
    final errors = envelope?['errors'];
    if (errors is List) {
      return errors.whereType<String>().toList();
    }
    return const [];
  }
}
