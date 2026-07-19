// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginatedList<T> _$PaginatedListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _PaginatedList<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PaginatedList<T> {
  List<T> get items => throw _privateConstructorUsedError;
  int get pageNumber => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  /// Serializes this PaginatedList to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PaginatedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedListCopyWith<T, PaginatedList<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedListCopyWith<T, $Res> {
  factory $PaginatedListCopyWith(
    PaginatedList<T> value,
    $Res Function(PaginatedList<T>) then,
  ) = _$PaginatedListCopyWithImpl<T, $Res, PaginatedList<T>>;
  @useResult
  $Res call({List<T> items, int pageNumber, int totalPages, int totalCount});
}

/// @nodoc
class _$PaginatedListCopyWithImpl<T, $Res, $Val extends PaginatedList<T>>
    implements $PaginatedListCopyWith<T, $Res> {
  _$PaginatedListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? pageNumber = null,
    Object? totalPages = null,
    Object? totalCount = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            pageNumber: null == pageNumber
                ? _value.pageNumber
                : pageNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedListImplCopyWith<T, $Res>
    implements $PaginatedListCopyWith<T, $Res> {
  factory _$$PaginatedListImplCopyWith(
    _$PaginatedListImpl<T> value,
    $Res Function(_$PaginatedListImpl<T>) then,
  ) = __$$PaginatedListImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> items, int pageNumber, int totalPages, int totalCount});
}

/// @nodoc
class __$$PaginatedListImplCopyWithImpl<T, $Res>
    extends _$PaginatedListCopyWithImpl<T, $Res, _$PaginatedListImpl<T>>
    implements _$$PaginatedListImplCopyWith<T, $Res> {
  __$$PaginatedListImplCopyWithImpl(
    _$PaginatedListImpl<T> _value,
    $Res Function(_$PaginatedListImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? pageNumber = null,
    Object? totalPages = null,
    Object? totalCount = null,
  }) {
    return _then(
      _$PaginatedListImpl<T>(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        pageNumber: null == pageNumber
            ? _value.pageNumber
            : pageNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PaginatedListImpl<T> implements _PaginatedList<T> {
  const _$PaginatedListImpl({
    required final List<T> items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
  }) : _items = items;

  factory _$PaginatedListImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$PaginatedListImplFromJson(json, fromJsonT);

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int pageNumber;
  @override
  final int totalPages;
  @override
  final int totalCount;

  @override
  String toString() {
    return 'PaginatedList<$T>(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedListImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.pageNumber, pageNumber) ||
                other.pageNumber == pageNumber) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    pageNumber,
    totalPages,
    totalCount,
  );

  /// Create a copy of PaginatedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedListImplCopyWith<T, _$PaginatedListImpl<T>> get copyWith =>
      __$$PaginatedListImplCopyWithImpl<T, _$PaginatedListImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PaginatedListImplToJson<T>(this, toJsonT);
  }
}

abstract class _PaginatedList<T> implements PaginatedList<T> {
  const factory _PaginatedList({
    required final List<T> items,
    required final int pageNumber,
    required final int totalPages,
    required final int totalCount,
  }) = _$PaginatedListImpl<T>;

  factory _PaginatedList.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$PaginatedListImpl<T>.fromJson;

  @override
  List<T> get items;
  @override
  int get pageNumber;
  @override
  int get totalPages;
  @override
  int get totalCount;

  /// Create a copy of PaginatedList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedListImplCopyWith<T, _$PaginatedListImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
