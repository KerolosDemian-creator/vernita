import 'package:flutter/services.dart';
import 'package:vernita/features/profile/profile/data/models/user_model.dart';

/// The profile fields the user can edit (the same ones the backend accepts).
/// Each field knows its label, keyboard, max length (same as the backend),
/// and how to read / write itself on a [UserModel].
enum ProfileField {
  fullName('Full Name', TextInputType.name, 150, required: true),
  phone('Phone Number', TextInputType.phone, 30),
  specialization('Specialization', TextInputType.text, 150),
  careerTarget('Target Track', TextInputType.text, 255);

  const ProfileField(
    this.label,
    this.keyboard,
    this.maxLength, {
    this.required = false,
  });

  final String label;
  final TextInputType keyboard;
  final int maxLength;
  final bool required;

  String read(UserModel user) => switch (this) {
    ProfileField.fullName => user.fullName,
    ProfileField.phone => user.phone,
    ProfileField.specialization => user.specialization,
    ProfileField.careerTarget => user.careerTarget,
  };

  UserModel write(UserModel user, String value) => switch (this) {
    ProfileField.fullName => user.copyWith(fullName: value),
    ProfileField.phone => user.copyWith(phone: value),
    ProfileField.specialization => user.copyWith(specialization: value),
    ProfileField.careerTarget => user.copyWith(careerTarget: value),
  };

  /// Returns an error message, or null when the value is fine.
  String? validate(String value) {
    if (required && value.isEmpty) return '$label is required';
    if (value.length > maxLength) {
      return '$label must not exceed $maxLength characters';
    }
    return null;
  }
}
