enum SignUpStatus { initial, loading, success, failure }

class SignUpState {
  const SignUpState({
    this.agreed = true,
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });

  final bool agreed;
  final SignUpStatus status;
  final String? errorMessage;

  SignUpState copyWith({
    bool? agreed,
    SignUpStatus? status,
    String? errorMessage,
  }) =>
      SignUpState(
        agreed: agreed ?? this.agreed,
        status: status ?? this.status,
        errorMessage: errorMessage,
      );
}
