import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DataClassName('FarmerLocal')
class Farmers extends Table {
  TextColumn get id => text()(); // local UUID (ClientId)
  TextColumn get serverId => text().nullable()(); // Authority ID from server
  IntColumn get idTypeId => integer().withDefault(const Constant(1))();
  TextColumn get idNumber => text().withLength(max: 20).withDefault(const Constant(''))();
  
  // Names
  TextColumn get firstNameAr => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get fatherNameAr => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get grandfatherNameAr => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get familyNameAr => text().withLength(max: 50).withDefault(const Constant(''))();
  
  TextColumn get firstNameEn => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get fatherNameEn => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get grandfatherNameEn => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get familyNameEn => text().withLength(max: 50).withDefault(const Constant(''))();

  DateTimeColumn get birthDate => dateTime().nullable()();
  IntColumn get gender => integer().withDefault(const Constant(0))();
  TextColumn get phoneNumber => text().withLength(max: 20).withDefault(const Constant(''))();
  IntColumn get familySize => integer().withDefault(const Constant(1))();

  TextColumn get governorateId => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get localityId => text().withLength(max: 50).withDefault(const Constant(''))();
  TextColumn get address => text().withLength(max: 500).withDefault(const Constant(''))();

  // Deprecated field - kept temporarily for migration safety if needed, or we can use onUpgrade to drop/ignore.
  // Actually, standard Drift migration adding columns is safer.
  TextColumn get name => text().withLength(max: 200).withDefault(const Constant(''))();
  TextColumn get nationalId => text().withLength(max: 20).withDefault(const Constant(''))();

  // Optimistic concurrency token
  TextColumn get rowVersion => text().withDefault(const Constant(''))();

  // Sync Status: pending, syncing, completed, failed, conflict
  TextColumn get syncStatus =>
      text().withDefault(const Constant('completed'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FarmLocal')
class Farms extends Table {
  TextColumn get id => text()(); // ClientId
  TextColumn get serverId => text().nullable()(); // Server Id
  TextColumn get farmerId => text()(); // Farmer ClientId
  TextColumn get name => text().withLength(max: 200)();
  TextColumn get governorateId => text().withLength(max: 50)();
  TextColumn get localityId => text().withLength(max: 50)();
  RealColumn get landArea => real()();
  TextColumn get landAreaUnit => text().withLength(max: 20)();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get ownershipTypeId => text().withLength(max: 50)();

  TextColumn get rowVersion => text().withDefault(const Constant(''))();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('completed'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DamageReportLocal')
class DamageReports extends Table {
  TextColumn get id => text()(); // ClientId
  TextColumn get serverId => text().nullable()();
  TextColumn get farmId => text()();
  TextColumn get farmerId => text()();

  DateTimeColumn get damageDate => dateTime()();
  DateTimeColumn get documentationDate => dateTime()();

  TextColumn get governorateId => text().withLength(max: 50)();
  TextColumn get localityId => text().withLength(max: 50)();

  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  TextColumn get statusId => text().withLength(max: 50)();
  TextColumn get notes => text()();

  TextColumn get rowVersion => text().withDefault(const Constant(''))();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('completed'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DamageItemLocal')
class DamageItems extends Table {
  TextColumn get id => text()(); // ClientId
  TextColumn get serverId => text().nullable()();
  TextColumn get damageReportId => text()();

  TextColumn get agriculturalSectorId => text().withLength(max: 50)();
  TextColumn get subSectorId => text().withLength(max: 50)();
  TextColumn get cropId => text().withLength(max: 50)();
  TextColumn get damageTypeId => text().withLength(max: 50)();

  RealColumn get affectedArea => real()();
  RealColumn get damagePercentage => real()();
  RealColumn get quantity => real()();
  RealColumn get estimatedLoss => real()();

  TextColumn get rowVersion => text().withDefault(const Constant(''))();
  TextColumn get syncStatus =>
      text().withDefault(const Constant('completed'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DamageReportAttachmentLocal')
class DamageReportAttachments extends Table {
  TextColumn get id => text()(); // ClientId
  TextColumn get serverId => text().nullable()();
  TextColumn get damageReportId => text()();

  TextColumn get localPath => text()();
  TextColumn get remotePath => text().nullable()();

  TextColumn get uploadStatus => text().withDefault(
    const Constant('pending'),
  )(); // pending, uploading, completed, failed
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get localId => text()();
  TextColumn get entityType =>
      text()(); // 'farmer', 'farm', 'damage_report', 'damage_item', 'attachment'
  TextColumn get operation =>
      text()(); // 'create', 'update', 'delete', 'upload'
  TextColumn get data => text()(); // JSON payload
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Farmers,
    Farms,
    DamageReports,
    DamageItems,
    DamageReportAttachments,
    SyncQueue,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.withExecutor(super.e);

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(farmers, farmers.rowVersion);
      }
      if (from < 3) {
        await m.addColumn(syncQueue, syncQueue.lastAttemptAt);
      }
      if (from < 4) {
        await m.createTable(farms);
      }
      if (from < 5) {
        await m.createTable(damageReports);
        await m.createTable(damageItems);
        await m.createTable(damageReportAttachments);
      }
      if (from < 6) {
        // Upgrade DamageReportAttachments table
        await m.addColumn(
          damageReportAttachments,
          damageReportAttachments.serverId,
        );
        await m.addColumn(
          damageReportAttachments,
          damageReportAttachments.remotePath,
        );
        await m.addColumn(
          damageReportAttachments,
          damageReportAttachments.uploadStatus,
        );
        await m.addColumn(
          damageReportAttachments,
          damageReportAttachments.updatedAt,
        );
      }
      if (from < 7) {
        // Enhance Farmers table for Sprint 10.3
        await m.addColumn(farmers, farmers.idTypeId);
        await m.addColumn(farmers, farmers.idNumber);
        await m.addColumn(farmers, farmers.firstNameAr);
        await m.addColumn(farmers, farmers.fatherNameAr);
        await m.addColumn(farmers, farmers.grandfatherNameAr);
        await m.addColumn(farmers, farmers.familyNameAr);
        await m.addColumn(farmers, farmers.firstNameEn);
        await m.addColumn(farmers, farmers.fatherNameEn);
        await m.addColumn(farmers, farmers.grandfatherNameEn);
        await m.addColumn(farmers, farmers.familyNameEn);
        await m.addColumn(farmers, farmers.birthDate);
        await m.addColumn(farmers, farmers.gender);
        await m.addColumn(farmers, farmers.familySize);
        await m.addColumn(farmers, farmers.governorateId);
        await m.addColumn(farmers, farmers.localityId);
        await m.addColumn(farmers, farmers.updatedAt);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
