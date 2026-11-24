/// The lifecycle of the current authentication session.
enum AuthSessionStatus { initializing, authenticated, unauthenticated }

class AuthSessionState {
  const AuthSessionState(this.status);

  const AuthSessionState.initializing() : this(AuthSessionStatus.initializing);

  const AuthSessionState.authenticated()
    : this(AuthSessionStatus.authenticated);

  const AuthSessionState.unauthenticated()
    : this(AuthSessionStatus.unauthenticated);

  final AuthSessionStatus status;

  bool get isInitializing => status == AuthSessionStatus.initializing;

  /// The single in-memory source of truth for the current login state.
  bool get isLoggedInUser => status == AuthSessionStatus.authenticated;
}
