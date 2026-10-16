import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth_rules.dart';
import '../data/models/sign_up_request_model.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void toggleAgreed(bool value) =>
      emit(state.copyWith(agreed: value, status: SignUpStatus.initial));

  Future<void> submit({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: SignUpStatus.loading));

    final error = AuthRules.name(name) ??
        AuthRules.email(email) ??
        AuthRules.phone(phone) ??
        AuthRules.password(password) ??
        AuthRules.confirmPassword(confirmPassword, password) ??
        (state.agreed ? null : 'Please agree to the Terms and Privacy Policy');
    if (error != null) {
      emit(state.copyWith(status: SignUpStatus.failure, errorMessage: error));
      return;
    }

    // ignore: unused_local_variable
    final request = SignUpRequestModel(
      name: name.trim(),
      email: email.trim(),
      phone: phone.trim(),
      password: password,
    );
    // TODO: call the sign-up API / repo with `request`.

    emit(state.copyWith(status: SignUpStatus.success));
  }
}
