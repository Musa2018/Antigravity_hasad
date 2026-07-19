import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/storage/storage_providers.dart';
import 'package:mobile/features/farmers/data/damage_report_attachment_repository.dart';
import 'package:mobile/features/farmers/data/damage_report_repository.dart';
import 'package:mobile/features/farmers/data/farm_repository.dart';
import 'package:mobile/features/farmers/data/farmer_repository.dart';
import 'package:mobile/features/farmers/data/offline_first_damage_report_attachment_repository.dart';
import 'package:mobile/features/farmers/data/offline_first_damage_report_repository.dart';
import 'package:mobile/features/farmers/data/offline_first_farm_repository.dart';
import 'package:mobile/features/farmers/domain/damage_report.dart';
import 'package:mobile/features/farmers/domain/damage_report_attachment.dart';
import 'package:mobile/features/farmers/domain/farm.dart';
import 'package:mobile/features/farmers/domain/farmer.dart';

final farmerRepositoryProvider = Provider<FarmerRepository>((ref) {
  return OfflineFirstFarmerRepository(
    ref.watch(databaseProvider),
    ref.watch(syncServiceProvider),
    ref.watch(remoteFarmerRepositoryProvider),
    ref.watch(connectivityProvider),
  );
});

final farmRepositoryProvider = Provider<FarmRepository>((ref) {
  return OfflineFirstFarmRepository(
    ref.watch(databaseProvider),
    ref.watch(syncServiceProvider),
  );
});

final damageReportRepositoryProvider = Provider<DamageReportRepository>((ref) {
  return OfflineFirstDamageReportRepository(
    ref.watch(databaseProvider),
    ref.watch(syncServiceProvider),
  );
});

final attachmentRepositoryProvider = Provider<DamageReportAttachmentRepository>(
  (ref) {
    return OfflineFirstDamageReportAttachmentRepository(
      ref.watch(databaseProvider),
      ref.watch(syncServiceProvider),
    );
  },
);

final farmersListProvider = FutureProvider.autoDispose<List<Farmer>>((
  ref,
) async {
  return ref.watch(farmerRepositoryProvider).getFarmers();
});

final farmerProvider = FutureProvider.autoDispose.family<Farmer, String>((
  ref,
  id,
) async {
  return ref.watch(farmerRepositoryProvider).getFarmer(id);
});

final farmsListByFarmerProvider = FutureProvider.autoDispose
    .family<List<Farm>, String>((ref, farmerId) async {
      return ref.watch(farmRepositoryProvider).getFarmsByFarmer(farmerId);
    });

final damageReportsListByFarmProvider = FutureProvider.autoDispose
    .family<List<DamageReport>, String>((ref, farmId) async {
      return ref
          .watch(damageReportRepositoryProvider)
          .getDamageReportsByFarm(farmId);
    });

final attachmentsByReportProvider = FutureProvider.autoDispose
    .family<List<DamageReportAttachment>, String>((ref, reportId) async {
      return ref
          .watch(attachmentRepositoryProvider)
          .getAttachmentsByReport(reportId);
    });

class DamageReportFormState {
  final bool isLoading;
  final List<String> errors;
  final bool success;

  const DamageReportFormState({
    this.isLoading = false,
    this.errors = const [],
    this.success = false,
  });
}

class DamageReportFormNotifier extends StateNotifier<DamageReportFormState> {
  final DamageReportRepository _repository;

  DamageReportFormNotifier(this._repository)
    : super(const DamageReportFormState());

  Future<void> createDamageReport(DamageReport report) async {
    state = const DamageReportFormState(isLoading: true);
    try {
      await _repository.createDamageReport(report);
      state = const DamageReportFormState(success: true);
    } on DamageReportException catch (e) {
      state = DamageReportFormState(errors: e.errors);
    } catch (_) {
      state = const DamageReportFormState(
        errors: ['An unexpected error occurred.'],
      );
    }
  }

  Future<void> updateDamageReport(DamageReport report) async {
    state = const DamageReportFormState(isLoading: true);
    try {
      await _repository.updateDamageReport(report);
      state = const DamageReportFormState(success: true);
    } on DamageReportException catch (e) {
      state = DamageReportFormState(errors: e.errors);
    } catch (_) {
      state = const DamageReportFormState(
        errors: ['An unexpected error occurred.'],
      );
    }
  }

  Future<void> deleteDamageReport(String id) async {
    state = const DamageReportFormState(isLoading: true);
    try {
      await _repository.deleteDamageReport(id);
      state = const DamageReportFormState(success: true);
    } on DamageReportException catch (e) {
      state = DamageReportFormState(errors: e.errors);
    } catch (_) {
      state = const DamageReportFormState(
        errors: ['An unexpected error occurred.'],
      );
    }
  }
}

final damageReportFormProvider =
    StateNotifierProvider.autoDispose<
      DamageReportFormNotifier,
      DamageReportFormState
    >((ref) {
      return DamageReportFormNotifier(
        ref.watch(damageReportRepositoryProvider),
      );
    });

class FarmerFormState {
  final bool isLoading;
  final List<String> errors;
  final bool success;

  const FarmerFormState({
    this.isLoading = false,
    this.errors = const [],
    this.success = false,
  });
}

class FarmerFormNotifier extends StateNotifier<FarmerFormState> {
  final FarmerRepository _repository;

  FarmerFormNotifier(this._repository) : super(const FarmerFormState());

  Future<void> createFarmer(Farmer farmer) async {
    state = const FarmerFormState(isLoading: true);
    try {
      await _repository.createFarmer(farmer);
      state = const FarmerFormState(success: true);
    } on FarmerException catch (e) {
      state = FarmerFormState(errors: e.errors);
    } catch (_) {
      state = const FarmerFormState(errors: ['An unexpected error occurred.']);
    }
  }

  Future<void> updateFarmer(Farmer farmer) async {
    state = const FarmerFormState(isLoading: true);
    try {
      await _repository.updateFarmer(farmer);
      state = const FarmerFormState(success: true);
    } on FarmerException catch (e) {
      state = FarmerFormState(errors: e.errors);
    } catch (_) {
      state = const FarmerFormState(errors: ['An unexpected error occurred.']);
    }
  }

  Future<void> deleteFarmer(String id) async {
    state = const FarmerFormState(isLoading: true);
    try {
      await _repository.deleteFarmer(id);
      state = const FarmerFormState(success: true);
    } on FarmerException catch (e) {
      state = FarmerFormState(errors: e.errors);
    } catch (_) {
      state = const FarmerFormState(errors: ['An unexpected error occurred.']);
    }
  }
}

final farmerFormProvider =
    StateNotifierProvider.autoDispose<FarmerFormNotifier, FarmerFormState>((
      ref,
    ) {
      return FarmerFormNotifier(ref.watch(farmerRepositoryProvider));
    });

class FarmFormState {
  final bool isLoading;
  final List<String> errors;
  final bool success;

  const FarmFormState({
    this.isLoading = false,
    this.errors = const [],
    this.success = false,
  });
}

class FarmFormNotifier extends StateNotifier<FarmFormState> {
  final FarmRepository _repository;

  FarmFormNotifier(this._repository) : super(const FarmFormState());

  Future<void> createFarm(Farm farm) async {
    state = const FarmFormState(isLoading: true);
    try {
      await _repository.createFarm(farm);
      state = const FarmFormState(success: true);
    } on FarmException catch (e) {
      state = FarmFormState(errors: e.errors);
    } catch (_) {
      state = const FarmFormState(errors: ['An unexpected error occurred.']);
    }
  }

  Future<void> updateFarm(Farm farm) async {
    state = const FarmFormState(isLoading: true);
    try {
      await _repository.updateFarm(farm);
      state = const FarmFormState(success: true);
    } on FarmException catch (e) {
      state = FarmFormState(errors: e.errors);
    } catch (_) {
      state = const FarmFormState(errors: ['An unexpected error occurred.']);
    }
  }

  Future<void> deleteFarm(String id) async {
    state = const FarmFormState(isLoading: true);
    try {
      await _repository.deleteFarm(id);
      state = const FarmFormState(success: true);
    } on FarmException catch (e) {
      state = FarmFormState(errors: e.errors);
    } catch (_) {
      state = const FarmFormState(errors: ['An unexpected error occurred.']);
    }
  }
}

final farmFormProvider =
    StateNotifierProvider.autoDispose<FarmFormNotifier, FarmFormState>((ref) {
      return FarmFormNotifier(ref.watch(farmRepositoryProvider));
    });

enum FarmerSearchStatus { idle, searching, found, notFound, error }

class FarmerSearchState {
  final FarmerSearchStatus status;
  final Farmer? farmer;
  final String? error;

  const FarmerSearchState({
    this.status = FarmerSearchStatus.idle,
    this.farmer,
    this.error,
  });
}

class FarmerSearchNotifier extends StateNotifier<FarmerSearchState> {
  final FarmerRepository _repository;

  FarmerSearchNotifier(this._repository) : super(const FarmerSearchState());

  Future<void> search(String idNumber) async {
    if (idNumber.isEmpty) return;

    state = const FarmerSearchState(status: FarmerSearchStatus.searching);

    try {
      final farmer = await _repository.findByIdNumber(idNumber);
      if (farmer != null) {
        state = FarmerSearchState(status: FarmerSearchStatus.found, farmer: farmer);
      } else {
        state = const FarmerSearchState(status: FarmerSearchStatus.notFound);
      }
    } catch (e) {
      state = FarmerSearchState(
        status: FarmerSearchStatus.error,
        error: e.toString(),
      );
    }
  }

  void reset() {
    state = const FarmerSearchState();
  }
}

final farmerSearchProvider =
    StateNotifierProvider.autoDispose<FarmerSearchNotifier, FarmerSearchState>((
      ref,
    ) {
      return FarmerSearchNotifier(ref.watch(farmerRepositoryProvider));
    });
