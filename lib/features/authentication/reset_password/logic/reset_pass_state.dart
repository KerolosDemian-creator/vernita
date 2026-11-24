enum ResetPassStatus { initial, loading, success, failure }

class ResetPassState {
  const ResetPassState({this.status = ResetPassStatus.initial, this.message});

  final ResetPassStatus status;

  /// Error text on failure, confirmation text on success.
  final String? message;

  ResetPassState copyWith({ResetPassStatus? status, String? message}) =>
      ResetPassState(status: status ?? this.status, message: message);
}
