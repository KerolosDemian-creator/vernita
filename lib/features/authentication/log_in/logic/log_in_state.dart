import 'package:vernita/features/authentication/log_in/data/models/log_in_response_model.dart';

enum LogInStatus { initial, loading, success, failure }

class LogInState {
  const LogInState({
    this.rememberMe = true,
    this.status = LogInStatus.initial,
    this.errorMessage,
    this.response,
  });

  final bool rememberMe;
  final LogInStatus status;
  final String? errorMessage;
  final LogInResponseModel? response;

  LogInState copyWith({
    bool? rememberMe,
    LogInStatus? status,
    String? errorMessage,
    LogInResponseModel? response,
  }) => LogInState(
    rememberMe: rememberMe ?? this.rememberMe,
    status: status ?? this.status,
    errorMessage: errorMessage,
    response: response,
  );
}
