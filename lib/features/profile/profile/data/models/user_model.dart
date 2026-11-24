import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// The backend may name the id `userId` or `id`; accept both.
Object? _readUserId(Map<dynamic, dynamic> json, String key) =>
    json['userId'] ?? json['id'];

/// Response of GET / PUT  /api/v1/users/me
@JsonSerializable(createToJson: false)
class UserModel {
  const UserModel({
    required this.userId,
    required this.fullName,
    required this.email,
    this.phone = '',
    this.avatarUrl,
    this.specialization = '',
    this.careerTarget = '',
  });

  @JsonKey(readValue: _readUserId)
  final int userId;
  final String fullName;
  final String email;

  // The backend sends null when the user never filled these,
  // so we turn null into '' and the UI shows "Not set".
  @JsonKey(defaultValue: '')
  final String phone;

  final String? avatarUrl;

  @JsonKey(defaultValue: '')
  final String specialization;

  @JsonKey(defaultValue: '')
  final String careerTarget;

  bool get hasAvatar => avatarUrl != null && avatarUrl!.isNotEmpty;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel copyWith({
    String? fullName,
    String? phone,
    String? specialization,
    String? careerTarget,
  }) => UserModel(
    userId: userId,
    fullName: fullName ?? this.fullName,
    email: email, // email can't be changed from the app
    phone: phone ?? this.phone,
    avatarUrl: avatarUrl,
    specialization: specialization ?? this.specialization,
    careerTarget: careerTarget ?? this.careerTarget,
  );
}
