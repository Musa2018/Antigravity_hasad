import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_list.freezed.dart';
part 'paginated_list.g.dart';

@Freezed(genericArgumentFactories: true)
class PaginatedList<T> with _$PaginatedList<T> {
  const factory PaginatedList({
    required List<T> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
  }) = _PaginatedList<T>;

  factory PaginatedList.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PaginatedListFromJson(json, fromJsonT);
}
