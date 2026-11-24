import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/network/dio_factory.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_request_model.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_request_model.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo signUpRepo;
  final LogInRepo logInRepo;
  final AuthSessionCubit authSessionCubit;
  TextEditingController fullNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SignUpCubit(this.signUpRepo, this.logInRepo, this.authSessionCubit)
    : super(const SignUpState.initial());

  @override
  Future<void> close() {
    fullNamecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmPasswordcontroller.dispose();
    return super.close();
  }

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
        // The register endpoint returns no access token, so we sign the new
        // user in right away with the same credentials. This goes through the
        // same AuthSessionCubit used by the login screen.
        final signedIn = await _signInAfterSignUp(signUpBodyRequest);
        if (isClosed) return;

        if (signedIn) {
          emit(SignUpState.success(user));
        } else {
          emit(
            const SignUpState.failure(
              errMessage:
                  'Your account was created, but we could not sign you in. Please log in.',
            ),
          );
        }
      },
    );
  }

  Future<bool> _signInAfterSignUp(SignUpRequestModel request) async {
    final loginResult = await logInRepo.logIn(
      LogInRequestModel(
        email: request.email,
        password: request.password,
        rememberMe: false,
      ),
    );

    return loginResult.fold((_) async => false, (response) async {
      try {
        await authSessionCubit.startSession(
          accessToken: response.accessToken,
          rememberMe: false,
        );
        DioFactory.setTokenIntoHeaderAfterLogin(response.accessToken);
        return true;
      } catch (_) {
        return false;
      }
    });
  }
}
