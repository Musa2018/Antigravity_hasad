// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damage_report_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DamageReportAttachmentImpl _$$DamageReportAttachmentImplFromJson(
  Map<String, dynamic> json,
) => _$DamageReportAttachmentImpl(
  id: json['id'] as String,
  damageReportId: json['damageReportId'] as String,
  localPath: json['localPath'] as String,
  remotePath: json['remotePath'] as String?,
  uploadStatus: json['uploadStatus'] as String? ?? 'pending',
  syncStatus: json['syncStatus'] as String? ?? 'pending',
);

Map<String, dynamic> _$$DamageReportAttachmentImplToJson(
  _$DamageReportAttachmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'damageReportId': instance.damageReportId,
  'localPath': instance.localPath,
  'remotePath': instance.remotePath,
  'uploadStatus': instance.uploadStatus,
  'syncStatus': instance.syncStatus,
};
