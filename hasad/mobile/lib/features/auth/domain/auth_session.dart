import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

/// Authenticated session data returned by the backend auth endpoints
/// (`/accounts/login` and `/accounts/refresh`).
@freezed
class AuthSession with _$AuthSession {
  /// Creates an [AuthSession].
  const factory AuthSession({
    required String token,
    required String refreshToken,
    required String userId,
    required String email,
    required String fullName,
    String? governorateId,
    String? directorateId,
    @Default([]) List<String> roles,
  }) = _AuthSession;

  /// Deserializes an [AuthSession] from the backend `data` payload.
  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}
