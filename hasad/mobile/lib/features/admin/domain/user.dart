import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String fullName,
    required String userName,
    required String email,
    required String phoneNumber,
    required String role,
    String? governorateId,
    String? governorateName,
    String? directorateId,
    String? directorateName,
    required bool isActive,
    required DateTime createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
