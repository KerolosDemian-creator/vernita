import 'package:json_annotation/json_annotation.dart';

part 'reset_pass_request_model.g.dart';

@JsonSerializable(createFactory: false)
class ResetPassRequestModel {
  const ResetPassRequestModel({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  final String email;
  final String code;
  final String newPassword;

  Map<String, dynamic> toJson() => _$ResetPassRequestModelToJson(this);
}
