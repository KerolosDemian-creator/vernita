import 'package:json_annotation/json_annotation.dart';
import 'package:vernita/features/profile/profile/data/models/user_model.dart';

part 'update_profile_request_model.g.dart';

/// Body of PUT /api/v1/users/me
///
/// The backend REPLACES the whole profile, so we always send every field
/// (the ones that didn't change keep their current value).
@JsonSerializable(createFactory: false)
class UpdateProfileRequestModel {
  const UpdateProfileRequestModel({
    required this.fullName,
    required this.phone,
    required this.avatarUrl,
    required this.specialization,
    required this.careerTarget,
  });

  /// Builds the request from the user we already have (with the new value).
  factory UpdateProfileRequestModel.fromUser(UserModel user) =>
      UpdateProfileRequestModel(
        fullName: user.fullName,
        phone: user.phone,
        avatarUrl: user.avatarUrl,
        specialization: user.specialization,
        careerTarget: user.careerTarget,
      );

  final String fullName;
  final String phone;
  final String? avatarUrl;
  final String specialization;
  final String careerTarget;

  Map<String, dynamic> toJson() => _$UpdateProfileRequestModelToJson(this);
}
