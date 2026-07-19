// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compensation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Compensation _$CompensationFromJson(Map<String, dynamic> json) {
  return _Compensation.fromJson(json);
}

/// @nodoc
mixin _$Compensation {
  String get id => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get damageReportId => throw _privateConstructorUsedError;
  double get calculatedAmount => throw _privateConstructorUsedError;
  double get approvedAmount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get remarks => throw _privateConstructorUsedError;
  String get rowVersion => throw _privateConstructorUsedError;

  /// Serializes this Compensation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Compensation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompensationCopyWith<Compensation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompensationCopyWith<$Res> {
  factory $CompensationCopyWith(
    Compensation value,
    $Res Function(Compensation) then,
  ) = _$CompensationCopyWithImpl<$Res, Compensation>;
  @useResult
  $Res call({
    String id,
    String clientId,
    String damageReportId,
    double calculatedAmount,
    double approvedAmount,
    String status,
    String remarks,
    String rowVersion,
  });
}

/// @nodoc
class _$CompensationCopyWithImpl<$Res, $Val extends Compensation>
    implements $CompensationCopyWith<$Res> {
  _$CompensationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Compensation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? damageReportId = null,
    Object? calculatedAmount = null,
    Object? approvedAmount = null,
    Object? status = null,
    Object? remarks = null,
    Object? rowVersion = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as String,
            damageReportId: null == damageReportId
                ? _value.damageReportId
                : damageReportId // ignore: cast_nullable_to_non_nullable
                      as String,
            calculatedAmount: null == calculatedAmount
                ? _value.calculatedAmount
                : calculatedAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            approvedAmount: null == approvedAmount
                ? _value.approvedAmount
                : approvedAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            remarks: null == remarks
                ? _value.remarks
                : remarks // ignore: cast_nullable_to_non_nullable
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
abstract class _$$CompensationImplCopyWith<$Res>
    implements $CompensationCopyWith<$Res> {
  factory _$$CompensationImplCopyWith(
    _$CompensationImpl value,
    $Res Function(_$CompensationImpl) then,
  ) = __$$CompensationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String clientId,
    String damageReportId,
    double calculatedAmount,
    double approvedAmount,
    String status,
    String remarks,
    String rowVersion,
  });
}

/// @nodoc
class __$$CompensationImplCopyWithImpl<$Res>
    extends _$CompensationCopyWithImpl<$Res, _$CompensationImpl>
    implements _$$CompensationImplCopyWith<$Res> {
  __$$CompensationImplCopyWithImpl(
    _$CompensationImpl _value,
    $Res Function(_$CompensationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Compensation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientId = null,
    Object? damageReportId = null,
    Object? calculatedAmount = null,
    Object? approvedAmount = null,
    Object? status = null,
    Object? remarks = null,
    Object? rowVersion = null,
  }) {
    return _then(
      _$CompensationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as String,
        damageReportId: null == damageReportId
            ? _value.damageReportId
            : damageReportId // ignore: cast_nullable_to_non_nullable
                  as String,
        calculatedAmount: null == calculatedAmount
            ? _value.calculatedAmount
            : calculatedAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        approvedAmount: null == approvedAmount
            ? _value.approvedAmount
            : approvedAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        remarks: null == remarks
            ? _value.remarks
            : remarks // ignore: cast_nullable_to_non_nullable
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
class _$CompensationImpl implements _Compensation {
  const _$CompensationImpl({
    required this.id,
    required this.clientId,
    required this.damageReportId,
    required this.calculatedAmount,
    required this.approvedAmount,
    required this.status,
    required this.remarks,
    required this.rowVersion,
  });

  factory _$CompensationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompensationImplFromJson(json);

  @override
  final String id;
  @override
  final String clientId;
  @override
  final String damageReportId;
  @override
  final double calculatedAmount;
  @override
  final double approvedAmount;
  @override
  final String status;
  @override
  final String remarks;
  @override
  final String rowVersion;

  @override
  String toString() {
    return 'Compensation(id: $id, clientId: $clientId, damageReportId: $damageReportId, calculatedAmount: $calculatedAmount, approvedAmount: $approvedAmount, status: $status, remarks: $remarks, rowVersion: $rowVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompensationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.damageReportId, damageReportId) ||
                other.damageReportId == damageReportId) &&
            (identical(other.calculatedAmount, calculatedAmount) ||
                other.calculatedAmount == calculatedAmount) &&
            (identical(other.approvedAmount, approvedAmount) ||
                other.approvedAmount == approvedAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.rowVersion, rowVersion) ||
                other.rowVersion == rowVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    clientId,
    damageReportId,
    calculatedAmount,
    approvedAmount,
    status,
    remarks,
    rowVersion,
  );

  /// Create a copy of Compensation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompensationImplCopyWith<_$CompensationImpl> get copyWith =>
      __$$CompensationImplCopyWithImpl<_$CompensationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompensationImplToJson(this);
  }
}

abstract class _Compensation implements Compensation {
  const factory _Compensation({
    required final String id,
    required final String clientId,
    required final String damageReportId,
    required final double calculatedAmount,
    required final double approvedAmount,
    required final String status,
    required final String remarks,
    required final String rowVersion,
  }) = _$CompensationImpl;

  factory _Compensation.fromJson(Map<String, dynamic> json) =
      _$CompensationImpl.fromJson;

  @override
  String get id;
  @override
  String get clientId;
  @override
  String get damageReportId;
  @override
  double get calculatedAmount;
  @override
  double get approvedAmount;
  @override
  String get status;
  @override
  String get remarks;
  @override
  String get rowVersion;

  /// Create a copy of Compensation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompensationImplCopyWith<_$CompensationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
