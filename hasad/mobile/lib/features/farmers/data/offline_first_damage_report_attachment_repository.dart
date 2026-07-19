import 'package:drift/drift.dart';
import 'package:mobile/core/storage/background_sync_service.dart';
import 'package:mobile/core/storage/database.dart';
import 'package:mobile/features/farmers/data/damage_report_attachment_repository.dart';
import 'package:mobile/features/farmers/domain/damage_report_attachment.dart'
    as domain;
import 'package:uuid/uuid.dart';

class OfflineFirstDamageReportAttachmentRepository
    implements DamageReportAttachmentRepository {
  final AppDatabase _db;
  final BackgroundSyncService _syncService;

  OfflineFirstDamageReportAttachmentRepository(this._db, this._syncService);

  @override
  Future<domain.DamageReportAttachment> uploadAttachment(
    domain.DamageReportAttachment attachment,
  ) async {
    final localId = attachment.id.isEmpty ? const Uuid().v4() : attachment.id;

    await _db
        .into(_db.damageReportAttachments)
        .insert(
          DamageReportAttachmentsCompanion.insert(
            id: localId,
            damageReportId: attachment.damageReportId,
            localPath: attachment.localPath,
            uploadStatus: const Value('pending'),
            syncStatus: const Value('pending'),
          ),
        );

    final createdAttachment = attachment.copyWith(id: localId);

    await _syncService.addToQueue(
      localId: localId,
      entityType: 'attachment',
      operation: 'upload',
      data: createdAttachment.toJson(),
    );

    return createdAttachment;
  }

  @override
  Future<void> deleteAttachment(String id) async {
    await (_db.delete(
      _db.damageReportAttachments,
    )..where((t) => t.id.equals(id))).go();
    await _syncService.addToQueue(
      localId: id,
      entityType: 'attachment',
      operation: 'delete',
      data: {},
    );
  }

  @override
  Future<List<domain.DamageReportAttachment>> getAttachmentsByReport(
    String reportId,
  ) async {
    final items = await (_db.select(
      _db.damageReportAttachments,
    )..where((t) => t.damageReportId.equals(reportId))).get();

    return items
        .map(
          (e) => domain.DamageReportAttachment(
            id: e.id,
            damageReportId: e.damageReportId,
            localPath: e.localPath,
            remotePath: e.remotePath,
            uploadStatus: e.uploadStatus,
            syncStatus: e.syncStatus,
          ),
        )
        .toList();
  }
}
