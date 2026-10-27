import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vernita/core/helper/shared_pref_helper.dart';
import 'package:vernita/core/network/interceptors/auth_interceptor.dart';

class DioFactory {
  DioFactory._();

  static const Duration _requestTimeout = Duration(seconds: 30);
  static const String _authorizationHeader = 'Authorization';
  static Dio? _dio;

  /// Returns the single Dio instance used by all API clients.
  ///
  /// [readToken] and [onUnauthorized] are supplied by dependency injection so
  /// this core networking class does not depend on the DI container or on the
  /// authentication feature directly.
  static Dio getDio({
    AuthTokenReader? readToken,
    UnauthorizedHandler? onUnauthorized,
  }) {
    final existingDio = _dio;
    if (existingDio != null) return existingDio;

    final dio = Dio(
      BaseOptions(
        connectTimeout: _requestTimeout,
        receiveTimeout: _requestTimeout,
        sendTimeout: _requestTimeout,
        headers: const {'Accept': 'application/json'},
      ),
    );

    if (kDebugMode) {
      // Headers and bodies are intentionally not logged because they can
      // contain passwords, tokens, and personal data.
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      );
    }

    if (readToken != null && onUnauthorized != null) {
      dio.interceptors.add(
        AuthInterceptor(readToken: readToken, onUnauthorized: onUnauthorized),
      );
    }

    _dio = dio;
    return dio;
  }

  /// Loads the securely stored token into the default request headers.
  ///
  /// This must be awaited before API clients are used so a restored session
  /// cannot race against secure-token retrieval. The per-request
  /// [AuthInterceptor] remains the final guard for protected and public paths.
  static Future<void> addDioHeaders() async {
    final dio = _dio;
    if (dio == null) return;

    String token;
    try {
      token = (await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userToken,
      )).trim();
    } on Object {
      // The app can still start unauthenticated when secure storage is
      // temporarily unavailable. A later protected request will be rejected
      // by the backend and handled by the session flow.
      token = '';
    }

    dio.options.headers['Accept'] = 'application/json';
    _setAuthorizationHeader(dio, token);
  }

  /// Updates the in-memory Authorization header immediately after login.
  ///
  /// Passing an empty token removes the header, which is also used when the
  /// session is cleared.
  static void setTokenIntoHeaderAfterLogin(String token) {
    final dio = _dio;
    if (dio == null) return;

    _setAuthorizationHeader(dio, token.trim());
  }

  static void _setAuthorizationHeader(Dio dio, String token) {
    if (token.isEmpty) {
      dio.options.headers.remove(_authorizationHeader);
      return;
    }

    dio.options.headers[_authorizationHeader] = 'Bearer $token';
  }

  /// Clears the singleton so tests can start with a fresh Dio instance.
  @visibleForTesting
  static void reset() {
    _dio?.close(force: true);
    _dio = null;
  }
}
