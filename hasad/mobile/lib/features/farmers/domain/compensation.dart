import 'package:freezed_annotation/freezed_annotation.dart';

part 'compensation.freezed.dart';
part 'compensation.g.dart';

@freezed
class Compensation with _$Compensation {
  const factory Compensation({
    required String id,
    required String clientId,
    required String damageReportId,
    required double calculatedAmount,
    required double approvedAmount,
    required String status,
    required String remarks,
    required String rowVersion,
  }) = _Compensation;

  factory Compensation.fromJson(Map<String, dynamic> json) =>
      _$CompensationFromJson(json);
}
