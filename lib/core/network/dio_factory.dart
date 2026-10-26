import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) return _dio!;

    const timeOut = Duration(seconds: 30);
    final dio = Dio()
      ..options.connectTimeout = timeOut
      ..options.receiveTimeout = timeOut;

    if (kDebugMode) {
      dio.interceptors.add(
        // Auth payloads contain credentials and access tokens. Never log
        // their bodies; the error logger bypasses the responseBody flag.
        PrettyDioLogger(
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: false,
          error: false,
        ),
      );
    }

    _dio = dio;
    return dio;
  }
}
