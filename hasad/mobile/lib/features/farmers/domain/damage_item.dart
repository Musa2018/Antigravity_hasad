import 'package:freezed_annotation/freezed_annotation.dart';

part 'damage_item.freezed.dart';
part 'damage_item.g.dart';

@freezed
class DamageItem with _$DamageItem {
  const factory DamageItem({
    required String id, // ClientId
    required String damageReportId,
    required String agriculturalSectorId,
    required String subSectorId,
    required String cropId,
    required String damageTypeId,
    required double affectedArea,
    required double damagePercentage,
    required double quantity,
    required double estimatedLoss,
    @Default('') String rowVersion,
  }) = _DamageItem;

  factory DamageItem.fromJson(Map<String, dynamic> json) =>
      _$DamageItemFromJson(json);
}
