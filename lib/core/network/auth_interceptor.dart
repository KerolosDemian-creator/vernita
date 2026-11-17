import 'package:dio/dio.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';

/// Adds "Authorization: Bearer <token>" to every request that needs login.
/// The backend uses it to know which user is calling.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final AuthTokenStorage _tokenStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // login / register / forgot-password are public, no token needed.
    final isPublic = options.path.contains('/auth/');

    if (!isPublic) {
      final token = await _tokenStorage.readToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }
}
