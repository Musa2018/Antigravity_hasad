import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:mobile/core/storage/database.dart';
import 'package:mobile/features/farmers/data/damage_report_attachment_repository.dart';
import 'package:mobile/features/farmers/data/damage_report_repository.dart';
import 'package:mobile/features/farmers/data/farm_repository.dart';
import 'package:mobile/features/farmers/data/farmer_repository.dart';
import 'package:mobile/features/farmers/domain/damage_item.dart' as item_domain;
import 'package:mobile/features/farmers/domain/damage_report.dart'
    as report_domain;
import 'package:mobile/features/farmers/domain/damage_report_attachment.dart'
    as attachment_domain;
import 'package:mobile/features/farmers/domain/farm.dart' as farm_domain;
import 'package:mobile/features/farmers/domain/farmer.dart' as domain;
import 'package:uuid/uuid.dart';

class BackgroundSyncService {
  final AppDatabase _db;
  final FarmerRepository _remoteFarmerRepository;
  final FarmRepository _remoteFarmRepository;
  final DamageReportRepository _remoteDamageReportRepository;
  final DamageReportAttachmentRepository _remoteAttachmentRepository;
  final Connectivity _connectivity;

  StreamSubscription? _connectivitySubscription;
  bool _isProcessing = false;

  BackgroundSyncService(
    this._db,
    this._remoteFarmerRepository,
    this._remoteFarmRepository,
    this._remoteDamageReportRepository,
    this._remoteAttachmentRepository,
    this._connectivity,
  ) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        processQueue();
      }
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }

  Future<void> addToQueue({
    required String localId,
    required String entityType,
    required String operation,
    required Map<String, dynamic> data,
  }) async {
    await _db
        .into(_db.syncQueue)
        .insert(
          SyncQueueCompanion.insert(
            id: const Uuid().v4(),
            localId: localId,
            entityType: entityType,
            operation: operation,
            data: jsonEncode(data),
            createdAt: Value(DateTime.now()),
          ),
        );
    processQueue();
  }

  Future<void> processQueue() async {
    if (_isProcessing) return;

    final connectivity = await _connectivity.checkConnectivity();
    if (connectivity.any((result) => result == ConnectivityResult.none)) return;

    _isProcessing = true;
    try {
      final now = DateTime.now();
      final pendingItems =
          await (_db.select(_db.syncQueue)
                ..where(
                  (t) => t.status.equals('pending') | t.status.equals('failed'),
                )
                ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
              .get();

      for (final item in pendingItems) {
        if (item.retryCount >= 3) continue;

        // Simple backoff: 0, 5, 15 minutes
        if (item.lastAttemptAt != null) {
          final waitMinutes = item.retryCount == 1
              ? 5
              : (item.retryCount == 2 ? 15 : 0);
          if (now.difference(item.lastAttemptAt!).inMinutes < waitMinutes) {
            continue;
          }
        }

        await _processItem(item);
      }
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _processItem(SyncQueueData item) async {
    final now = DateTime.now();
    try {
      await _db
          .update(_db.syncQueue)
          .replace(item.copyWith(status: 'syncing', lastAttemptAt: Value(now)));

      if (item.entityType == 'farmer') {
        await _syncFarmer(item);
      } else if (item.entityType == 'farm') {
        await _syncFarm(item);
      } else if (item.entityType == 'damage_report') {
        await _syncDamageReport(item);
      } else if (item.entityType == 'damage_item') {
        await _syncDamageItem(item);
      } else if (item.entityType == 'attachment') {
        await _syncAttachment(item);
      }

      await _db
          .update(_db.syncQueue)
          .replace(item.copyWith(status: 'completed'));
    } on FarmerException catch (e) {
      if (e.errors.any((err) => err.contains('CONFLICT'))) {
        await _db
            .update(_db.syncQueue)
            .replace(
              item.copyWith(status: 'conflict', lastError: Value(e.toString())),
            );
        await _resolveConflict(item);
      } else {
        await _db
            .update(_db.syncQueue)
            .replace(
              item.copyWith(
                status: 'failed',
                retryCount: item.retryCount + 1,
                lastError: Value(e.toString()),
              ),
            );
      }
    } on FarmException catch (e) {
      if (e.errors.any((err) => err.contains('CONFLICT'))) {
        await _db
            .update(_db.syncQueue)
            .replace(
              item.copyWith(status: 'conflict', lastError: Value(e.toString())),
            );
        await _resolveConflict(item);
      } else {
        await _db
            .update(_db.syncQueue)
            .replace(
              item.copyWith(
                status: 'failed',
                retryCount: item.retryCount + 1,
                lastError: Value(e.toString()),
              ),
            );
      }
    } on DamageReportException catch (e) {
      if (e.errors.any((err) => err.contains('CONFLICT'))) {
        await _db
            .update(_db.syncQueue)
            .replace(
              item.copyWith(status: 'conflict', lastError: Value(e.toString())),
            );
        await _resolveConflict(item);
      } else {
        await _db
            .update(_db.syncQueue)
            .replace(
              item.copyWith(
                status: 'failed',
                retryCount: item.retryCount + 1,
                lastError: Value(e.toString()),
              ),
            );
      }
    } catch (e) {
      await _db
          .update(_db.syncQueue)
          .replace(
            item.copyWith(
              status: 'failed',
              retryCount: item.retryCount + 1,
              lastError: Value(e.toString()),
            ),
          );
    }
  }

  Future<void> _syncAttachment(SyncQueueData item) async {
    final data = jsonDecode(item.data) as Map<String, dynamic>;
    final attachment = attachment_domain.DamageReportAttachment.fromJson(data);

    if (item.operation == 'upload') {
      final result = await _remoteAttachmentRepository.uploadAttachment(
        attachment,
      );
      await (_db.update(
        _db.damageReportAttachments,
      )..where((t) => t.id.equals(item.localId))).write(
        DamageReportAttachmentsCompanion(
          serverId: Value(result.id), // In this case clientId is Id on backend
          remotePath: Value(result.remotePath),
          uploadStatus: const Value('completed'),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'delete') {
      await _remoteAttachmentRepository.deleteAttachment(item.localId);
    }
  }

  Future<void> _syncFarmer(SyncQueueData item) async {
    final data = jsonDecode(item.data) as Map<String, dynamic>;
    final farmer = domain.Farmer.fromJson(data);

    if (item.operation == 'create') {
      final result = await _remoteFarmerRepository.createFarmer(farmer);
      await (_db.update(
        _db.farmers,
      )..where((t) => t.id.equals(item.localId))).write(
        FarmersCompanion(
          serverId: Value(result.id),
          rowVersion: Value(result.rowVersion),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'update') {
      final result = await _remoteFarmerRepository.updateFarmer(farmer);
      await (_db.update(
        _db.farmers,
      )..where((t) => t.id.equals(item.localId))).write(
        FarmersCompanion(
          rowVersion: Value(result.rowVersion),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'delete') {
      final localFarmer = await (_db.select(
        _db.farmers,
      )..where((t) => t.id.equals(item.localId))).getSingleOrNull();
      if (localFarmer?.serverId != null) {
        await _remoteFarmerRepository.deleteFarmer(localFarmer!.serverId!);
      }
    }
  }

  Future<void> _syncFarm(SyncQueueData item) async {
    final data = jsonDecode(item.data) as Map<String, dynamic>;
    final farm = farm_domain.Farm.fromJson(data);

    if (item.operation == 'create') {
      final result = await _remoteFarmRepository.createFarm(farm);
      await (_db.update(
        _db.farms,
      )..where((t) => t.id.equals(item.localId))).write(
        FarmsCompanion(
          serverId: Value(result.id),
          rowVersion: Value(result.rowVersion),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'update') {
      final result = await _remoteFarmRepository.updateFarm(farm);
      await (_db.update(
        _db.farms,
      )..where((t) => t.id.equals(item.localId))).write(
        FarmsCompanion(
          rowVersion: Value(result.rowVersion),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'delete') {
      final localFarm = await (_db.select(
        _db.farms,
      )..where((t) => t.id.equals(item.localId))).getSingleOrNull();
      if (localFarm?.serverId != null) {
        await _remoteFarmRepository.deleteFarm(localFarm!.serverId!);
      }
    }
  }

  Future<void> _syncDamageReport(SyncQueueData item) async {
    final data = jsonDecode(item.data) as Map<String, dynamic>;
    final report = report_domain.DamageReport.fromJson(data);

    if (item.operation == 'create') {
      final result = await _remoteDamageReportRepository.createDamageReport(
        report,
      );
      await _db.transaction(() async {
        await (_db.update(
          _db.damageReports,
        )..where((t) => t.id.equals(item.localId))).write(
          DamageReportsCompanion(
            serverId: Value(result.id),
            rowVersion: Value(result.rowVersion),
            syncStatus: const Value('completed'),
          ),
        );
        for (var i in result.items) {
          await (_db.update(
            _db.damageItems,
          )..where((t) => t.id.equals(i.id))).write(
            DamageItemsCompanion(
              serverId: Value(i.id),
              rowVersion: Value(i.rowVersion),
              syncStatus: const Value('completed'),
            ),
          );
        }
      });
    } else if (item.operation == 'update') {
      final result = await _remoteDamageReportRepository.updateDamageReport(
        report,
      );
      await (_db.update(
        _db.damageReports,
      )..where((t) => t.id.equals(item.localId))).write(
        DamageReportsCompanion(
          rowVersion: Value(result.rowVersion),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'delete') {
      final localReport = await (_db.select(
        _db.damageReports,
      )..where((t) => t.id.equals(item.localId))).getSingleOrNull();
      if (localReport?.serverId != null) {
        await _remoteDamageReportRepository.deleteDamageReport(
          localReport!.serverId!,
        );
      }
    }
  }

  Future<void> _syncDamageItem(SyncQueueData item) async {
    final data = jsonDecode(item.data) as Map<String, dynamic>;
    final damageItem = item_domain.DamageItem.fromJson(data);

    if (item.operation == 'create') {
      final result = await _remoteDamageReportRepository.addDamageItem(
        damageItem,
      );
      await (_db.update(
        _db.damageItems,
      )..where((t) => t.id.equals(item.localId))).write(
        DamageItemsCompanion(
          serverId: Value(result.id),
          rowVersion: Value(result.rowVersion),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'update') {
      final result = await _remoteDamageReportRepository.updateDamageItem(
        damageItem,
      );
      await (_db.update(
        _db.damageItems,
      )..where((t) => t.id.equals(item.localId))).write(
        DamageItemsCompanion(
          rowVersion: Value(result.rowVersion),
          syncStatus: const Value('completed'),
        ),
      );
    } else if (item.operation == 'delete') {
      final localItem = await (_db.select(
        _db.damageItems,
      )..where((t) => t.id.equals(item.localId))).getSingleOrNull();
      if (localItem?.serverId != null) {
        await _remoteDamageReportRepository.deleteDamageItem(
          localItem!.serverId!,
        );
      }
    }
  }

  Future<void> _resolveConflict(SyncQueueData item) async {
    if (item.entityType == 'farmer') {
      try {
        final localFarmer = await (_db.select(
          _db.farmers,
        )..where((t) => t.id.equals(item.localId))).getSingle();
        final remoteFarmer = await _remoteFarmerRepository.getFarmer(
          localFarmer.serverId ?? item.localId,
        );

        // Server Wins: Update local record with remote data
        await (_db.update(
          _db.farmers,
        )..where((t) => t.id.equals(item.localId))).write(
          FarmersCompanion(
            serverId: Value(remoteFarmer.serverId),
            idTypeId: Value(remoteFarmer.idTypeId),
            idNumber: Value(remoteFarmer.idNumber),
            firstNameAr: Value(remoteFarmer.firstNameAr),
            fatherNameAr: Value(remoteFarmer.fatherNameAr),
            grandfatherNameAr: Value(remoteFarmer.grandfatherNameAr),
            familyNameAr: Value(remoteFarmer.familyNameAr),
            firstNameEn: Value(remoteFarmer.firstNameEn),
            fatherNameEn: Value(remoteFarmer.fatherNameEn),
            grandfatherNameEn: Value(remoteFarmer.grandfatherNameEn),
            familyNameEn: Value(remoteFarmer.familyNameEn),
            birthDate: Value(remoteFarmer.birthDate),
            gender: Value(remoteFarmer.gender.index),
            phoneNumber: Value(remoteFarmer.phoneNumber),
            familySize: Value(remoteFarmer.familySize),
            governorateId: Value(remoteFarmer.governorateId),
            localityId: Value(remoteFarmer.localityId),
            address: Value(remoteFarmer.address),
            rowVersion: Value(remoteFarmer.rowVersion),
            updatedAt: Value(remoteFarmer.updatedAt),
            syncStatus: const Value('completed'),
          ),
        );

        await _db
            .update(_db.syncQueue)
            .replace(item.copyWith(status: 'completed'));
      } catch (e) {
        // Log failure to resolve
      }
    } else if (item.entityType == 'farm') {
      try {
        final localFarm = await (_db.select(
          _db.farms,
        )..where((t) => t.id.equals(item.localId))).getSingle();
        final remoteFarm = await _remoteFarmRepository.getFarm(
          localFarm.serverId ?? item.localId,
        );

        await (_db.update(
          _db.farms,
        )..where((t) => t.id.equals(item.localId))).write(
          FarmsCompanion(
            name: Value(remoteFarm.name),
            governorateId: Value(remoteFarm.governorateId),
            localityId: Value(remoteFarm.localityId),
            landArea: Value(remoteFarm.landArea),
            landAreaUnit: Value(remoteFarm.landAreaUnit),
            latitude: Value(remoteFarm.latitude),
            longitude: Value(remoteFarm.longitude),
            ownershipTypeId: Value(remoteFarm.ownershipTypeId),
            rowVersion: Value(remoteFarm.rowVersion),
            syncStatus: const Value('completed'),
          ),
        );

        await _db
            .update(_db.syncQueue)
            .replace(item.copyWith(status: 'completed'));
      } catch (e) {
        // Log
      }
    } else if (item.entityType == 'damage_report') {
      try {
        final localReport = await (_db.select(
          _db.damageReports,
        )..where((t) => t.id.equals(item.localId))).getSingle();
        final remoteReport = await _remoteDamageReportRepository
            .getDamageReport(localReport.serverId ?? item.localId);

        await _db.transaction(() async {
          await (_db.update(
            _db.damageReports,
          )..where((t) => t.id.equals(item.localId))).write(
            DamageReportsCompanion(
              damageDate: Value(remoteReport.damageDate),
              governorateId: Value(remoteReport.governorateId),
              localityId: Value(remoteReport.localityId),
              latitude: Value(remoteReport.latitude),
              longitude: Value(remoteReport.longitude),
              statusId: Value(remoteReport.statusId),
              notes: Value(remoteReport.notes),
              rowVersion: Value(remoteReport.rowVersion),
              syncStatus: const Value('completed'),
            ),
          );
          // Items might be complex to merge, overwrite local items with remote for "Server Wins"
          await (_db.delete(
            _db.damageItems,
          )..where((t) => t.damageReportId.equals(item.localId))).go();
          for (var ri in remoteReport.items) {
            await _db
                .into(_db.damageItems)
                .insert(
                  DamageItemsCompanion.insert(
                    id: ri.id,
                    damageReportId: item.localId,
                    agriculturalSectorId: ri.agriculturalSectorId,
                    subSectorId: ri.subSectorId,
                    cropId: ri.cropId,
                    damageTypeId: ri.damageTypeId,
                    affectedArea: ri.affectedArea,
                    damagePercentage: ri.damagePercentage,
                    quantity: ri.quantity,
                    estimatedLoss: ri.estimatedLoss,
                    rowVersion: Value(ri.rowVersion),
                    syncStatus: const Value('completed'),
                  ),
                );
          }
        });
        await _db
            .update(_db.syncQueue)
            .replace(item.copyWith(status: 'completed'));
      } catch (e) {
        // Log
      }
    } else if (item.entityType == 'damage_item') {
      try {
        final localItem = await (_db.select(
          _db.damageItems,
        )..where((t) => t.id.equals(item.localId))).getSingle();
        // Item get remote might need authority ID
        // Simplified: Fetch report and find item
        final remoteReport = await _remoteDamageReportRepository
            .getDamageReport(localItem.damageReportId);
        final remoteItem = remoteReport.items.firstWhere(
          (i) => i.id == localItem.serverId || i.id == localItem.id,
        );

        await (_db.update(
          _db.damageItems,
        )..where((t) => t.id.equals(item.localId))).write(
          DamageItemsCompanion(
            agriculturalSectorId: Value(remoteItem.agriculturalSectorId),
            subSectorId: Value(remoteItem.subSectorId),
            cropId: Value(remoteItem.cropId),
            damageTypeId: Value(remoteItem.damageTypeId),
            affectedArea: Value(remoteItem.affectedArea),
            damagePercentage: Value(remoteItem.damagePercentage),
            quantity: Value(remoteItem.quantity),
            estimatedLoss: Value(remoteItem.estimatedLoss),
            rowVersion: Value(remoteItem.rowVersion),
            syncStatus: const Value('completed'),
          ),
        );
        await _db
            .update(_db.syncQueue)
            .replace(item.copyWith(status: 'completed'));
      } catch (e) {
        // Log
      }
    }
  }
}
