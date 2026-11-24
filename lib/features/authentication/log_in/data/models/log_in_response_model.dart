import 'package:json_annotation/json_annotation.dart';

part 'log_in_response_model.g.dart';

@JsonSerializable(createToJson: false)
class LogInResponseModel {
  final int id;
  final String fullName;
  final String email;
  final String message;
  final String accessToken;
  final String tokenType;

  LogInResponseModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LogInResponseModelFromJson(json);
}
