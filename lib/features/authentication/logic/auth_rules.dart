/// Shared validation rules for all auth screens.
/// Each rule returns an error message, or null when the value is valid.
class AuthRules {
  AuthRules._();

  static final _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static String? name(String value) =>
      value.trim().isEmpty ? 'Please enter your full name' : null;

  static String? email(String value) {
    final v = value.trim();
    if (v.isEmpty) return 'Please enter your email';
    if (!_emailRegex.hasMatch(v)) return 'Please enter a valid email';
    return null;
  }

  static String? phone(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return 'Please enter your phone number';
    if (digits.length < 10 || digits.length > 15) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) return 'Please enter your password';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  /// The backend reset endpoint accepts passwords between 8 and 100 chars.
  static String? resetPassword(String value) {
    final error = password(value);
    if (error != null) return error;
    if (value.length > 100) return 'Password must be 100 characters or fewer';
    return null;
  }

  static String? resetCode(String value) {
    final v = value.trim();
    if (v.isEmpty) return 'Please enter the reset code';
    if (!RegExp(r'^\d{6}$').hasMatch(v)) return 'Reset code must be 6 digits';
    return null;
  }

  static String? confirmPassword(String value, String original) {
    if (value.isEmpty) return 'Please confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }
}
