import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/reset_pass_request_model.dart';
import '../data/repo/reset_pass_repo.dart';
import 'reset_pass_state.dart';

class ResetPassCubit extends Cubit<ResetPassState> {
  final ResetPassRepo resetPassRepo;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ResetPassCubit(this.resetPassRepo) : super(const ResetPassState());

  Future<void> resetPassword() async {
    emit(state.copyWith(status: ResetPassStatus.loading));
    final result = await resetPassRepo.resetPassword(
      ResetPassRequestModel(
        email: emailController.text.trim(),
        code: codeController.text.trim(),
        newPassword: passwordController.text,
      ),
    );

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: ResetPassStatus.failure,
            message: failure.apiErrorModel.displayMessage,
          ),
        );
      },
      (response) async {
        emit(
          state.copyWith(
            status: ResetPassStatus.success,
            message: response.message,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    codeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
