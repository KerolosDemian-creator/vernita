import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_request_model.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo signUpRepo;
  final LogInRepo logInRepo;
  final AuthTokenStorage authTokenStorage;
  TextEditingController fullNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SignUpCubit(this.signUpRepo, this.logInRepo, this.authTokenStorage)
    : super(const SignUpState.initial());

  Future<void> emitSignUpState(SignUpRequestModel signUpBodyRequest) async {
    emit(const SignUpState.loading());
    final result = await signUpRepo.signUp(signUpBodyRequest);

    await result.fold(
      (failure) async {
        if (isClosed) return;
        emit(
          SignUpState.failure(errMessage: failure.apiErrorModel.displayMessage),
        );
      },
      (user) async {
        // Registration does not create an authenticated session: after a
        // successful sign up the user goes back to Login and signs in there.
        if (isClosed) return;
        emit(SignUpState.success(user));
      },
    );
  }
}
