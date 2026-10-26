import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_request_model.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final LogInRepo logInRepo;
  final AuthTokenStorage authTokenStorage;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LogInCubit(this.logInRepo, this.authTokenStorage) : super(const LogInState());

  void toggleRememberMe(bool value) =>
      emit(state.copyWith(rememberMe: value, status: LogInStatus.initial));

  Future<void> submit() async {
    final request = LogInRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text,
      rememberMe: state.rememberMe,
    );

    emit(state.copyWith(status: LogInStatus.loading));
    final result = await logInRepo.logIn(request);

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: LogInStatus.failure,
            errorMessage: failure.apiErrorModel.displayMessage,
          ),
        );
      },
      (response) async {
        try {
          await authTokenStorage.saveToken(
            accessToken: response.accessToken,
            rememberMe: request.rememberMe,
          );
          emit(state.copyWith(status: LogInStatus.success, response: response));
        } catch (_) {
          emit(
            state.copyWith(
              status: LogInStatus.failure,
              errorMessage: 'Could not save your session. Please try again.',
            ),
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}