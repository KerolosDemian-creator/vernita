import 'package:json_annotation/json_annotation.dart';

part 'log_in_request_model.g.dart';

@JsonSerializable(createFactory: false)
class LogInRequestModel {
  const LogInRequestModel({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  final String email;
  final String password;

  /// Client-side preference only. Never serialized into the login request.
  @JsonKey(includeToJson: false)
  final bool rememberMe;

  Map<String, dynamic> toJson() => _$LogInRequestModelToJson(this);
}
