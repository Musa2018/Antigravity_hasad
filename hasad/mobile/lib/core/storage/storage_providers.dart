import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/storage/background_sync_service.dart';
import 'package:mobile/core/storage/database.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/farmers/data/damage_report_attachment_repository.dart';
import 'package:mobile/features/farmers/data/remote_damage_report_repository.dart';
import 'package:mobile/features/farmers/data/remote_farm_repository.dart';
import 'package:mobile/features/farmers/data/remote_farmer_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final remoteFarmerRepositoryProvider = Provider<RemoteFarmerRepository>((ref) {
  return RemoteFarmerRepository(ref.watch(apiDioProvider));
});

final syncServiceProvider = Provider<BackgroundSyncService>((ref) {
  final service = BackgroundSyncService(
    ref.watch(databaseProvider),
    ref.watch(remoteFarmerRepositoryProvider),
    RemoteFarmRepository(ref.watch(apiDioProvider)),
    RemoteDamageReportRepository(ref.watch(apiDioProvider)),
    RemoteDamageReportAttachmentRepository(ref.watch(apiDioProvider)),
    ref.watch(connectivityProvider),
  );
  ref.onDispose(() => service.dispose());
  return service;
});
