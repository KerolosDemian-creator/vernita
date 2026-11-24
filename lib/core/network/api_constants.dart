class ApiEndPoints {
  static const String apiBaseUrl = 'http://10.0.2.2:8080';

  /// Auth Endpoints
  static const String signUp = '/api/v1/auth/register';
  static const String login = '/api/v1/auth/login';
  static const String forgotPassword = '/api/v1/auth/forgot-password';
  static const String resetPassword = '/api/v1/auth/reset-password';

  /// Cv Endpoints
  static const String uploadCv = '/api/v1/resumes/upload';
  static const String getCv = '/api/v1/resumes/me';

  static String deleteResume(int id) => '/api/v1/resumes/$id';

  static String downloadResume(int id) => '/api/v1/resumes/$id/download';

  /// Endpoints that must remain reachable without an access token.
  static const Set<String> publicPaths = {
    signUp,
    login,
    forgotPassword,
    resetPassword,
  };

  static bool isPublicPath(String path) {
    var normalizedPath = Uri.tryParse(path)?.path ?? path;
    if (normalizedPath.length > 1 && normalizedPath.endsWith('/')) {
      normalizedPath = normalizedPath.substring(0, normalizedPath.length - 1);
    }
    return publicPaths.contains(normalizedPath);
  }
}
