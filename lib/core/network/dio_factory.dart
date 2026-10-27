import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:vernita/core/network/interceptors/auth_interceptor.dart';

class DioFactory {
  DioFactory._();

  static const Duration _requestTimeout = Duration(seconds: 30);
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
      // Request/response headers and bodies are intentionally not logged
      // because they can contain passwords, tokens, and personal data.
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
}
