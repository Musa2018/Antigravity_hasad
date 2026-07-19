import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  static const String _tokenKey = 'jwt_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _rememberEmailKey = 'remembered_email';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> saveRememberedEmail(String? email) async {
    if (email == null) {
      await _storage.delete(key: _rememberEmailKey);
    } else {
      await _storage.write(key: _rememberEmailKey, value: email);
    }
  }

  Future<String?> getRememberedEmail() async {
    return await _storage.read(key: _rememberEmailKey);
  }

  Future<void> clearAll() async {
    final email = await getRememberedEmail();
    await _storage.deleteAll();
    if (email != null) {
      await saveRememberedEmail(email);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
