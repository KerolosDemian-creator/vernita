import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel {
  const SignUpRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
  @JsonKey(name: 'fullName')
  final String name;
  final String email;
  final String phone;
  final String password;

  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);
}
