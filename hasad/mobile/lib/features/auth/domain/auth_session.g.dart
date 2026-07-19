// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthSessionImpl _$$AuthSessionImplFromJson(Map<String, dynamic> json) =>
    _$AuthSessionImpl(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      userId: json['userId'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      governorateId: json['governorateId'] as String?,
      directorateId: json['directorateId'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$$AuthSessionImplToJson(_$AuthSessionImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
      'email': instance.email,
      'fullName': instance.fullName,
      'governorateId': instance.governorateId,
      'directorateId': instance.directorateId,
      'roles': instance.roles,
    };
