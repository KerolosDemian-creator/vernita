import 'package:dio/dio.dart';
import 'package:vernita/core/network/api_constants.dart';

typedef AuthTokenReader = Future<String?> Function();
typedef UnauthorizedHandler = Future<void> Function();

/// Attaches the stored access token to protected requests and invalidates the
/// session when a protected endpoint rejects that token with HTTP 401.
///
/// Public authentication endpoints never receive an Authorization header, and
/// their 401 responses (for example, invalid login credentials) do not clear a
/// session.
class AuthInterceptor extends Interceptor {
  const AuthInterceptor({
    required this.readToken,
    required this.onUnauthorized,
  });

  final AuthTokenReader readToken;
  final UnauthorizedHandler onUnauthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (ApiEndPoints.isPublicPath(options.path)) {
      options.headers.remove('Authorization');
      handler.next(options);
      return;
    }

    try {
      final token = (await readToken())?.trim();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        options.headers.remove('Authorization');
      }
    } on Object {
      // A storage failure must not prevent an unauthenticated request from
      // being attempted; protected endpoints will return 401 if necessary.
      options.headers.remove('Authorization');
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final wasAuthenticatedRequest = err.requestOptions.headers.containsKey(
      'Authorization',
    );
    final isProtectedRequest = !ApiEndPoints.isPublicPath(
      err.requestOptions.path,
    );

    if (err.response?.statusCode == 401 &&
        wasAuthenticatedRequest &&
        isProtectedRequest) {
      try {
        await onUnauthorized();
      } on Object {
        // The original request error remains the primary failure reported to
        // the caller.
      }
    }

    handler.next(err);
  }
}
