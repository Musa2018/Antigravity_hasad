import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/auth/presentation/auth_providers.dart';
import 'package:mobile/features/location/data/location_repository.dart';
import 'package:mobile/features/location/domain/directorate.dart';
import 'package:mobile/features/location/domain/governorate.dart';
import 'package:mobile/features/location/domain/locality.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocationRepositoryImpl(ref.watch(apiDioProvider));
});

final governoratesProvider = FutureProvider<List<Governorate>>((ref) async {
  return ref.watch(locationRepositoryProvider).getGovernorates();
});

final directoratesProvider = FutureProvider.family<List<Directorate>, String?>((
  ref,
  governorateId,
) async {
  return ref
      .watch(locationRepositoryProvider)
      .getDirectorates(governorateId: governorateId);
});

final localitiesProvider = FutureProvider.family<List<Locality>, String?>((
  ref,
  governorateId,
) async {
  return ref
      .watch(locationRepositoryProvider)
      .getLocalities(governorateId: governorateId);
});
