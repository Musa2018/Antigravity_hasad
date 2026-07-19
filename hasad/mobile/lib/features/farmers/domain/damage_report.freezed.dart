// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'damage_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DamageReport _$DamageReportFromJson(Map<String, dynamic> json) {
  return _DamageReport.fromJson(json);
}

/// @nodoc
mixin _$DamageReport {
  String get id => throw _privateConstructorUsedError; // ClientId
  String get farmId => throw _privateConstructorUsedError;
  String get farmerId => throw _privateConstructorUsedError;
  DateTime get damageDate => throw _privateConstructorUsedError;
  DateTime get documentationDate => throw _privateConstructorUsedError;
  String get governorateId => throw _privateConstructorUsedError;
  String get localityId => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String get statusId => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  String get rowVersion => throw _privateConstructorUsedError;
  List<DamageItem> get items => throw _privateConstructorUsedError;

  /// Serializes this DamageReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DamageReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DamageReportCopyWith<DamageReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DamageReportCopyWith<$Res> {
  factory $DamageReportCopyWith(
    DamageReport value,
    $Res Function(DamageReport) then,
  ) = _$DamageReportCopyWithImpl<$Res, DamageReport>;
  @useResult
  $Res call({
    String id,
    String farmId,
    String farmerId,
    DateTime damageDate,
    DateTime documentationDate,
    String governorateId,
    String localityId,
    double? latitude,
    double? longitude,
    String statusId,
    String notes,
    String rowVersion,
    List<DamageItem> items,
  });
}

/// @nodoc
class _$DamageReportCopyWithImpl<$Res, $Val extends DamageReport>
    implements $DamageReportCopyWith<$Res> {
  _$DamageReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DamageReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? farmId = null,
    Object? farmerId = null,
    Object? damageDate = null,
    Object? documentationDate = null,
    Object? governorateId = null,
    Object? localityId = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? statusId = null,
    Object? notes = null,
    Object? rowVersion = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            farmId: null == farmId
                ? _value.farmId
                : farmId // ignore: cast_nullable_to_non_nullable
                      as String,
            farmerId: null == farmerId
                ? _value.farmerId
                : farmerId // ignore: cast_nullable_to_non_nullable
                      as String,
            damageDate: null == damageDate
                ? _value.damageDate
                : damageDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            documentationDate: null == documentationDate
                ? _value.documentationDate
                : documentationDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            governorateId: null == governorateId
                ? _value.governorateId
                : governorateId // ignore: cast_nullable_to_non_nullable
                      as String,
            localityId: null == localityId
                ? _value.localityId
                : localityId // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            statusId: null == statusId
                ? _value.statusId
                : statusId // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            rowVersion: null == rowVersion
                ? _value.rowVersion
                : rowVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<DamageItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DamageReportImplCopyWith<$Res>
    implements $DamageReportCopyWith<$Res> {
  factory _$$DamageReportImplCopyWith(
    _$DamageReportImpl value,
    $Res Function(_$DamageReportImpl) then,
  ) = __$$DamageReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String farmId,
    String farmerId,
    DateTime damageDate,
    DateTime documentationDate,
    String governorateId,
    String localityId,
    double? latitude,
    double? longitude,
    String statusId,
    String notes,
    String rowVersion,
    List<DamageItem> items,
  });
}

/// @nodoc
class __$$DamageReportImplCopyWithImpl<$Res>
    extends _$DamageReportCopyWithImpl<$Res, _$DamageReportImpl>
    implements _$$DamageReportImplCopyWith<$Res> {
  __$$DamageReportImplCopyWithImpl(
    _$DamageReportImpl _value,
    $Res Function(_$DamageReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DamageReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? farmId = null,
    Object? farmerId = null,
    Object? damageDate = null,
    Object? documentationDate = null,
    Object? governorateId = null,
    Object? localityId = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? statusId = null,
    Object? notes = null,
    Object? rowVersion = null,
    Object? items = null,
  }) {
    return _then(
      _$DamageReportImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        farmId: null == farmId
            ? _value.farmId
            : farmId // ignore: cast_nullable_to_non_nullable
                  as String,
        farmerId: null == farmerId
            ? _value.farmerId
            : farmerId // ignore: cast_nullable_to_non_nullable
                  as String,
        damageDate: null == damageDate
            ? _value.damageDate
            : damageDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        documentationDate: null == documentationDate
            ? _value.documentationDate
            : documentationDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        governorateId: null == governorateId
            ? _value.governorateId
            : governorateId // ignore: cast_nullable_to_non_nullable
                  as String,
        localityId: null == localityId
            ? _value.localityId
            : localityId // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        statusId: null == statusId
            ? _value.statusId
            : statusId // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        rowVersion: null == rowVersion
            ? _value.rowVersion
            : rowVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<DamageItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DamageReportImpl implements _DamageReport {
  const _$DamageReportImpl({
    required this.id,
    required this.farmId,
    required this.farmerId,
    required this.damageDate,
    required this.documentationDate,
    required this.governorateId,
    required this.localityId,
    this.latitude,
    this.longitude,
    required this.statusId,
    required this.notes,
    this.rowVersion = '',
    final List<DamageItem> items = const [],
  }) : _items = items;

  factory _$DamageReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$DamageReportImplFromJson(json);

  @override
  final String id;
  // ClientId
  @override
  final String farmId;
  @override
  final String farmerId;
  @override
  final DateTime damageDate;
  @override
  final DateTime documentationDate;
  @override
  final String governorateId;
  @override
  final String localityId;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String statusId;
  @override
  final String notes;
  @override
  @JsonKey()
  final String rowVersion;
  final List<DamageItem> _items;
  @override
  @JsonKey()
  List<DamageItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'DamageReport(id: $id, farmId: $farmId, farmerId: $farmerId, damageDate: $damageDate, documentationDate: $documentationDate, governorateId: $governorateId, localityId: $localityId, latitude: $latitude, longitude: $longitude, statusId: $statusId, notes: $notes, rowVersion: $rowVersion, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DamageReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.farmId, farmId) || other.farmId == farmId) &&
            (identical(other.farmerId, farmerId) ||
                other.farmerId == farmerId) &&
            (identical(other.damageDate, damageDate) ||
                other.damageDate == damageDate) &&
            (identical(other.documentationDate, documentationDate) ||
                other.documentationDate == documentationDate) &&
            (identical(other.governorateId, governorateId) ||
                other.governorateId == governorateId) &&
            (identical(other.localityId, localityId) ||
                other.localityId == localityId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.statusId, statusId) ||
                other.statusId == statusId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.rowVersion, rowVersion) ||
                other.rowVersion == rowVersion) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    farmId,
    farmerId,
    damageDate,
    documentationDate,
    governorateId,
    localityId,
    latitude,
    longitude,
    statusId,
    notes,
    rowVersion,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of DamageReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DamageReportImplCopyWith<_$DamageReportImpl> get copyWith =>
      __$$DamageReportImplCopyWithImpl<_$DamageReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DamageReportImplToJson(this);
  }
}

abstract class _DamageReport implements DamageReport {
  const factory _DamageReport({
    required final String id,
    required final String farmId,
    required final String farmerId,
    required final DateTime damageDate,
    required final DateTime documentationDate,
    required final String governorateId,
    required final String localityId,
    final double? latitude,
    final double? longitude,
    required final String statusId,
    required final String notes,
    final String rowVersion,
    final List<DamageItem> items,
  }) = _$DamageReportImpl;

  factory _DamageReport.fromJson(Map<String, dynamic> json) =
      _$DamageReportImpl.fromJson;

  @override
  String get id; // ClientId
  @override
  String get farmId;
  @override
  String get farmerId;
  @override
  DateTime get damageDate;
  @override
  DateTime get documentationDate;
  @override
  String get governorateId;
  @override
  String get localityId;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String get statusId;
  @override
  String get notes;
  @override
  String get rowVersion;
  @override
  List<DamageItem> get items;

  /// Create a copy of DamageReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DamageReportImplCopyWith<_$DamageReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
