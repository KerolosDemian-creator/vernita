enum LogInStatus { initial, loading, success, failure }

class LogInState {
  const LogInState({
    this.rememberMe = true,
    this.status = LogInStatus.initial,
    this.errorMessage,
  });

  final bool rememberMe;
  final LogInStatus status;
  final String? errorMessage;

  LogInState copyWith({
    bool? rememberMe,
    LogInStatus? status,
    String? errorMessage,
  }) =>
      LogInState(
        rememberMe: rememberMe ?? this.rememberMe,
        status: status ?? this.status,
        errorMessage: errorMessage,
      );
}
