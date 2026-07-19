import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/farmers/domain/damage_item.dart';

part 'damage_report.freezed.dart';
part 'damage_report.g.dart';

@freezed
class DamageReport with _$DamageReport {
  const factory DamageReport({
    required String id, // ClientId
    required String farmId,
    required String farmerId,
    required DateTime damageDate,
    required DateTime documentationDate,
    required String governorateId,
    required String localityId,
    double? latitude,
    double? longitude,
    required String statusId,
    required String notes,
    @Default('') String rowVersion,
    @Default([]) List<DamageItem> items,
  }) = _DamageReport;

  factory DamageReport.fromJson(Map<String, dynamic> json) =>
      _$DamageReportFromJson(json);
}
