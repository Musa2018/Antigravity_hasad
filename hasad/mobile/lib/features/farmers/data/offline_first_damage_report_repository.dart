import 'package:drift/drift.dart';
import 'package:mobile/core/storage/background_sync_service.dart';
import 'package:mobile/core/storage/database.dart';
import 'package:mobile/features/farmers/data/damage_report_repository.dart';
import 'package:mobile/features/farmers/domain/damage_item.dart' as domain;
import 'package:mobile/features/farmers/domain/damage_report.dart' as domain;
import 'package:uuid/uuid.dart';

class OfflineFirstDamageReportRepository implements DamageReportRepository {
  final AppDatabase _db;
  final BackgroundSyncService _syncService;

  OfflineFirstDamageReportRepository(this._db, this._syncService);

  @override
  Future<List<domain.DamageReport>> getDamageReportsByFarm(
    String farmId,
  ) async {
    final reports =
        await (_db.select(_db.damageReports)
              ..where((t) => t.farmId.equals(farmId))
              ..orderBy([(t) => OrderingTerm.desc(t.damageDate)]))
            .get();

    List<domain.DamageReport> results = [];
    for (var r in reports) {
      final items = await (_db.select(
        _db.damageItems,
      )..where((t) => t.damageReportId.equals(r.id))).get();

      results.add(
        domain.DamageReport(
          id: r.id,
          farmId: r.farmId,
          farmerId: r.farmerId,
          damageDate: r.damageDate,
          documentationDate: r.documentationDate,
          governorateId: r.governorateId,
          localityId: r.localityId,
          latitude: r.latitude,
          longitude: r.longitude,
          statusId: r.statusId,
          notes: r.notes,
          rowVersion: r.rowVersion,
          items: items
              .map(
                (i) => domain.DamageItem(
                  id: i.id,
                  damageReportId: i.damageReportId,
                  agriculturalSectorId: i.agriculturalSectorId,
                  subSectorId: i.subSectorId,
                  cropId: i.cropId,
                  damageTypeId: i.damageTypeId,
                  affectedArea: i.affectedArea,
                  damagePercentage: i.damagePercentage,
                  quantity: i.quantity,
                  estimatedLoss: i.estimatedLoss,
                  rowVersion: i.rowVersion,
                ),
              )
              .toList(),
        ),
      );
    }
    return results;
  }

  @override
  Future<domain.DamageReport> getDamageReport(String id) async {
    final r = await (_db.select(
      _db.damageReports,
    )..where((t) => t.id.equals(id))).getSingle();
    final items = await (_db.select(
      _db.damageItems,
    )..where((t) => t.damageReportId.equals(r.id))).get();

    return domain.DamageReport(
      id: r.id,
      farmId: r.farmId,
      farmerId: r.farmerId,
      damageDate: r.damageDate,
      documentationDate: r.documentationDate,
      governorateId: r.governorateId,
      localityId: r.localityId,
      latitude: r.latitude,
      longitude: r.longitude,
      statusId: r.statusId,
      notes: r.notes,
      rowVersion: r.rowVersion,
      items: items
          .map(
            (i) => domain.DamageItem(
              id: i.id,
              damageReportId: i.damageReportId,
              agriculturalSectorId: i.agriculturalSectorId,
              subSectorId: i.subSectorId,
              cropId: i.cropId,
              damageTypeId: i.damageTypeId,
              affectedArea: i.affectedArea,
              damagePercentage: i.damagePercentage,
              quantity: i.quantity,
              estimatedLoss: i.estimatedLoss,
              rowVersion: i.rowVersion,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<domain.DamageReport> createDamageReport(
    domain.DamageReport report,
  ) async {
    final localId = report.id.isEmpty ? const Uuid().v4() : report.id;

    await _db.transaction(() async {
      await _db
          .into(_db.damageReports)
          .insert(
            DamageReportsCompanion.insert(
              id: localId,
              farmId: report.farmId,
              farmerId: report.farmerId,
              damageDate: report.damageDate,
              documentationDate: report.documentationDate,
              governorateId: report.governorateId,
              localityId: report.localityId,
              latitude: Value(report.latitude),
              longitude: Value(report.longitude),
              statusId: report.statusId,
              notes: report.notes,
              syncStatus: const Value('pending'),
            ),
          );

      for (var item in report.items) {
        final itemId = item.id.isEmpty ? const Uuid().v4() : item.id;
        await _db
            .into(_db.damageItems)
            .insert(
              DamageItemsCompanion.insert(
                id: itemId,
                damageReportId: localId,
                agriculturalSectorId: item.agriculturalSectorId,
                subSectorId: item.subSectorId,
                cropId: item.cropId,
                damageTypeId: item.damageTypeId,
                affectedArea: item.affectedArea,
                damagePercentage: item.damagePercentage,
                quantity: item.quantity,
                estimatedLoss: item.estimatedLoss,
                syncStatus: const Value('pending'),
              ),
            );
      }
    });

    final createdReport = report.copyWith(
      id: localId,
      items: report.items
          .map((e) => e.copyWith(damageReportId: localId))
          .toList(),
    );

    await _syncService.addToQueue(
      localId: localId,
      entityType: 'damage_report',
      operation: 'create',
      data: createdReport.toJson(),
    );

    return createdReport;
  }

  @override
  Future<domain.DamageReport> updateDamageReport(
    domain.DamageReport report,
  ) async {
    await (_db.update(
      _db.damageReports,
    )..where((t) => t.id.equals(report.id))).write(
      DamageReportsCompanion(
        damageDate: Value(report.damageDate),
        governorateId: Value(report.governorateId),
        localityId: Value(report.localityId),
        latitude: Value(report.latitude),
        longitude: Value(report.longitude),
        notes: Value(report.notes),
        syncStatus: const Value('pending'),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await _syncService.addToQueue(
      localId: report.id,
      entityType: 'damage_report',
      operation: 'update',
      data: report.toJson(),
    );

    return report;
  }

  @override
  Future<void> deleteDamageReport(String id) async {
    await (_db.delete(_db.damageReports)..where((t) => t.id.equals(id))).go();
    await _syncService.addToQueue(
      localId: id,
      entityType: 'damage_report',
      operation: 'delete',
      data: {},
    );
  }

  @override
  Future<domain.DamageItem> addDamageItem(domain.DamageItem item) async {
    final localId = item.id.isEmpty ? const Uuid().v4() : item.id;
    await _db
        .into(_db.damageItems)
        .insert(
          DamageItemsCompanion.insert(
            id: localId,
            damageReportId: item.damageReportId,
            agriculturalSectorId: item.agriculturalSectorId,
            subSectorId: item.subSectorId,
            cropId: item.cropId,
            damageTypeId: item.damageTypeId,
            affectedArea: item.affectedArea,
            damagePercentage: item.damagePercentage,
            quantity: item.quantity,
            estimatedLoss: item.estimatedLoss,
            syncStatus: const Value('pending'),
          ),
        );

    final createdItem = item.copyWith(id: localId);

    await _syncService.addToQueue(
      localId: localId,
      entityType: 'damage_item',
      operation: 'create',
      data: createdItem.toJson(),
    );

    return createdItem;
  }

  @override
  Future<domain.DamageItem> updateDamageItem(domain.DamageItem item) async {
    await (_db.update(
      _db.damageItems,
    )..where((t) => t.id.equals(item.id))).write(
      DamageItemsCompanion(
        agriculturalSectorId: Value(item.agriculturalSectorId),
        subSectorId: Value(item.subSectorId),
        cropId: Value(item.cropId),
        damageTypeId: Value(item.damageTypeId),
        affectedArea: Value(item.affectedArea),
        damagePercentage: Value(item.damagePercentage),
        quantity: Value(item.quantity),
        estimatedLoss: Value(item.estimatedLoss),
        syncStatus: const Value('pending'),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await _syncService.addToQueue(
      localId: item.id,
      entityType: 'damage_item',
      operation: 'update',
      data: item.toJson(),
    );

    return item;
  }

  @override
  Future<void> deleteDamageItem(String id) async {
    await (_db.delete(_db.damageItems)..where((t) => t.id.equals(id))).go();
    await _syncService.addToQueue(
      localId: id,
      entityType: 'damage_item',
      operation: 'delete',
      data: {},
    );
  }
}
