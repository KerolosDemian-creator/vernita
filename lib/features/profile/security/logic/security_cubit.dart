import 'package:flutter_bloc/flutter_bloc.dart';

import 'security_state.dart';

class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit() : super(const SecurityState());

  void toggleObscure(PasswordField field) {
    emit(switch (field) {
      PasswordField.current =>
        state.copyWith(obscureCurrent: !state.obscureCurrent),
      PasswordField.next => state.copyWith(obscureNew: !state.obscureNew),
      PasswordField.confirm =>
        state.copyWith(obscureConfirm: !state.obscureConfirm),
    });
  }

  void toggleTwoFactor(bool value) =>
      emit(state.copyWith(twoFactorEnabled: value));

  Future<void> updatePassword({
    required String current,
    required String newPassword,
    required String confirm,
  }) async {
    emit(state.copyWith(status: SecurityStatus.updating));

    String? error;
    if (current.isEmpty) {
      error = 'Please enter your current password';
    } else if (newPassword.length < 6) {
      error = 'New password must be at least 6 characters';
    } else if (newPassword == current) {
      error = 'New password must be different from the current one';
    } else if (newPassword != confirm) {
      error = 'Passwords do not match';
    }

    if (error != null) {
      emit(state.copyWith(status: SecurityStatus.failure, message: error));
      return;
    }

    // TODO: call the change-password API / repo.
    emit(state.copyWith(
      status: SecurityStatus.passwordUpdated,
      message: 'Password updated successfully',
    ));
  }

  /// Keeps only the current device signed in.
  void logOutAll() {
    emit(state.copyWith(
      sessions: state.sessions.where((s) => s.isCurrent).toList(),
      status: SecurityStatus.loggedOut,
      message: 'Logged out from all other devices',
    ));
    // TODO: call the API to revoke the other sessions.
  }
}
