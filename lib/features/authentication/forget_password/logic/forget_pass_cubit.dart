import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth_rules.dart';
import '../data/models/forget_pass_request_model.dart';
import 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  ForgetPassCubit() : super(const ForgetPassState());

  Future<void> sendResetLink(String email) async {
    emit(state.copyWith(status: ForgetPassStatus.loading));

    final error = AuthRules.email(email);
    if (error != null) {
      emit(state.copyWith(status: ForgetPassStatus.failure, message: error));
      return;
    }

    // ignore: unused_local_variable
    final request = ForgetPassRequestModel(email: email.trim());
    // TODO: call the reset-password API / repo with `request`.

    emit(state.copyWith(
      status: ForgetPassStatus.success,
      message: 'Reset link sent! Check your email.',
    ));
  }
}
