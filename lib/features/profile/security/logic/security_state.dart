import '../data/models/session_model.dart';

enum SecurityStatus { initial, updating, passwordUpdated, loggedOut, failure }

enum PasswordField { current, next, confirm }

class SecurityState {
  const SecurityState({
    this.obscureCurrent = true,
    this.obscureNew = true,
    this.obscureConfirm = true,
    this.twoFactorEnabled = true,
    this.sessions = SessionModel.mock,
    this.status = SecurityStatus.initial,
    this.message,
  });

  final bool obscureCurrent;
  final bool obscureNew;
  final bool obscureConfirm;
  final bool twoFactorEnabled;
  final List<SessionModel> sessions;
  final SecurityStatus status;

  /// Error text on failure, confirmation text on success.
  final String? message;

  bool isObscured(PasswordField field) => switch (field) {
        PasswordField.current => obscureCurrent,
        PasswordField.next => obscureNew,
        PasswordField.confirm => obscureConfirm,
      };

  SecurityState copyWith({
    bool? obscureCurrent,
    bool? obscureNew,
    bool? obscureConfirm,
    bool? twoFactorEnabled,
    List<SessionModel>? sessions,
    SecurityStatus? status,
    String? message,
  }) =>
      SecurityState(
        obscureCurrent: obscureCurrent ?? this.obscureCurrent,
        obscureNew: obscureNew ?? this.obscureNew,
        obscureConfirm: obscureConfirm ?? this.obscureConfirm,
        twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
        sessions: sessions ?? this.sessions,
        status: status ?? this.status,
        message: message,
      );
}
