// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  userName: json['userName'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
  role: json['role'] as String,
  governorateId: json['governorateId'] as String?,
  governorateName: json['governorateName'] as String?,
  directorateId: json['directorateId'] as String?,
  directorateName: json['directorateName'] as String?,
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'governorateId': instance.governorateId,
      'governorateName': instance.governorateName,
      'directorateId': instance.directorateId,
      'directorateName': instance.directorateName,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };
