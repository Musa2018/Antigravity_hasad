import 'package:dio/dio.dart';
import 'package:mobile/features/farmers/data/damage_report_repository.dart';
import 'package:mobile/features/farmers/domain/damage_item.dart';
import 'package:mobile/features/farmers/domain/damage_report.dart';

class RemoteDamageReportRepository implements DamageReportRepository {
  final Dio _dio;

  RemoteDamageReportRepository(this._dio);

  @override
  Future<List<DamageReport>> getDamageReportsByFarm(String farmId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/damage-reports/farm/$farmId',
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw DamageReportException(_errorsFromEnvelope(envelope));
      }
      final items = data as List;
      return items
          .map((e) => DamageReport.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw DamageReportException(_errorsFromDio(e));
    }
  }

  @override
  Future<DamageReport> getDamageReport(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/v1/damage-reports/$id',
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw DamageReportException(_errorsFromEnvelope(envelope));
      }
      return DamageReport.fromJson(data);
    } on DioException catch (e) {
      throw DamageReportException(_errorsFromDio(e));
    }
  }

  @override
  Future<DamageReport> createDamageReport(DamageReport report) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/damage-reports',
        data: {
          'clientId': report.id,
          'farmId': report.farmId,
          'farmerId': report.farmerId,
          'damageDate': report.damageDate.toIso8601String(),
          'governorateId': report.governorateId,
          'localityId': report.localityId,
          'latitude': report.latitude,
          'longitude': report.longitude,
          'notes': report.notes,
          'items': report.items
              .map(
                (i) => {
                  'clientId': i.id,
                  'agriculturalSectorId': i.agriculturalSectorId,
                  'subSectorId': i.subSectorId,
                  'cropId': i.cropId,
                  'damageTypeId': i.damageTypeId,
                  'affectedArea': i.affectedArea,
                  'damagePercentage': i.damagePercentage,
                  'quantity': i.quantity,
                  'estimatedLoss': i.estimatedLoss,
                },
              )
              .toList(),
        },
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw DamageReportException(_errorsFromEnvelope(envelope));
      }
      return DamageReport.fromJson(data);
    } on DioException catch (e) {
      throw DamageReportException(_errorsFromDio(e));
    }
  }

  @override
  Future<DamageReport> updateDamageReport(DamageReport report) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/v1/damage-reports/${report.id}',
        data: {
          'id': report.id,
          'damageDate': report.damageDate.toIso8601String(),
          'governorateId': report.governorateId,
          'localityId': report.localityId,
          'latitude': report.latitude,
          'longitude': report.longitude,
          'notes': report.notes,
          'rowVersion': report.rowVersion,
        },
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw DamageReportException(_errorsFromEnvelope(envelope));
      }
      return DamageReport.fromJson(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw DamageReportException([
          'CONFLICT: The record has been modified by another user.',
        ]);
      }
      throw DamageReportException(_errorsFromDio(e));
    }
  }

  @override
  Future<void> deleteDamageReport(String id) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/v1/damage-reports/$id',
      );
      if (response.data?['succeeded'] != true) {
        throw DamageReportException(_errorsFromEnvelope(response.data));
      }
    } on DioException catch (e) {
      throw DamageReportException(_errorsFromDio(e));
    }
  }

  @override
  Future<DamageItem> addDamageItem(DamageItem item) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/damage-reports/${item.damageReportId}/items',
        data: {
          'damageReportId': item.damageReportId,
          'clientId': item.id,
          'agriculturalSectorId': item.agriculturalSectorId,
          'subSectorId': item.subSectorId,
          'cropId': item.cropId,
          'damageTypeId': item.damageTypeId,
          'affectedArea': item.affectedArea,
          'damagePercentage': item.damagePercentage,
          'quantity': item.quantity,
          'estimatedLoss': item.estimatedLoss,
        },
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw DamageReportException(_errorsFromEnvelope(envelope));
      }
      return DamageItem.fromJson(data);
    } on DioException catch (e) {
      throw DamageReportException(_errorsFromDio(e));
    }
  }

  @override
  Future<DamageItem> updateDamageItem(DamageItem item) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/v1/damage-reports/items/${item.id}',
        data: {
          'id': item.id,
          'agriculturalSectorId': item.agriculturalSectorId,
          'subSectorId': item.subSectorId,
          'cropId': item.cropId,
          'damageTypeId': item.damageTypeId,
          'affectedArea': item.affectedArea,
          'damagePercentage': item.damagePercentage,
          'quantity': item.quantity,
          'estimatedLoss': item.estimatedLoss,
          'rowVersion': item.rowVersion,
        },
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw DamageReportException(_errorsFromEnvelope(envelope));
      }
      return DamageItem.fromJson(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw DamageReportException([
          'CONFLICT: The record has been modified by another user.',
        ]);
      }
      throw DamageReportException(_errorsFromDio(e));
    }
  }

  @override
  Future<void> deleteDamageItem(String id) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '/v1/damage-reports/items/$id',
      );
      if (response.data?['succeeded'] != true) {
        throw DamageReportException(_errorsFromEnvelope(response.data));
      }
    } on DioException catch (e) {
      throw DamageReportException(_errorsFromDio(e));
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
