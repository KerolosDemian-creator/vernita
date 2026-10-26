import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/forget_pass_request_model.dart';
import '../data/repo/forget_pass_repo.dart';
import 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  final ForgetPassRepo forgetPassRepo;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  ForgetPassCubit(this.forgetPassRepo) : super(const ForgetPassState());

  Future<void> sendResetCode() async {
    final email = emailController.text.trim();

    emit(state.copyWith(status: ForgetPassStatus.loading));
    final result = await forgetPassRepo.forgotPassword(
      ForgetPassRequestModel(email: email),
    );

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: ForgetPassStatus.failure,
            message: failure.apiErrorModel.displayMessage,
          ),
        );
      },
      (response) async {
        emit(
          state.copyWith(
            status: ForgetPassStatus.success,
            message: response.message,
            email: email,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
