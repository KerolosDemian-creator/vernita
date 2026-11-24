import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable(createToJson: false)
class ApiErrorModel {
  final String timestamp;
  final int status;
  final String error;
  final String message;
  final String? path;
  final Map<String, String>? validationErrors;

  ApiErrorModel({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.message,
    this.path,
    this.validationErrors,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  String get displayMessage {
    final errors = validationErrors;
    if (errors != null && errors.isNotEmpty) {
      return errors.values.join('\n');
    }
    return message;
  }
}
