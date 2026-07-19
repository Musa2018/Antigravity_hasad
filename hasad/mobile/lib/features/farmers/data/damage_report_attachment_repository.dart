import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mobile/features/farmers/domain/damage_report_attachment.dart';
import 'package:path/path.dart' as p_path;

abstract class DamageReportAttachmentRepository {
  Future<DamageReportAttachment> uploadAttachment(
    DamageReportAttachment attachment,
  );
  Future<void> deleteAttachment(String id);
  Future<List<DamageReportAttachment>> getAttachmentsByReport(String reportId);
}

class RemoteDamageReportAttachmentRepository
    implements DamageReportAttachmentRepository {
  final Dio _dio;

  RemoteDamageReportAttachmentRepository(this._dio);

  @override
  Future<DamageReportAttachment> uploadAttachment(
    DamageReportAttachment attachment,
  ) async {
    final file = File(attachment.localPath);
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: p_path.basename(file.path),
      ),
      'clientId': attachment.id,
    });

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/v1/damage-reports/${attachment.damageReportId}/attachments',
        data: formData,
      );
      final envelope = response.data;
      final data = envelope?['data'];
      if (envelope?['succeeded'] != true || data == null) {
        throw Exception('Upload failed');
      }
      return DamageReportAttachment(
        id: data['clientId'],
        damageReportId: attachment.damageReportId,
        localPath: attachment.localPath,
        remotePath: data['remoteUrl'],
        uploadStatus: 'completed',
      );
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }

  @override
  Future<void> deleteAttachment(String id) async {
    await _dio.delete('/v1/attachments/$id');
  }

  @override
  Future<List<DamageReportAttachment>> getAttachmentsByReport(
    String reportId,
  ) async {
    return [];
  }
}
