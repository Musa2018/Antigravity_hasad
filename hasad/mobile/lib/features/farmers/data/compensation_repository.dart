import 'package:dio/dio.dart';
import 'package:mobile/features/farmers/domain/compensation.dart';

abstract class CompensationRepository {
  Future<Compensation?> getByReportId(String reportId);
  Future<Compensation> create(String reportId, String remarks);
  Future<Compensation> recalculate(String id, String rowVersion);
  Future<Compensation> submit(String id, String rowVersion);
  Future<Compensation> approve(
    String id,
    double amount,
    String remarks,
    String rowVersion,
  );
  Future<Compensation> reject(String id, String remarks, String rowVersion);
  Future<Compensation> markAsPaid(String id, String remarks, String rowVersion);
}

class CompensationRepositoryImpl implements CompensationRepository {
  final Dio _dio;

  CompensationRepositoryImpl(this._dio);

  @override
  Future<Compensation?> getByReportId(String reportId) async {
    final response = await _dio.get('/v1/compensations/report/$reportId');
    if (response.data == null || response.data['data'] == null) {
      return null;
    }
    return Compensation.fromJson(response.data['data']);
  }

  @override
  Future<Compensation> create(String reportId, String remarks) async {
    final response = await _dio.post(
      '/v1/compensations',
      data: {
        'clientId': DateTime.now().toIso8601String(),
        'damageReportId': reportId,
        'remarks': remarks,
      },
    );
    return Compensation.fromJson(response.data['data']);
  }

  @override
  Future<Compensation> recalculate(String id, String rowVersion) async {
    final response = await _dio.post(
      '/v1/compensations/$id/recalculate',
      data: {'id': id, 'rowVersion': rowVersion},
    );
    return Compensation.fromJson(response.data['data']);
  }

  @override
  Future<Compensation> submit(String id, String rowVersion) async {
    final response = await _dio.post(
      '/v1/compensations/$id/submit',
      data: {'id': id, 'rowVersion': rowVersion},
    );
    return Compensation.fromJson(response.data['data']);
  }

  @override
  Future<Compensation> approve(
    String id,
    double amount,
    String remarks,
    String rowVersion,
  ) async {
    final response = await _dio.post(
      '/v1/compensations/$id/approve',
      data: {
        'id': id,
        'approvedAmount': amount,
        'remarks': remarks,
        'rowVersion': rowVersion,
      },
    );
    return Compensation.fromJson(response.data['data']);
  }

  @override
  Future<Compensation> reject(
    String id,
    String remarks,
    String rowVersion,
  ) async {
    final response = await _dio.post(
      '/v1/compensations/$id/reject',
      data: {'id': id, 'remarks': remarks, 'rowVersion': rowVersion},
    );
    return Compensation.fromJson(response.data['data']);
  }

  @override
  Future<Compensation> markAsPaid(
    String id,
    String remarks,
    String rowVersion,
  ) async {
    final response = await _dio.post(
      '/v1/compensations/$id/pay',
      data: {'id': id, 'remarks': remarks, 'rowVersion': rowVersion},
    );
    return Compensation.fromJson(response.data['data']);
  }
}
