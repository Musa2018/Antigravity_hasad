import 'package:drift/drift.dart';
import 'package:mobile/core/storage/background_sync_service.dart';
import 'package:mobile/core/storage/database.dart';
import 'package:mobile/features/farmers/data/farm_repository.dart';
import 'package:mobile/features/farmers/domain/farm.dart' as domain;
import 'package:uuid/uuid.dart';

class OfflineFirstFarmRepository implements FarmRepository {
  final AppDatabase _db;
  final BackgroundSyncService _syncService;

  OfflineFirstFarmRepository(this._db, this._syncService);

  @override
  Future<List<domain.Farm>> getFarmsByFarmer(String farmerId) async {
    final items =
        await (_db.select(_db.farms)
              ..where((t) => t.farmerId.equals(farmerId))
              ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
            .get();

    return items
        .map(
          (e) => domain.Farm(
            id: e.id,
            farmerId: e.farmerId,
            name: e.name,
            governorateId: e.governorateId,
            localityId: e.localityId,
            landArea: e.landArea,
            landAreaUnit: e.landAreaUnit,
            latitude: e.latitude,
            longitude: e.longitude,
            ownershipTypeId: e.ownershipTypeId,
            rowVersion: e.rowVersion,
          ),
        )
        .toList();
  }

  @override
  Future<domain.Farm> getFarm(String id) async {
    final e = await (_db.select(
      _db.farms,
    )..where((t) => t.id.equals(id))).getSingle();
    return domain.Farm(
      id: e.id,
      farmerId: e.farmerId,
      name: e.name,
      governorateId: e.governorateId,
      localityId: e.localityId,
      landArea: e.landArea,
      landAreaUnit: e.landAreaUnit,
      latitude: e.latitude,
      longitude: e.longitude,
      ownershipTypeId: e.ownershipTypeId,
      rowVersion: e.rowVersion,
    );
  }

  @override
  Future<domain.Farm> createFarm(domain.Farm farm) async {
    final localId = farm.id.isEmpty ? const Uuid().v4() : farm.id;
    final companion = FarmsCompanion.insert(
      id: localId,
      farmerId: farm.farmerId,
      name: farm.name,
      governorateId: farm.governorateId,
      localityId: farm.localityId,
      landArea: farm.landArea,
      landAreaUnit: farm.landAreaUnit,
      latitude: Value(farm.latitude),
      longitude: Value(farm.longitude),
      ownershipTypeId: farm.ownershipTypeId,
      rowVersion: Value(farm.rowVersion),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.farms).insert(companion);

    final createdFarm = farm.copyWith(id: localId);

    await _syncService.addToQueue(
      localId: localId,
      entityType: 'farm',
      operation: 'create',
      data: createdFarm.toJson(),
    );

    return createdFarm;
  }

  @override
  Future<domain.Farm> updateFarm(domain.Farm farm) async {
    await (_db.update(_db.farms)..where((t) => t.id.equals(farm.id))).write(
      FarmsCompanion(
        name: Value(farm.name),
        governorateId: Value(farm.governorateId),
        localityId: Value(farm.localityId),
        landArea: Value(farm.landArea),
        landAreaUnit: Value(farm.landAreaUnit),
        latitude: Value(farm.latitude),
        longitude: Value(farm.longitude),
        ownershipTypeId: Value(farm.ownershipTypeId),
        rowVersion: Value(farm.rowVersion),
        syncStatus: const Value('pending'),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await _syncService.addToQueue(
      localId: farm.id,
      entityType: 'farm',
      operation: 'update',
      data: farm.toJson(),
    );

    return farm;
  }

  @override
  Future<void> deleteFarm(String id) async {
    await (_db.delete(_db.farms)..where((t) => t.id.equals(id))).go();

    await _syncService.addToQueue(
      localId: id,
      entityType: 'farm',
      operation: 'delete',
      data: {},
    );
  }
}
