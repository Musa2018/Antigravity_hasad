import 'package:mobile/features/farmers/domain/farm.dart';

class FarmException implements Exception {
  final List<String> errors;
  FarmException(this.errors);
  @override
  String toString() =>
      errors.isEmpty ? 'An error occurred.' : errors.join('\n');
}

abstract class FarmRepository {
  Future<List<Farm>> getFarmsByFarmer(String farmerId);
  Future<Farm> getFarm(String id);
  Future<Farm> createFarm(Farm farm);
  Future<Farm> updateFarm(Farm farm);
  Future<void> deleteFarm(String id);
}
