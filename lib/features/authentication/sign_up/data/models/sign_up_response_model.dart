import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response_model.g.dart';

@JsonSerializable()
class SignUpResponseModel {
  final String email;
  final String fullName;
  final int id;
  final String message;

  SignUpResponseModel({
    required this.email,
    required this.fullName,
    required this.id,
    required this.message,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseModelFromJson(json);
}
