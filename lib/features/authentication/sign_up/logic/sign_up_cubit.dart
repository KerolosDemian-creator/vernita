import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_request_model.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo signUpRepo;
  TextEditingController fullNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SignUpCubit(this.signUpRepo) : super(const SignUpState.initial());

  Future<void> emitSignUpState(SignUpRequestModel signUpBodyRequest) async {
    emit(const SignUpState.loading());
    final result = await signUpRepo.signUp(signUpBodyRequest);
    result.fold(
      (failure) =>
          emit(SignUpState.failure(errMessage: failure.apiErrorModel.message)),
      (user) => emit(SignUpState.success(user)),
    );
  }
}
