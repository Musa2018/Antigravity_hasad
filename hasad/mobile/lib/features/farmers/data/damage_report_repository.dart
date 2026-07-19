import 'package:mobile/features/farmers/domain/damage_report.dart';
import 'package:mobile/features/farmers/domain/damage_item.dart';

class DamageReportException implements Exception {
  final List<String> errors;
  DamageReportException(this.errors);
  @override
  String toString() =>
      errors.isEmpty ? 'An error occurred.' : errors.join('\n');
}

abstract class DamageReportRepository {
  Future<List<DamageReport>> getDamageReportsByFarm(String farmId);
  Future<DamageReport> getDamageReport(String id);
  Future<DamageReport> createDamageReport(DamageReport report);
  Future<DamageReport> updateDamageReport(DamageReport report);
  Future<void> deleteDamageReport(String id);

  Future<DamageItem> addDamageItem(DamageItem item);
  Future<DamageItem> updateDamageItem(DamageItem item);
  Future<void> deleteDamageItem(String id);
}
