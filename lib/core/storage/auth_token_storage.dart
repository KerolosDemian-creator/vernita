import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenStorage {
  static const String _accessTokenKey = 'auth_access_token';

  String? _cachedAccessToken;

  Future<void> saveToken({
    required String accessToken,
    required bool rememberMe,
  }) async {
    _cachedAccessToken = accessToken;

    final preferences = await SharedPreferences.getInstance();
    if (rememberMe) {
      await preferences.setString(_accessTokenKey, accessToken);
    } else {
      await preferences.remove(_accessTokenKey);
    }
  }

  Future<String?> readToken() async {
    final cachedToken = _cachedAccessToken;
    if (cachedToken != null) return cachedToken;

    final preferences = await SharedPreferences.getInstance();
    _cachedAccessToken = preferences.getString(_accessTokenKey);
    return _cachedAccessToken;
  }

  Future<void> clearToken() async {
    _cachedAccessToken = null;

    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_accessTokenKey);
  }
}
