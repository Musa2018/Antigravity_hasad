// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locality.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Locality _$LocalityFromJson(Map<String, dynamic> json) {
  return _Locality.fromJson(json);
}

/// @nodoc
mixin _$Locality {
  String get id => throw _privateConstructorUsedError;
  String get nameAr => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  String get governorateId => throw _privateConstructorUsedError;

  /// Serializes this Locality to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Locality
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalityCopyWith<Locality> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalityCopyWith<$Res> {
  factory $LocalityCopyWith(Locality value, $Res Function(Locality) then) =
      _$LocalityCopyWithImpl<$Res, Locality>;
  @useResult
  $Res call({String id, String nameAr, String nameEn, String governorateId});
}

/// @nodoc
class _$LocalityCopyWithImpl<$Res, $Val extends Locality>
    implements $LocalityCopyWith<$Res> {
  _$LocalityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Locality
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
abstract class _$$LocalityImplCopyWith<$Res>
    implements $LocalityCopyWith<$Res> {
  factory _$$LocalityImplCopyWith(
    _$LocalityImpl value,
    $Res Function(_$LocalityImpl) then,
  ) = __$$LocalityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String nameAr, String nameEn, String governorateId});
}

/// @nodoc
class __$$LocalityImplCopyWithImpl<$Res>
    extends _$LocalityCopyWithImpl<$Res, _$LocalityImpl>
    implements _$$LocalityImplCopyWith<$Res> {
  __$$LocalityImplCopyWithImpl(
    _$LocalityImpl _value,
    $Res Function(_$LocalityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Locality
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
      _$LocalityImpl(
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
class _$LocalityImpl implements _Locality {
  const _$LocalityImpl({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.governorateId,
  });

  factory _$LocalityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalityImplFromJson(json);

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
    return 'Locality(id: $id, nameAr: $nameAr, nameEn: $nameEn, governorateId: $governorateId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalityImpl &&
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

  /// Create a copy of Locality
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalityImplCopyWith<_$LocalityImpl> get copyWith =>
      __$$LocalityImplCopyWithImpl<_$LocalityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalityImplToJson(this);
  }
}

abstract class _Locality implements Locality {
  const factory _Locality({
    required final String id,
    required final String nameAr,
    required final String nameEn,
    required final String governorateId,
  }) = _$LocalityImpl;

  factory _Locality.fromJson(Map<String, dynamic> json) =
      _$LocalityImpl.fromJson;

  @override
  String get id;
  @override
  String get nameAr;
  @override
  String get nameEn;
  @override
  String get governorateId;

  /// Create a copy of Locality
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalityImplCopyWith<_$LocalityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
