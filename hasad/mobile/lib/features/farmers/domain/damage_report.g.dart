// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damage_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DamageReportImpl _$$DamageReportImplFromJson(Map<String, dynamic> json) =>
    _$DamageReportImpl(
      id: json['id'] as String,
      farmId: json['farmId'] as String,
      farmerId: json['farmerId'] as String,
      damageDate: DateTime.parse(json['damageDate'] as String),
      documentationDate: DateTime.parse(json['documentationDate'] as String),
      governorateId: json['governorateId'] as String,
      localityId: json['localityId'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      statusId: json['statusId'] as String,
      notes: json['notes'] as String,
      rowVersion: json['rowVersion'] as String? ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => DamageItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DamageReportImplToJson(_$DamageReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmId': instance.farmId,
      'farmerId': instance.farmerId,
      'damageDate': instance.damageDate.toIso8601String(),
      'documentationDate': instance.documentationDate.toIso8601String(),
      'governorateId': instance.governorateId,
      'localityId': instance.localityId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'statusId': instance.statusId,
      'notes': instance.notes,
      'rowVersion': instance.rowVersion,
      'items': instance.items,
    };
