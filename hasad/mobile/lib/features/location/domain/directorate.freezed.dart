// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directorate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Directorate _$DirectorateFromJson(Map<String, dynamic> json) {
  return _Directorate.fromJson(json);
}

/// @nodoc
mixin _$Directorate {
  String get id => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  String get governorateId => throw _privateConstructorUsedError;

  /// Serializes this Directorate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Directorate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DirectorateCopyWith<Directorate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectorateCopyWith<$Res> {
  factory $DirectorateCopyWith(
    Directorate value,
    $Res Function(Directorate) then,
  ) = _$DirectorateCopyWithImpl<$Res, Directorate>;
  @useResult
  $Res call({String id, String nameAr, String nameEn, String governorateId});
}

/// @nodoc
class _$DirectorateCopyWithImpl<$Res, $Val extends Directorate>
    implements $DirectorateCopyWith<$Res> {
  _$DirectorateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Directorate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? nameEn = null,
    Object? governorateId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nameAr: null == nameAr
                ? _value.nameAr
                : nameAr // ignore: cast_nullable_to_non_nullable
                      as String,
            nameEn: null == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String,
            governorateId: null == governorateId
                ? _value.governorateId
                : governorateId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DirectorateImplCopyWith<$Res>
    implements $DirectorateCopyWith<$Res> {
  factory _$$DirectorateImplCopyWith(
    _$DirectorateImpl value,
    $Res Function(_$DirectorateImpl) then,
  ) = __$$DirectorateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String nameAr, String nameEn, String governorateId});
}

/// @nodoc
class __$$DirectorateImplCopyWithImpl<$Res>
    extends _$DirectorateCopyWithImpl<$Res, _$DirectorateImpl>
    implements _$$DirectorateImplCopyWith<$Res> {
  __$$DirectorateImplCopyWithImpl(
    _$DirectorateImpl _value,
    $Res Function(_$DirectorateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Directorate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameAr = null,
    Object? nameEn = null,
    Object? governorateId = null,
  }) {
    return _then(
      _$DirectorateImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nameAr: null == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String,
        nameEn: null == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String,
        governorateId: null == governorateId
            ? _value.governorateId
            : governorateId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectorateImpl implements _Directorate {
  const _$DirectorateImpl({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.governorateId,
  });

  factory _$DirectorateImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectorateImplFromJson(json);

  @override
  final String id;
  @override
  final String nameAr;
  @override
  final String nameEn;
  @override
  final String governorateId;

  @override
  String toString() {
    return 'Directorate(id: $id, nameAr: $nameAr, nameEn: $nameEn, governorateId: $governorateId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectorateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.governorateId, governorateId) ||
                other.governorateId == governorateId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, nameAr, nameEn, governorateId);

  /// Create a copy of Directorate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectorateImplCopyWith<_$DirectorateImpl> get copyWith =>
      __$$DirectorateImplCopyWithImpl<_$DirectorateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectorateImplToJson(this);
  }
}

abstract class _Directorate implements Directorate {
  const factory _Directorate({
    required final String id,
    required final String nameAr,
    required final String nameEn,
    required final String governorateId,
  }) = _$DirectorateImpl;

  factory _Directorate.fromJson(Map<String, dynamic> json) =
      _$DirectorateImpl.fromJson;

  @override
  String get id;
  @override
  String get nameAr;
  @override
  String get nameEn;
  @override
  String get governorateId;

  /// Create a copy of Directorate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DirectorateImplCopyWith<_$DirectorateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
