enum ForgetPassStatus { initial, loading, success, failure }

class ForgetPassState {
  const ForgetPassState({
    this.status = ForgetPassStatus.initial,
    this.message,
  });

  final ForgetPassStatus status;

  /// Error text on failure, confirmation text on success.
  final String? message;

  ForgetPassState copyWith({ForgetPassStatus? status, String? message}) =>
      ForgetPassState(status: status ?? this.status, message: message);
}
