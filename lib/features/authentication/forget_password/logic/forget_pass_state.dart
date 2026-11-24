enum ForgetPassStatus { initial, loading, success, failure }

class ForgetPassState {
  const ForgetPassState({
    this.status = ForgetPassStatus.initial,
    this.message,
    this.email,
  });

  final ForgetPassStatus status;

  /// Error text on failure, confirmation text on success.
  final String? message;

  /// Email used for the reset request.
  final String? email;

  ForgetPassState copyWith({
    ForgetPassStatus? status,
    String? message,
    String? email,
  }) => ForgetPassState(
    status: status ?? this.status,
    message: message,
    email: email ?? this.email,
  );
}
