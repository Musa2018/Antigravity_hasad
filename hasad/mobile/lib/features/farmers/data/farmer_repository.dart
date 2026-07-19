import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:mobile/core/storage/background_sync_service.dart';
import 'package:mobile/core/storage/database.dart';
import 'package:mobile/features/farmers/domain/farmer.dart' as domain;
import 'package:mobile/features/farmers/domain/gender.dart';
import 'package:uuid/uuid.dart';

class FarmerException implements Exception {
  final List<String> errors;
  FarmerException(this.errors);
  @override
  String toString() =>
      errors.isEmpty ? 'An error occurred.' : errors.join('\n');
}

abstract class FarmerRepository {
  Future<List<domain.Farmer>> getFarmers({
    int pageNumber = 1,
    int pageSize = 10,
    String? idNumber,
    String? name,
  });
  Future<domain.Farmer?> findByIdNumber(String idNumber);
  Future<domain.Farmer> getFarmer(String id);
  Future<domain.Farmer> createFarmer(domain.Farmer farmer);
  Future<domain.Farmer> updateFarmer(domain.Farmer farmer);
  Future<void> deleteFarmer(String id);
}

class OfflineFirstFarmerRepository implements FarmerRepository {
  final AppDatabase _db;
  final BackgroundSyncService _syncService;
  final FarmerRepository _remoteRepository;
  final Connectivity _connectivity;

  OfflineFirstFarmerRepository(
    this._db,
    this._syncService,
    this._remoteRepository,
    this._connectivity,
  );

  @override
  Future<List<domain.Farmer>> getFarmers({
    int pageNumber = 1,
    int pageSize = 10,
    String? idNumber,
    String? name,
  }) async {
    // For the list, we currently only show local data or we could merge.
    // For Sprint 10.4, we focus on searchById.
    final query = _db.select(_db.farmers)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(pageSize, offset: (pageNumber - 1) * pageSize);

    if (idNumber != null && idNumber.isNotEmpty) {
      query.where((t) => t.idNumber.contains(idNumber));
    }

    // Simplification: name search is complex across 8 fields,
    // but we can implement basic contains if needed.
    // For now, let's just use the existing ordering.

    final items = await query.get();

    return items.map(_mapToDomain).toList();
  }

  @override
  Future<domain.Farmer?> findByIdNumber(String idNumber) async {
    // 1. Search local Drift database first
    final local = await (_db.select(
      _db.farmers,
    )..where((t) => t.idNumber.equals(idNumber))).getSingleOrNull();

    if (local != null) {
      return _mapToDomain(local);
    }

    // 2. If not found locally, check connectivity
    final connectivity = await _connectivity.checkConnectivity();
    final isOnline =
        connectivity.isNotEmpty &&
        !connectivity.contains(ConnectivityResult.none);

    if (isOnline) {
      // 3. Search backend
      try {
        final remote = await _remoteRepository.findByIdNumber(idNumber);
        if (remote != null) {
          // 4. Save/update local database if found remotely
          // We use ClientId (remote.id or remote.clientId) as local 'id'
          final companion = _mapToCompanion(
            remote,
          ).copyWith(syncStatus: const Value('completed'));

          await _db.into(_db.farmers).insertOnConflictUpdate(companion);
          return remote;
        }
      } catch (e) {
        // Log or handle error (e.g. timeout)
      }
    }

    return null;
  }

  @override
  Future<domain.Farmer> getFarmer(String id) async {
    final e = await (_db.select(
      _db.farmers,
    )..where((t) => t.id.equals(id))).getSingle();
    return _mapToDomain(e);
  }

  domain.Farmer _mapToDomain(FarmerLocal e) {
    return domain.Farmer(
      id: e.id,
      serverId: e.serverId,
      clientId: e.id,
      idTypeId: e.idTypeId,
      idNumber: e.idNumber,
      firstNameAr: e.firstNameAr,
      fatherNameAr: e.fatherNameAr,
      grandfatherNameAr: e.grandfatherNameAr,
      familyNameAr: e.familyNameAr,
      firstNameEn: e.firstNameEn,
      fatherNameEn: e.fatherNameEn,
      grandfatherNameEn: e.grandfatherNameEn,
      familyNameEn: e.familyNameEn,
      birthDate: e.birthDate ?? DateTime(1900),
      gender: Gender.values[e.gender],
      phoneNumber: e.phoneNumber,
      familySize: e.familySize,
      governorateId: e.governorateId,
      localityId: e.localityId,
      address: e.address,
      rowVersion: e.rowVersion,
      syncStatus: e.syncStatus,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }

  FarmersCompanion _mapToCompanion(domain.Farmer farmer) {
    return FarmersCompanion.insert(
      id: farmer.id,
      serverId: Value(farmer.serverId),
      idTypeId: Value(farmer.idTypeId),
      idNumber: Value(farmer.idNumber),
      firstNameAr: Value(farmer.firstNameAr),
      fatherNameAr: Value(farmer.fatherNameAr),
      grandfatherNameAr: Value(farmer.grandfatherNameAr),
      familyNameAr: Value(farmer.familyNameAr),
      firstNameEn: Value(farmer.firstNameEn),
      fatherNameEn: Value(farmer.fatherNameEn),
      grandfatherNameEn: Value(farmer.grandfatherNameEn),
      familyNameEn: Value(farmer.familyNameEn),
      birthDate: Value(farmer.birthDate),
      gender: Value(farmer.gender.index),
      phoneNumber: Value(farmer.phoneNumber),
      familySize: Value(farmer.familySize),
      governorateId: Value(farmer.governorateId),
      localityId: Value(farmer.localityId),
      address: Value(farmer.address),
      rowVersion: Value(farmer.rowVersion),
      updatedAt: Value(farmer.updatedAt),
    );
  }

  @override
  Future<domain.Farmer> createFarmer(domain.Farmer farmer) async {
    final localId = farmer.id.isEmpty ? const Uuid().v4() : farmer.id;
    final companion = _mapToCompanion(
      farmer,
    ).copyWith(id: Value(localId), syncStatus: const Value('pending'));

    await _db.into(_db.farmers).insert(companion);

    final createdFarmer = farmer.copyWith(id: localId, clientId: localId);

    await _syncService.addToQueue(
      localId: localId,
      entityType: 'farmer',
      operation: 'create',
      data: createdFarmer.toJson(),
    );

    return createdFarmer;
  }

  @override
  Future<domain.Farmer> updateFarmer(domain.Farmer farmer) async {
    final companion = _mapToCompanion(farmer).copyWith(
      updatedAt: Value(DateTime.now()),
      syncStatus: const Value('pending'),
    );

    await (_db.update(
      _db.farmers,
    )..where((t) => t.id.equals(farmer.id))).write(companion);

    await _syncService.addToQueue(
      localId: farmer.id,
      entityType: 'farmer',
      operation: 'update',
      data: farmer.toJson(),
    );

    return farmer;
  }

  @override
  Future<void> deleteFarmer(String id) async {
    await (_db.delete(_db.farmers)..where((t) => t.id.equals(id))).go();

    await _syncService.addToQueue(
      localId: id,
      entityType: 'farmer',
      operation: 'delete',
      data: {},
    );
  }
}
