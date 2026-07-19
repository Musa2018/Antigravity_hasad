// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'damage_report_attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DamageReportAttachment _$DamageReportAttachmentFromJson(
  Map<String, dynamic> json,
) {
  return _DamageReportAttachment.fromJson(json);
}

/// @nodoc
mixin _$DamageReportAttachment {
  String get id => throw _privateConstructorUsedError; // ClientId
  String get damageReportId => throw _privateConstructorUsedError;
  String get localPath => throw _privateConstructorUsedError;
  String? get remotePath => throw _privateConstructorUsedError;
  String get uploadStatus => throw _privateConstructorUsedError;
  String get syncStatus => throw _privateConstructorUsedError;

  /// Serializes this DamageReportAttachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DamageReportAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DamageReportAttachmentCopyWith<DamageReportAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DamageReportAttachmentCopyWith<$Res> {
  factory $DamageReportAttachmentCopyWith(
    DamageReportAttachment value,
    $Res Function(DamageReportAttachment) then,
  ) = _$DamageReportAttachmentCopyWithImpl<$Res, DamageReportAttachment>;
  @useResult
  $Res call({
    String id,
    String damageReportId,
    String localPath,
    String? remotePath,
    String uploadStatus,
    String syncStatus,
  });
}

/// @nodoc
class _$DamageReportAttachmentCopyWithImpl<
  $Res,
  $Val extends DamageReportAttachment
>
    implements $DamageReportAttachmentCopyWith<$Res> {
  _$DamageReportAttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DamageReportAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? damageReportId = null,
    Object? localPath = null,
    Object? remotePath = freezed,
    Object? uploadStatus = null,
    Object? syncStatus = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            damageReportId: null == damageReportId
                ? _value.damageReportId
                : damageReportId // ignore: cast_nullable_to_non_nullable
                      as String,
            localPath: null == localPath
                ? _value.localPath
                : localPath // ignore: cast_nullable_to_non_nullable
                      as String,
            remotePath: freezed == remotePath
                ? _value.remotePath
                : remotePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            uploadStatus: null == uploadStatus
                ? _value.uploadStatus
                : uploadStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            syncStatus: null == syncStatus
                ? _value.syncStatus
                : syncStatus // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DamageReportAttachmentImplCopyWith<$Res>
    implements $DamageReportAttachmentCopyWith<$Res> {
  factory _$$DamageReportAttachmentImplCopyWith(
    _$DamageReportAttachmentImpl value,
    $Res Function(_$DamageReportAttachmentImpl) then,
  ) = __$$DamageReportAttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String damageReportId,
    String localPath,
    String? remotePath,
    String uploadStatus,
    String syncStatus,
  });
}

/// @nodoc
class __$$DamageReportAttachmentImplCopyWithImpl<$Res>
    extends
        _$DamageReportAttachmentCopyWithImpl<$Res, _$DamageReportAttachmentImpl>
    implements _$$DamageReportAttachmentImplCopyWith<$Res> {
  __$$DamageReportAttachmentImplCopyWithImpl(
    _$DamageReportAttachmentImpl _value,
    $Res Function(_$DamageReportAttachmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DamageReportAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? damageReportId = null,
    Object? localPath = null,
    Object? remotePath = freezed,
    Object? uploadStatus = null,
    Object? syncStatus = null,
  }) {
    return _then(
      _$DamageReportAttachmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        damageReportId: null == damageReportId
            ? _value.damageReportId
            : damageReportId // ignore: cast_nullable_to_non_nullable
                  as String,
        localPath: null == localPath
            ? _value.localPath
            : localPath // ignore: cast_nullable_to_non_nullable
                  as String,
        remotePath: freezed == remotePath
            ? _value.remotePath
            : remotePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        uploadStatus: null == uploadStatus
            ? _value.uploadStatus
            : uploadStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        syncStatus: null == syncStatus
            ? _value.syncStatus
            : syncStatus // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DamageReportAttachmentImpl implements _DamageReportAttachment {
  const _$DamageReportAttachmentImpl({
    required this.id,
    required this.damageReportId,
    required this.localPath,
    this.remotePath,
    this.uploadStatus = 'pending',
    this.syncStatus = 'pending',
  });

  factory _$DamageReportAttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DamageReportAttachmentImplFromJson(json);

  @override
  final String id;
  // ClientId
  @override
  final String damageReportId;
  @override
  final String localPath;
  @override
  final String? remotePath;
  @override
  @JsonKey()
  final String uploadStatus;
  @override
  @JsonKey()
  final String syncStatus;

  @override
  String toString() {
    return 'DamageReportAttachment(id: $id, damageReportId: $damageReportId, localPath: $localPath, remotePath: $remotePath, uploadStatus: $uploadStatus, syncStatus: $syncStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DamageReportAttachmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.damageReportId, damageReportId) ||
                other.damageReportId == damageReportId) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.remotePath, remotePath) ||
                other.remotePath == remotePath) &&
            (identical(other.uploadStatus, uploadStatus) ||
                other.uploadStatus == uploadStatus) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    damageReportId,
    localPath,
    remotePath,
    uploadStatus,
    syncStatus,
  );

  /// Create a copy of DamageReportAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DamageReportAttachmentImplCopyWith<_$DamageReportAttachmentImpl>
  get copyWith =>
      __$$DamageReportAttachmentImplCopyWithImpl<_$DamageReportAttachmentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DamageReportAttachmentImplToJson(this);
  }
}

abstract class _DamageReportAttachment implements DamageReportAttachment {
  const factory _DamageReportAttachment({
    required final String id,
    required final String damageReportId,
    required final String localPath,
    final String? remotePath,
    final String uploadStatus,
    final String syncStatus,
  }) = _$DamageReportAttachmentImpl;

  factory _DamageReportAttachment.fromJson(Map<String, dynamic> json) =
      _$DamageReportAttachmentImpl.fromJson;

  @override
  String get id; // ClientId
  @override
  String get damageReportId;
  @override
  String get localPath;
  @override
  String? get remotePath;
  @override
  String get uploadStatus;
  @override
  String get syncStatus;

  /// Create a copy of DamageReportAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DamageReportAttachmentImplCopyWith<_$DamageReportAttachmentImpl>
  get copyWith => throw _privateConstructorUsedError;
}
