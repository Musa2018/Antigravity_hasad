// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FarmerImpl _$$FarmerImplFromJson(Map<String, dynamic> json) => _$FarmerImpl(
  id: json['id'] as String,
  serverId: json['serverId'] as String?,
  clientId: json['clientId'] as String? ?? '',
  idTypeId: (json['idTypeId'] as num).toInt(),
  idNumber: json['idNumber'] as String,
  firstNameAr: json['firstNameAr'] as String,
  fatherNameAr: json['fatherNameAr'] as String,
  grandfatherNameAr: json['grandfatherNameAr'] as String,
  familyNameAr: json['familyNameAr'] as String,
  firstNameEn: json['firstNameEn'] as String,
  fatherNameEn: json['fatherNameEn'] as String,
  grandfatherNameEn: json['grandfatherNameEn'] as String,
  familyNameEn: json['familyNameEn'] as String,
  birthDate: DateTime.parse(json['birthDate'] as String),
  gender: $enumDecode(_$GenderEnumMap, json['gender']),
  phoneNumber: json['phoneNumber'] as String,
  familySize: (json['familySize'] as num).toInt(),
  governorateId: json['governorateId'] as String,
  localityId: json['localityId'] as String,
  address: json['address'] as String,
  rowVersion: json['rowVersion'] as String? ?? '',
  syncStatus: json['syncStatus'] as String? ?? 'completed',
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$FarmerImplToJson(_$FarmerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serverId': instance.serverId,
      'clientId': instance.clientId,
      'idTypeId': instance.idTypeId,
      'idNumber': instance.idNumber,
      'firstNameAr': instance.firstNameAr,
      'fatherNameAr': instance.fatherNameAr,
      'grandfatherNameAr': instance.grandfatherNameAr,
      'familyNameAr': instance.familyNameAr,
      'firstNameEn': instance.firstNameEn,
      'fatherNameEn': instance.fatherNameEn,
      'grandfatherNameEn': instance.grandfatherNameEn,
      'familyNameEn': instance.familyNameEn,
      'birthDate': instance.birthDate.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender]!,
      'phoneNumber': instance.phoneNumber,
      'familySize': instance.familySize,
      'governorateId': instance.governorateId,
      'localityId': instance.localityId,
      'address': instance.address,
      'rowVersion': instance.rowVersion,
      'syncStatus': instance.syncStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$GenderEnumMap = {
  Gender.unspecified: 0,
  Gender.male: 1,
  Gender.female: 2,
};
