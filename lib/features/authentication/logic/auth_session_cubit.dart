import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/logic/auth_session_state.dart';

/// Owns the application-wide authentication state.
///
/// It is initialized from the persisted token before the first route is shown,
/// updated after a successful login, and cleared on logout or when the backend
/// rejects a protected request with HTTP 401.
class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._tokenStorage)
    : super(const AuthSessionState.initializing());

  final AuthTokenStorage _tokenStorage;
  bool _isClearingSession = false;

  bool get isLoggedInUser => state.isLoggedInUser;

  /// Restores the session from the token persisted by a previous app launch.
  Future<void> restoreSession() async {
    try {
      final token = await _tokenStorage.readToken();
      final hasUsableToken =
          token != null && _tokenStorage.isTokenUsable(token);

      if (!hasUsableToken) {
        // Remove missing, empty, or expired values so the persisted store does
        // not disagree with the restored in-memory session.
        await _tokenStorage.clearToken();
      }

      emit(
        hasUsableToken
            ? const AuthSessionState.authenticated()
            : const AuthSessionState.unauthenticated(),
      );
    } on Object {
      emit(const AuthSessionState.unauthenticated());
    }
  }

  /// Persists the token returned by a successful login and marks the user as
  /// authenticated.
  Future<void> startSession({
    required String accessToken,
    required bool rememberMe,
  }) async {
    await _tokenStorage.saveToken(
      accessToken: accessToken,
      rememberMe: rememberMe,
    );
    emit(const AuthSessionState.authenticated());
  }

  /// Clears the session and the persisted token during an explicit logout.
  Future<void> logout() => _clearSession(onlyWhenAuthenticated: false);

  /// Clears the session after the backend rejects a protected request.
  Future<void> invalidateSession() =>
      _clearSession(onlyWhenAuthenticated: true);

  Future<void> _clearSession({required bool onlyWhenAuthenticated}) async {
    if (onlyWhenAuthenticated && !state.isLoggedInUser) return;
    if (_isClearingSession) return;

    _isClearingSession = true;
    try {
      await _tokenStorage.clearToken();
      if (state.isLoggedInUser) {
        emit(const AuthSessionState.unauthenticated());
      }
    } finally {
      _isClearingSession = false;
    }
  }
}
