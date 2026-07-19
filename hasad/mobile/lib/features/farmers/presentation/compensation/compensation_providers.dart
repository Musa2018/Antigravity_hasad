import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/farmers/data/compensation_repository.dart';
import 'package:mobile/features/farmers/domain/compensation.dart';

final compensationRepositoryProvider = Provider<CompensationRepository>((ref) {
  return CompensationRepositoryImpl(ref.watch(apiDioProvider));
});

final compensationProvider = FutureProvider.family<Compensation?, String>((
  ref,
  reportId,
) async {
  return ref.watch(compensationRepositoryProvider).getByReportId(reportId);
});

class CompensationNotifier extends StateNotifier<AsyncValue<void>> {
  final CompensationRepository _repository;

  CompensationNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> calculate(String reportId, String remarks) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.create(reportId, remarks));
  }

  Future<void> recalculate(Compensation compensation) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.recalculate(compensation.id, compensation.rowVersion),
    );
  }

  Future<void> submit(Compensation compensation) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.submit(compensation.id, compensation.rowVersion),
    );
  }

  Future<void> approve(
    Compensation compensation,
    double amount,
    String remarks,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.approve(
        compensation.id,
        amount,
        remarks,
        compensation.rowVersion,
      ),
    );
  }

  Future<void> reject(Compensation compensation, String remarks) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () =>
          _repository.reject(compensation.id, remarks, compensation.rowVersion),
    );
  }

  Future<void> pay(Compensation compensation, String remarks) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.markAsPaid(
        compensation.id,
        remarks,
        compensation.rowVersion,
      ),
    );
  }
}

final compensationActionProvider =
    StateNotifierProvider<CompensationNotifier, AsyncValue<void>>((ref) {
      return CompensationNotifier(ref.watch(compensationRepositoryProvider));
    });
