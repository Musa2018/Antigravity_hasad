import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/farmers/domain/gender.dart';

part 'farmer.freezed.dart';
part 'farmer.g.dart';

@freezed
class Farmer with _$Farmer {
  const factory Farmer({
    required String id, // Local ClientId
    String? serverId,
    @Default('') String clientId, // Redundant but kept for sync contract consistency
    required int idTypeId,
    required String idNumber,
    required String firstNameAr,
    required String fatherNameAr,
    required String grandfatherNameAr,
    required String familyNameAr,
    required String firstNameEn,
    required String fatherNameEn,
    required String grandfatherNameEn,
    required String familyNameEn,
    required DateTime birthDate,
    required Gender gender,
    required String phoneNumber,
    required int familySize,
    required String governorateId,
    required String localityId,
    required String address,
    @Default('') String rowVersion,
    @Default('completed') String syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Farmer;

  const Farmer._();

  String get name =>
      '$firstNameAr $fatherNameAr $grandfatherNameAr $familyNameAr'.trim();
  String get nameEn =>
      '$firstNameEn $fatherNameEn $grandfatherNameEn $familyNameEn'.trim();
  String get nationalId => idNumber;

  factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(json);
}
