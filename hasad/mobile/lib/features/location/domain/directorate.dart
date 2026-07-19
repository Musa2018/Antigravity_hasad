import 'package:freezed_annotation/freezed_annotation.dart';

part 'directorate.freezed.dart';
part 'directorate.g.dart';

@freezed
class Directorate with _$Directorate {
  const factory Directorate({
    required String id,
    required String nameAr,
    required String nameEn,
    required String governorateId,
  }) = _Directorate;

  factory Directorate.fromJson(Map<String, dynamic> json) =>
      _$DirectorateFromJson(json);
}
