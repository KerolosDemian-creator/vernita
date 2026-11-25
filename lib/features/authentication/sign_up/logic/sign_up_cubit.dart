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

  Future<void> emitSignUpState(SignUpRequestModel signUpBodyRequest) async {
    emit(const SignUpState.loading());
    final result = await signUpRepo.signUp(signUpBodyRequest);

    await result.fold(
      (failure) async => emit(
        SignUpState.failure(errMessage: failure.apiErrorModel.displayMessage),
      ),
      (user) async {
        // الحساب اتعمل، نسجل دخول تلقائي عشان نجيب التوكن ونبدأ السيشن.
        final login = await logInRepo.logIn(
          LogInRequestModel(
            email: signUpBodyRequest.email,
            password: signUpBodyRequest.password,
            rememberMe: true,
          ),
        );

        await login.fold(
          (failure) async => emit(
            SignUpState.failure(
              errMessage: failure.apiErrorModel.displayMessage,
            ),
          ),
          (response) async {
            try {
              await authSessionCubit.startSession(
                accessToken: response.accessToken,
                rememberMe: true,
              );
              DioFactory.setTokenIntoHeaderAfterLogin(response.accessToken);
              emit(SignUpState.success(user));
            } catch (_) {
              emit(
                const SignUpState.failure(
                  errMessage: 'Account created, but we could not sign you in. '
                      'Please log in manually.',
                ),
              );
            }
          },
        );
      },
    );
  }
}