import 'dart:convert';

import 'package:vernita/core/helper/shared_pref_helper.dart';

/// Persists and restores the authentication access token.
///
/// Physical storage is delegated to [SharedPrefHelper] secure storage; this
/// class only adds remember-me, in-memory caching, and JWT expiry semantics.
/// The token is kept in memory for the current app session and is only written
/// to secure storage when "Remember me" is enabled, preserving the existing
/// login behavior.
class AuthTokenStorage {
  String? _cachedAccessToken;

  Future<void> saveToken({
    required String accessToken,
    required bool rememberMe,
  }) async {
    final normalizedToken = accessToken.trim();
    if (normalizedToken.isEmpty) {
      throw ArgumentError.value(
        accessToken,
        'accessToken',
        'The access token cannot be empty.',
      );
    }

    if (rememberMe) {
      await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.userToken,
        normalizedToken,
      );
      final persistedToken = (await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      )).trim();
      if (persistedToken != normalizedToken) {
        throw StateError('Could not persist the authentication token.');
      }
    } else {
      await SharedPrefHelper.removeSecuredData(SharedPrefKeys.userToken);
      final persistedToken = (await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      )).trim();
      if (persistedToken.isNotEmpty) {
        throw StateError('Could not clear the persisted authentication token.');
      }
    }

    _cachedAccessToken = normalizedToken;
  }

  Future<String?> readToken() async {
    final cachedToken = _cachedAccessToken;
    if (cachedToken != null) return cachedToken;

    final storedToken = (await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    )).trim();
    if (storedToken.isEmpty) return null;

    _cachedAccessToken = storedToken;
    return storedToken;
  }

  /// Returns whether [token] can be used for a new authenticated request.
  ///
  /// The backend issues JWTs with an `exp` claim. If that claim is present and
  /// already in the past, the token is known to be unusable and should not
  /// restore an authenticated session. Opaque/non-JWT values are treated as
  /// usable based on presence alone.
  bool isTokenUsable(String token) {
    if (token.trim().isEmpty) return false;

    final expiration = _extractExpiration(token);
    if (expiration == null) return true;

    return expiration.isAfter(DateTime.now().toUtc());
  }

  Future<bool> hasUsableToken() async {
    final token = await readToken();
    return token != null && isTokenUsable(token);
  }

  Future<void> clearToken() async {
    await SharedPrefHelper.removeSecuredData(SharedPrefKeys.userToken);
    final persistedToken = (await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    )).trim();
    if (persistedToken.isNotEmpty) {
      throw StateError('Could not clear the persisted authentication token.');
    }
    _cachedAccessToken = null;
  }

  DateTime? _extractExpiration(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return null;

    try {
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      if (payload is! Map<String, dynamic>) return null;

      final expiration = payload['exp'];
      if (expiration is! num) return null;

      return DateTime.fromMillisecondsSinceEpoch(
        (expiration * 1000).round(),
        isUtc: true,
      );
    } on Object {
      // A malformed payload is not proof that the token has expired.
      return null;
    }
  }
}
