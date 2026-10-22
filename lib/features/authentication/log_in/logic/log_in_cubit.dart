import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth_rules.dart';
import '../data/models/log_in_request_model.dart';
import 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(const LogInState());

  void toggleRememberMe(bool value) =>
      emit(state.copyWith(rememberMe: value, status: LogInStatus.initial));

  Future<void> submit({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: LogInStatus.loading));

    final error = AuthRules.email(email) ?? AuthRules.password(password);
    if (error != null) {
      emit(state.copyWith(status: LogInStatus.failure, errorMessage: error));
      return;
    }

    // ignore: unused_local_variable
    final request = LogInRequestModel(
      email: email.trim(),
      password: password,
      rememberMe: state.rememberMe,
    );
    // TODO: call the login API / repo with `request`.

    emit(state.copyWith(status: LogInStatus.success));
  }
}
