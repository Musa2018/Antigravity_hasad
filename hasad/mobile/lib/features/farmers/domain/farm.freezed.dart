// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'farm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Farm _$FarmFromJson(Map<String, dynamic> json) {
  return _Farm.fromJson(json);
}

/// @nodoc
mixin _$Farm {
  String get id => throw _privateConstructorUsedError; // ClientId
  String get farmerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get governorateId => throw _privateConstructorUsedError;
  String get localityId => throw _privateConstructorUsedError;
  double get landArea => throw _privateConstructorUsedError;
  String get landAreaUnit => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String get ownershipTypeId => throw _privateConstructorUsedError;
  String get rowVersion => throw _privateConstructorUsedError;

  /// Serializes this Farm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Farm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FarmCopyWith<Farm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmCopyWith<$Res> {
  factory $FarmCopyWith(Farm value, $Res Function(Farm) then) =
      _$FarmCopyWithImpl<$Res, Farm>;
  @useResult
  $Res call({
    String id,
    String farmerId,
    String name,
    String governorateId,
    String localityId,
    double landArea,
    String landAreaUnit,
    double? latitude,
    double? longitude,
    String ownershipTypeId,
    String rowVersion,
  });
}

/// @nodoc
class _$FarmCopyWithImpl<$Res, $Val extends Farm>
    implements $FarmCopyWith<$Res> {
  _$FarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Farm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? farmerId = null,
    Object? name = null,
    Object? governorateId = null,
    Object? localityId = null,
    Object? landArea = null,
    Object? landAreaUnit = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? ownershipTypeId = null,
    Object? rowVersion = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            farmerId: null == farmerId
                ? _value.farmerId
                : farmerId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            governorateId: null == governorateId
                ? _value.governorateId
                : governorateId // ignore: cast_nullable_to_non_nullable
                      as String,
            localityId: null == localityId
                ? _value.localityId
                : localityId // ignore: cast_nullable_to_non_nullable
                      as String,
            landArea: null == landArea
                ? _value.landArea
                : landArea // ignore: cast_nullable_to_non_nullable
                      as double,
            landAreaUnit: null == landAreaUnit
                ? _value.landAreaUnit
                : landAreaUnit // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            ownershipTypeId: null == ownershipTypeId
                ? _value.ownershipTypeId
                : ownershipTypeId // ignore: cast_nullable_to_non_nullable
                      as String,
            rowVersion: null == rowVersion
                ? _value.rowVersion
                : rowVersion // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FarmImplCopyWith<$Res> implements $FarmCopyWith<$Res> {
  factory _$$FarmImplCopyWith(
    _$FarmImpl value,
    $Res Function(_$FarmImpl) then,
  ) = __$$FarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String farmerId,
    String name,
    String governorateId,
    String localityId,
    double landArea,
    String landAreaUnit,
    double? latitude,
    double? longitude,
    String ownershipTypeId,
    String rowVersion,
  });
}

/// @nodoc
class __$$FarmImplCopyWithImpl<$Res>
    extends _$FarmCopyWithImpl<$Res, _$FarmImpl>
    implements _$$FarmImplCopyWith<$Res> {
  __$$FarmImplCopyWithImpl(_$FarmImpl _value, $Res Function(_$FarmImpl) _then)
    : super(_value, _then);

  /// Create a copy of Farm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? farmerId = null,
    Object? name = null,
    Object? governorateId = null,
    Object? localityId = null,
    Object? landArea = null,
    Object? landAreaUnit = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? ownershipTypeId = null,
    Object? rowVersion = null,
  }) {
    return _then(
      _$FarmImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        farmerId: null == farmerId
            ? _value.farmerId
            : farmerId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        governorateId: null == governorateId
            ? _value.governorateId
            : governorateId // ignore: cast_nullable_to_non_nullable
                  as String,
        localityId: null == localityId
            ? _value.localityId
            : localityId // ignore: cast_nullable_to_non_nullable
                  as String,
        landArea: null == landArea
            ? _value.landArea
            : landArea // ignore: cast_nullable_to_non_nullable
                  as double,
        landAreaUnit: null == landAreaUnit
            ? _value.landAreaUnit
            : landAreaUnit // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        ownershipTypeId: null == ownershipTypeId
            ? _value.ownershipTypeId
            : ownershipTypeId // ignore: cast_nullable_to_non_nullable
                  as String,
        rowVersion: null == rowVersion
            ? _value.rowVersion
            : rowVersion // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FarmImpl implements _Farm {
  const _$FarmImpl({
    required this.id,
    required this.farmerId,
    required this.name,
    required this.governorateId,
    required this.localityId,
    required this.landArea,
    required this.landAreaUnit,
    this.latitude,
    this.longitude,
    required this.ownershipTypeId,
    this.rowVersion = '',
  });

  factory _$FarmImpl.fromJson(Map<String, dynamic> json) =>
      _$$FarmImplFromJson(json);

  @override
  final String id;
  // ClientId
  @override
  final String farmerId;
  @override
  final String name;
  @override
  final String governorateId;
  @override
  final String localityId;
  @override
  final double landArea;
  @override
  final String landAreaUnit;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String ownershipTypeId;
  @override
  @JsonKey()
  final String rowVersion;

  @override
  String toString() {
    return 'Farm(id: $id, farmerId: $farmerId, name: $name, governorateId: $governorateId, localityId: $localityId, landArea: $landArea, landAreaUnit: $landAreaUnit, latitude: $latitude, longitude: $longitude, ownershipTypeId: $ownershipTypeId, rowVersion: $rowVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.farmerId, farmerId) ||
                other.farmerId == farmerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.governorateId, governorateId) ||
                other.governorateId == governorateId) &&
            (identical(other.localityId, localityId) ||
                other.localityId == localityId) &&
            (identical(other.landArea, landArea) ||
                other.landArea == landArea) &&
            (identical(other.landAreaUnit, landAreaUnit) ||
                other.landAreaUnit == landAreaUnit) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.ownershipTypeId, ownershipTypeId) ||
                other.ownershipTypeId == ownershipTypeId) &&
            (identical(other.rowVersion, rowVersion) ||
                other.rowVersion == rowVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    farmerId,
    name,
    governorateId,
    localityId,
    landArea,
    landAreaUnit,
    latitude,
    longitude,
    ownershipTypeId,
    rowVersion,
  );

  /// Create a copy of Farm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmImplCopyWith<_$FarmImpl> get copyWith =>
      __$$FarmImplCopyWithImpl<_$FarmImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FarmImplToJson(this);
  }
}

abstract class _Farm implements Farm {
  const factory _Farm({
    required final String id,
    required final String farmerId,
    required final String name,
    required final String governorateId,
    required final String localityId,
    required final double landArea,
    required final String landAreaUnit,
    final double? latitude,
    final double? longitude,
    required final String ownershipTypeId,
    final String rowVersion,
  }) = _$FarmImpl;

  factory _Farm.fromJson(Map<String, dynamic> json) = _$FarmImpl.fromJson;

  @override
  String get id; // ClientId
  @override
  String get farmerId;
  @override
  String get name;
  @override
  String get governorateId;
  @override
  String get localityId;
  @override
  double get landArea;
  @override
  String get landAreaUnit;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String get ownershipTypeId;
  @override
  String get rowVersion;

  /// Create a copy of Farm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FarmImplCopyWith<_$FarmImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
